//
//  AppDelegate.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"i3U88vlJRpG7OAS0ffsnn8priIJonXbtwaoT3l7R"
                  clientKey:@"Szvlny3DO4eDGVSCyMJKseEp5z2HfoknzvNJmlSw"];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [[ELDataController getSharedInstance] loadCargos];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[ELDataController getSharedInstance] loadCargos];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


+ (void) callPhoneNumber:(NSString *) _number{
    
    NSString *phoneCallString = [NSString stringWithFormat:@"telprompt://%@", _number];
    
    if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneCallString]])
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallString]];
    
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Sorry this feature is not available on this device" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alertView show];
    }
}

+ (BOOL) isValidUKPhoneNumber:(NSString *) _phoneNumber
{
    // check whether the phone number given is a valid UK mobile number
    NSString *phoneRegexUK = @"^(07|00447|\\+447|\\+44\\(0\\)7)\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegexUK];
    
    return [phoneTest evaluateWithObject:[_phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

+ (BOOL) isValidEmail:(NSString *) _email {
    
    NSString *emailRegex    = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:_email];
}


@end
