//
//  ELContactViewController.h
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ELContactViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property NSDictionary *contact;

@end
