//
//  WHTFriendViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTFriendViewController.h"
#import "AttentionViewController.h"
@interface WHTFriendViewController ()

@end

@implementation WHTFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" andHightImage:@"friendsRecommentIcon-click" andTarget:self andAction:@selector(theLeftButtonAction:)];
}
- (void)theLeftButtonAction:(UIButton *)button
{
    WHTLog(@"+++++++");
    AttentionViewController *viewCtr = [[AttentionViewController alloc]init];
    [self.navigationController pushViewController:viewCtr animated:YES];
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
