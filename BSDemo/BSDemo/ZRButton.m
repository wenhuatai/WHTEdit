//
//  ZRButton.m
//  01PchDemo
//
//  Created by etcxm on 16/6/1.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import "ZRButton.h"

@implementation ZRButton


- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
//代码
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

//XIB
- (void)awakeFromNib
{
    [self setUp];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    设置图片位置
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;

//    设置文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
