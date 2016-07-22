//
//  WHTGudieView.m
//  BSDemo
//
//  Created by etcxm on 16/7/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTGudieView.h"

@implementation WHTGudieView
+(void)showGudieView;
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:key];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if ( ! [currentVersion isEqualToString:lastVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WHTGudieView *guideView = [WHTGudieView GudieViewFromXib];
        guideView.frame =window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}

+ (instancetype)GudieViewFromXib;
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (IBAction)theCanerAction:(id)sender {
    
    [self removeFromSuperview];
}


@end
