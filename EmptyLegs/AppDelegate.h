//
//  AppDelegate.h
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KEYBOARD_HEIGHT 216.0f


#define SPECIAL_DARK [UIColor colorWithRed:16/255.0 green:26/255.0 blue:32/255.0 alpha:1]
#define SPECIAL_GREY [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


+ (void) callPhoneNumber:(NSString *) _number;
+ (BOOL) isValidUKPhoneNumber:(NSString *) _phoneNumber;
+ (BOOL) isValidEmail:(NSString *) _email;

@end

