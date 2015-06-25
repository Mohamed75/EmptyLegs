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
        [self addSubview:self.textView];
    }
    return self;
}

- (long) setData:(PFObject *)data{
    
    self.textView.frame = CGRectMake(40, 0, 240, 6000);
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat        = @"dd hh:mm";
    
    UIFont *font1 = [UIFont fontWithName:@"SourceCodePro-Light" size:18];
    UIFont *font2 = [UIFont fontWithName:@"SourceCodePro-Black" size:18];
    
    
    NSString *title1 = [NSString stringWithFormat:@"I need %dm2 of %@", [(NSNumber*)data[@"size"] intValue], data[@"description"]];
    
    NSString *from =  data[@"from"];
    NSString *title2 = [NSString stringWithFormat:@"taken from %@ to %@", from, data[@"to"]];
    
    NSString *pickedAt = [dateFormatter stringFromDate:data[@"pickedAt"]];
    NSString *arriveAt = [dateFormatter stringFromDate:data[@"arriveAt"]];
    NSString *title3 = [NSString stringWithFormat:@"picked up by %@ \narriving by %@", pickedAt, arriveAt];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n%@\n\n%@", title1, title2, title3]];
    
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, 7)];
    [text addAttribute:NSForegroundColorAttributeName value:SPECIAL_GREY range:NSMakeRange(0, 7)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(7, title1.length-7)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(7, title1.length-7)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:SPECIAL_GREY range:NSMakeRange(title1.length+1, 13)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+12, title2.length-11)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+12, title2.length-11)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+from.length+13, 3)];
    [text addAttribute:NSForegroundColorAttributeName value:SPECIAL_GREY range:NSMakeRange(title1.length+from.length+13, 3)];
    
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+2, 15)];
    [text addAttribute:NSForegroundColorAttributeName value:SPECIAL_GREY range:NSMakeRange(title1.length+title2.length+2, 15)];
    [text addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(title1.length+title2.length+16, title3.length-12)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title1.length+title2.length+16, title3.length-12)];
    
    [text addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(title1.length+title2.length+pickedAt.length+17, 13)];
    [text addAttribute:NSForegroundColorAttributeName value:SPECIAL_GREY range:NSMakeRange(title1.length+title2.length+pickedAt.length+17, 13)];
    
    
    self.textView.attributedText = text;
    [self.textView sizeToFit];
    
    return self.textView.frame.size.height+20;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
