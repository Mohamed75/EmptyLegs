//
//  ELContactViewController.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELContactViewController.h"



@interface ELContactViewController ()

@property UIButton *closeButton;
@property UIButton *phoneButton;
@property UIButton *emailButton;

@end



@implementation ELContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = SPECIAL_DARK;
    
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 20, 20)];
    [self.closeButton setImage:[UIImage imageNamed:@"empty_leg_cross"] forState:0];
    [self.closeButton addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    
    self.phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 140, 240, 110)];
    self.phoneButton.backgroundColor = SPECIAL_DARK;
    self.phoneButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.phoneButton.layer.borderWidth = 1;
    [self.phoneButton setTitle:@"phone" forState:0];
    [self.phoneButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.phoneButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:18]];
    [self.phoneButton addTarget:self action:@selector(phoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.phoneButton];
    
    
    self.emailButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 280, 240, 110)];
    self.emailButton.backgroundColor = SPECIAL_DARK;
    self.emailButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.emailButton.layer.borderWidth = 1;
    [self.emailButton setTitle:@"email" forState:0];
    [self.emailButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.emailButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:18]];
    [self.emailButton addTarget:self action:@selector(emailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.emailButton];
}


- (void) phoneBtnClicked:(id)sender{
    
    [AppDelegate callPhoneNumber:[self.contact objectForKey:@"phone"]];
}

- (void) emailBtnClicked:(id)sender{
    
    NSMutableArray *emails = [NSMutableArray new];
    [emails addObject:[self.contact objectForKey:@"email"]];
    [self sendSimpleMail:@"" mailAddress:emails emailBody:@""];
}


- (void) closeBtnClicked:(id)sender{
    
    [self.view removeFromSuperview];
}



- (void) sendSimpleMail:(NSString *)title mailAddress:(NSArray *)mailAddress emailBody:(NSString *)emailBody{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [MFMailComposeViewController new];
        mailer.mailComposeDelegate          = self;
        [mailer setSubject:title];
        [mailer setMessageBody:emailBody isHTML:NO];
        if(mailAddress)    [mailer setToRecipients:mailAddress];
        [[ELMainViewController getSharedInstance] presentViewController:mailer animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email error" message:@"We cannot connect to your email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alertView show];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [[ELMainViewController getSharedInstance] dismissViewControllerAnimated:YES completion:nil];
}


@end
