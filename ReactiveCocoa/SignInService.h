//
//  SignInService.h
//  ReactiveCocoa
//
//  Created by mac on 3/4/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SignInRespose)(BOOL);

@interface SignInService : NSObject

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(SignInRespose)completeBlock;
@end
