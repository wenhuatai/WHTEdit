//
//  WHTTabBar.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTTabBar.h"
#import "WHTPublishViewController.h"

@interface WHTTabBar ()
{
}
@property(nonatomic,weak)UIButton *publishButton;

@end
@implementation WHTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //tabBar的背景图片
//        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [addButton addTarget:self action:@selector(thePublishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        self.publishButton = addButton;
        
    }return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.publishButton.frame = CGRectMake(0, 0, self.publishButton.currentImage.size.width, self.publishButton.currentImage.size.height);
    self.publishButton.center = CGPointMake(self.width/2, self.height/2);
    
   
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSInteger index1 = 0;
    for (UIView *button in self.subviews) {
        if ( ! [button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        CGFloat buttonX = buttonW * ((index1 > 1) ? index1+1 : index1);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index1++;
    }




}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark 发布取消按钮事件
- (void)thePublishAction:(UIButton *)button
{
    WHTPublishViewController *publishViewCtr = [[WHTPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishViewCtr animated:NO completion:^{
        
    }];



}
@end
