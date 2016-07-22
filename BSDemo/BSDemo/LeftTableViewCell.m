//
//  LeftTableViewCell.m
//  百思不得姐关注Demo
//
//  Created by etcxm on 16/7/7.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "LeftModel.h"
@interface LeftTableViewCell ()
{
}
@property (weak, nonatomic) IBOutlet UIView *theSelectedView;


@end
@implementation LeftTableViewCell



- (void)setModel:(LeftModel *)model
{

    self.textLabel.text = model.name;

}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 4 *self.textLabel.y;
    self.textLabel.textAlignment = NSTextAlignmentCenter;


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor = WHTRGB(237, 237, 237);

    self.theSelectedView.hidden = !selected;
    
    self.textLabel.textColor = selected?[UIColor redColor]:[UIColor darkGrayColor];
    self.backgroundColor = selected?[UIColor whiteColor]:WHTRGB(237, 237, 237);
    
    // Configure the view for the selected state
}

@end
