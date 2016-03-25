//
//  ViewController.h
//  ReactiveCocoa
//
//  Created by mac on 3/4/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
- (IBAction)signInButtonTouched:(id)sender;


@end

