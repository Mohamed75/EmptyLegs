//
//  ELCreationTableViewCell.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELCreationTableViewCell.h"

@implementation ELCreationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 30)];
        [self.title setFont:[UIFont fontWithName:@"SourceCodePro-Medium" size:18]];
        self.title.textColor = [UIColor whiteColor];
        [self addSubview:self.title];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 28, 240, 30)];
        [self.textField setFont:[UIFont fontWithName:@"SourceCodePro-Light" size:18]];
        self.textField.textColor = SPECIAL_GREY;
        self.textField.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textField];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(40, 58, 240, 1)];
        lineView.backgroundColor = SPECIAL_GREY;
        [self addSubview:lineView];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
