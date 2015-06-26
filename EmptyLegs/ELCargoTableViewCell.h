//
//  ELCargoTableViewCell.h
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCargoTableViewCell : UITableViewCell

@property UITextView *textView;
@property UIButton *contactButton;

@property (weak) id responsable;

@property BOOL cargoMode;


- (long) setData:(PFObject *)data;

@end
