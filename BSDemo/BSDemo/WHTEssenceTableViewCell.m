//
//  WHTEssenceTableViewCell.m
//  BSDemo
//
//  Created by etcxm on 16/7/20.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTEssenceTableViewCell.h"

#import <UIImageView+WebCache.h>
#import "WHTEssenceModel.h"
@interface WHTEssenceTableViewCell ()
{
}
@property (weak, nonatomic) IBOutlet UIImageView *theInageView;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *conmentButton;

@end
@implementation WHTEssenceTableViewCell

- (void)setModel:(WHTEssenceModel *)model
{
    _model = model;
    self.theNameLabel.text = model.name;
    self.theTimeLabel.text = model.passtime;
    [self.theInageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:nil];
    
    [self setButtonTitle:self.dingButton count:model.ding placeholderName:@"顶"];
    
    [self setButtonTitle:self.caiButton count:model.cai placeholderName:@"踩"];
    
    [self setButtonTitle:self.shareButton count:model.repost placeholderName:@"转发"];
    
    [self setButtonTitle:self.conmentButton count:model.comment placeholderName:@"评论"];
    
    
}


- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count  placeholderName:(NSString *)placeholder
{
    if (count>0 && count<10000) {
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }else if(count >= 10000)
    {
        placeholder = [NSString stringWithFormat:@"%ld万+",count/10000];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width  -= 2*margin;
    frame.size.height -=margin;
    frame.origin.y +=margin;
    
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
