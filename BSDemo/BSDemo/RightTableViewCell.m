//
//  RightTableViewCell.m
//  百思不得姐关注Demo
//
//  Created by vivo on 16/7/9.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "RightTableViewCell.h"
#import "RightModel.h"
#import "UIImageView+WebCache.h"
@interface RightTableViewCell ()
{

}

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabei;
@property (weak, nonatomic) IBOutlet UILabel *theOtherLabei;
- (IBAction)theButtonAction:(id)sender;



@end
@implementation RightTableViewCell

- (void)setModel:(RightModel *)model
{
    self.theImageView.layer.cornerRadius = self.theImageView.width/2.0;
    self.theImageView.layer.masksToBounds = YES;
    
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.header]];
    self.theNameLabei.text = model.screen_name;
    self.theOtherLabei.text = [NSString stringWithFormat:@"%@人关注了",model.fans_count];


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)theButtonAction:(id)sender {
    
    WHTLog(@"关注按钮点击了");
}
@end
