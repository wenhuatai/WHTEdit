//
//  WHTNewViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTNewViewController.h"

@interface WHTNewViewController ()

@end

@implementation WHTNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" andHightImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(theLeftButtonAction:)];
}
- (void)theLeftButtonAction:(UIButton *)button
{
    
    WHTLog(@"+++++++");
    
    
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
