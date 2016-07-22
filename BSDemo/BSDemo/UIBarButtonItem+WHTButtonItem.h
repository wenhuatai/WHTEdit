//
//  UIBarButtonItem+WHTButtonItem.h
//  BSDemo
//
//  Created by etcxm on 16/7/14.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WHTButtonItem)

+ (instancetype)itemWithImage:(NSString *)image andHightImage:(NSString *)hightImage andTarget:(id)target andAction:(SEL)action;
@end
