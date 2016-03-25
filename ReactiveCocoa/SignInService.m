//
//  SignInService.m
//  ReactiveCocoa
//
//  Created by mac on 3/4/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "SignInService.h"

@implementation SignInService

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(SignInRespose)completeBlock{
	
	double delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
		completeBlock(success);
	});
}

@end
