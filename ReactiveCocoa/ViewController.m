//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by mac on 3/4/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SignInService.h"

@interface ViewController ()
@property (strong, nonatomic) SignInService *signInService;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
//	[self.usernameTextField.rac_textSignal subscribeNext:^(id x) {
//		NSLog(@"%@",x);
//	}];
//	[[self.usernameTextField.rac_textSignal filter:^BOOL(NSString *text) {
//		return text.length > 3;
//	}] subscribeNext:^(id x) {
//		NSLog(@"%@",x);
//	}];
	
//	[[[self.usernameTextField.rac_textSignal map:^id(NSString *text) {
//		return @(text.length);
//	}] filter:^BOOL(NSNumber *length) {
//		return [length integerValue] > 3;
//	}] subscribeNext:^(id x) {
//		NSLog(@"%@",x);
//	}];
	
//	RACSignal *usernameSourceSignal = self.usernameTextField.rac_textSignal;
//	
//	RACSignal *filteredUsername = [usernameSourceSignal filter:^BOOL(id value) {
//		NSString *text = value;
//		return text.length > 3;
//	}];
//	
//	[filteredUsername subscribeNext:^(id x) {
//		NSLog(@"%@",x);
//	}];
	
	RACSignal *vaildUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
		return @([self isvalidUsername:text]);
	}];
	
	RACSignal *vaildPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
		return @([self isvalidPassword:text]);
	}];
	
	RAC(self.usernameTextField, backgroundColor) = [vaildUsernameSignal map:^id(NSNumber * usernameValid) {
		return [usernameValid boolValue]? [UIColor clearColor] : [UIColor yellowColor];
	}];
	
	RAC(self.passwordTextField, backgroundColor) = [vaildPasswordSignal map:^id(NSNumber * passwordValid) {
		return [passwordValid boolValue]? [UIColor clearColor] : [UIColor yellowColor];
	}];
	
	 [[RACSignal combineLatest:@[vaildUsernameSignal, vaildPasswordSignal] reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid){
		return @([usernameValid boolValue] && [passwordValid boolValue]);
	}] subscribeNext:^(NSNumber *sigunActive) {
		self.signInButton.enabled = [sigunActive boolValue];
	}];
	
//	[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//		NSLog(@"button clicked");
//	}];
	
	[[self.signInButton
   rac_signalForControlEvents:UIControlEventTouchUpInside]
		
	 subscribeNext:^(NSNumber *signedIn){
//		 BOOL success =[signedIn boolValue];
//		self.signInFailureText.hidden = success;
//		if(success){
		 [self performSegueWithIdentifier:@"signInSuccess" sender:self];
			
//		subscribeNext:^(id x){
//			NSLog(@"Sign in result: %@", x);
	 }];

}

- (BOOL)isvalidUsername:(NSString *)name {
	return name.length > 3;
}

- (BOOL)isvalidPassword:(NSString *)password {
	return password.length > 3;
}

	 
- (RACSignal *)signInSignal {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
		[self.signInService
		 signInWithUsername:self.usernameTextField.text
		 password:self.passwordTextField.text
		 complete:^(BOOL success){
			 [subscriber sendNext:@(success)];
			 [subscriber sendCompleted];
		 }];
		return nil;
	}];
}
@end
