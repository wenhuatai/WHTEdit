//
//  WHTMeViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTMeViewController.h"

@interface WHTMeViewController ()


@end

@implementation WHTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *itemOne = [UIBarButtonItem itemWithImage:@"mine-moon-icon" andHightImage:@"mine-sun-icon-click" andTarget:self andAction:@selector(theRightAcitonOne:)];
    UIBarButtonItem *itemTwo = [UIBarButtonItem itemWithImage:@"mine-setting-icon" andHightImage:@"mine-setting-icon-click" andTarget:self andAction:@selector(theRightAcitonTwo:)];
    
    self.navigationItem.rightBarButtonItems = @[itemTwo,itemOne];

    
}

- (void)theRightAcitonOne:(UIButton *)button
{
    WHTLog(@"____");


}
- (void)theRightAcitonTwo:(UIButton *)button
{
    WHTLog(@"____++++++");
    
    
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
