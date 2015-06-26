//
//  ELCargoTableViewCell.m
//  EmptyLegs
//
//  Created by Mohamed Boumansour on 25/06/15.
//  Copyright (c) 2015 explovia. All rights reserved.
//

#import "ELCargoTableViewCell.h"


@implementation ELCargoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 0, 240, 6000)];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.userInteractionEnabled = NO;
        [self addSubview:self.textView];
        
        self.contactButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 240, 42)];
        self.contactButton.backgroundColor = [UIColor whiteColor];
        [self.contactButton setTitle:@"contact" forState:0];
        [self.contactButton setTitleColor:SPECIAL_DARK forState:0];
        [self.contactButton.titleLabel setFont:[UIFont fontWithName:@"SourceCodePro-Bold" size:18]];
        [self.contactButton addTarget:self.responsable action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.contactButton];
        self.contactButton.hidden = YES;
    }
    return self;
}

- (long) setData:(PFObject *)data{
    
    self.textView.frame = CGRectMake(40, 0, 240, 6000);
    
    if(self.cargoMode)
        self.textView.attributedText = [self cargoCell:data];
    else
        self.textView.attributedText = [self driverCell:data];
    
    [self.textView sizeToFit];
    
    self.contactButton.frame = CGRectMake(40, self.textView.frame.size.height+20, 240, 42);
    self.contactButton.hidden = NO;
    
    return self.textView.frame.size.height+80;
}


- (NSMutableAttributedString *) cargoCell:(PFObject *)data{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat        = @"dd-MM hh:mm";
    
    UIFont *font1 = [UIFont fontWithName:@"SourceCodePro-Light" size:18];
    UIFont *font2 = [UIFont fontWithName:@"SourceCodePro-Black" size:18];
    
    
    NSString *title1 = [NSString stringWithFormat:@"I need %dm3 of %@", [(NSNumber*)data[@"size"] intValue], data[@"description"]];
    
    NSString *from =  data[@"from"];
    NSString *title2 = [NSString stringWithFormat:@"taken from %@ to %@", from, data[@"to"]];
    
    NSString *pickedAt = [dateFormatter stringFromDate:data[@"pickedAt"]];
    NSString *arriveAt = [dateFormatter stringFromDate:data[@"arriveAt"]];
    NSString *title3 = [NSString stringWithFormat:@"leaving by %@ \narriving by %@", pickedAt, arriveAt];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n%@\n\n%@", title1, title2, title3]];
    
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, 7)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 7)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(7, title1.length-7)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(7, title1.length-7)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+12, title2.length-10)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+12, title2.length-10)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+from.length+13, 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+from.length+13, 3)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+2, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+2, 13)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+title2.length+14, title3.length-10)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+14, title3.length-10)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+pickedAt.length+15, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+pickedAt.length+15, 13)];
    
    return text;
}

- (NSMutableAttributedString *) driverCell:(PFObject *)data{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat        = @"dd-MM hh:mm";
    
    UIFont *font1 = [UIFont fontWithName:@"SourceCodePro-Light" size:18];
    UIFont *font2 = [UIFont fontWithName:@"SourceCodePro-Black" size:18];
    
    
    NSString *title1 = [NSString stringWithFormat:@"I have %dm3 of %@", [(NSNumber*)data[@"size"] intValue], data[@"description"]];
    
    NSString *from =  data[@"from"];
    NSString *title2 = [NSString stringWithFormat:@"going from %@ to %@", from, data[@"to"]];
    
    NSString *pickedAt = [dateFormatter stringFromDate:data[@"pickedAt"]];
    NSString *arriveAt = [dateFormatter stringFromDate:data[@"arriveAt"]];
    NSString *title3 = [NSString stringWithFormat:@"leaving by %@ \narriving by %@", pickedAt, arriveAt];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n%@\n\n%@", title1, title2, title3]];
    
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, 7)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 7)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(7, title1.length-7)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(7, title1.length-7)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+12, title2.length-10)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+12, title2.length-10)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+from.length+13, 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+from.length+13, 3)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+2, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+2, 13)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+title2.length+14, title3.length-10)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+14, title3.length-10)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+pickedAt.length+15, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+pickedAt.length+15, 13)];
    
    return text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
