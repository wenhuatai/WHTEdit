//
//  WHTTabBarController.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTTabBarController.h"
#import "WHTEssenceViewController.h"
#import "WHTNewViewController.h"
#import "WHTFriendViewController.h"
#import "WHTMeViewController.h"
#import "WHTTabBar.h"
#import "WHTNavigationViewController.h"
@interface WHTTabBarController ()

@end

@implementation WHTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*设置TabBar的字体颜色*/
    NSMutableDictionary *dicM1 = [[NSMutableDictionary alloc]init];
    dicM1[NSFontAttributeName]= [UIFont systemFontOfSize:12.0];
    dicM1[NSForegroundColorAttributeName]= [UIColor lightGrayColor];
    [[UITabBarItem appearance]setTitleTextAttributes:dicM1 forState:UIControlStateNormal];
    
    NSMutableDictionary *dicM2 = [[NSMutableDictionary alloc]init];
    dicM2[NSFontAttributeName]= [UIFont systemFontOfSize:12.0];
    dicM2[NSForegroundColorAttributeName]= [UIColor darkGrayColor];
    [[UITabBarItem appearance]setTitleTextAttributes:dicM2 forState:UIControlStateSelected];
    

    [self setUpTabBar:[[WHTEssenceViewController alloc]init] andTitle:@"精华" andImage:@"tabBar_essence_icon" andselectImage:@"tabBar_essence_click_icon"];
    
    [self setUpTabBar:[[WHTNewViewController alloc]init] andTitle:@"最新" andImage:@"tabBar_new_icon" andselectImage:@"tabBar_new_click_icon"];
    
    [self setUpTabBar:[[WHTFriendViewController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andselectImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpTabBar:[[WHTMeViewController alloc]init] andTitle:@"我" andImage:@"tabBar_me_icon" andselectImage:@"tabBar_me_click_icon"];
    //    KVC设置不可以直接赋值，属性为只读
    [self setValue:[[WHTTabBar alloc] init] forKeyPath:@"tabBar"];
    

     
}

- (void)setUpTabBar:(UIViewController *)viewCtr andTitle:(NSString *)title andImage:(NSString *)image andselectImage:(NSString *)selectImage
{
    viewCtr.tabBarItem.title = title;
    viewCtr.tabBarItem.image = [UIImage imageNamed:image];
    viewCtr.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    viewCtr.view.backgroundColor = WHTRGB(237, 237, 237);
    WHTNavigationViewController *naviCtr = [[WHTNavigationViewController alloc]initWithRootViewController:viewCtr];
    [self addChildViewController:naviCtr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
