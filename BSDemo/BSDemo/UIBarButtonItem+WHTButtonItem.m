//
//  UIBarButtonItem+WHTButtonItem.m
//  BSDemo
//
//  Created by etcxm on 16/7/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "UIBarButtonItem+WHTButtonItem.h"

@implementation UIBarButtonItem (WHTButtonItem)


+ (instancetype)itemWithImage:(NSString *)image andHightImage:(NSString *)hightImage andTarget:(id)target andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentImage.size;
    
    return [[self alloc]initWithCustomView:button];
    
}
@end
