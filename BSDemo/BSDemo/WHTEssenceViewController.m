//
//  WHTEssenceViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/13.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTEssenceViewController.h"
#import "WHTAllTableViewController.h"
#import "WHTVideoTableViewController.h"
#import "WHTPictureTableViewController.h"
#import "WHTWordTableViewController.h"
#import "WHTVicTableViewController.h"


@interface WHTEssenceViewController ()<UIScrollViewDelegate>
{}
/*选中标签栏的指示*/
@property(nonatomic,weak)UIView *theSelectView;
/*选中的标签栏的按钮*/
@property(nonatomic,weak)UIButton *theSelectButton;
/*顶部标签栏*/
@property(nonatomic,weak) UIView *theTopView;
/*滚动内容视图*/
@property(nonatomic,weak) UIScrollView *theScrollContentView;


@end

@implementation WHTEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpNavigation];
    
    [self setUpChildViewCtr];
    [self setUpTopView];
    [self setUpScrollContentView];
 
    
    
    
   
    
    
    

    
}

#pragma maerk 设置顶部视图子视图
- (void)setUpChildViewCtr
{
    WHTAllTableViewController *allCtr = [[WHTAllTableViewController alloc]init];
    [self addChildViewController:allCtr];
    
    WHTVideoTableViewController *videoCtr = [[WHTVideoTableViewController alloc]init];
    [self addChildViewController:videoCtr];
    
    WHTPictureTableViewController *pictureCtr = [[WHTPictureTableViewController alloc]init];
    [self addChildViewController:pictureCtr];
    
    WHTWordTableViewController *wordCtr = [[WHTWordTableViewController alloc]init];
    [self addChildViewController:wordCtr];
    
    WHTVicTableViewController *vicCtr = [[WHTVicTableViewController alloc]init];
    [self addChildViewController:vicCtr];



}

#pragma maerk 设置导航栏
- (void)setUpNavigation
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" andHightImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(theLeftButtonAction:)];

}
#pragma mark 设置顶部视图
- (void)setUpTopView
{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    topView.width = Screen_width;
    topView.height = 35;
    topView.y = 0;
    [self.view addSubview:topView];
    self.theTopView = topView;
   
    
    //    5个标签栏
    NSArray *titleArrys = @[@"全部",@"视频",@"图片",@"段子",@"声音"];
    CGFloat width = Screen_width/titleArrys.count;
    CGFloat height = topView.height;
    
    //    选中的颜色
    UIView *selectView = [[UIView alloc] init];
    selectView.backgroundColor = [UIColor redColor];
    selectView.height = 3;
    selectView.y = topView.height - selectView.height;
    [topView addSubview:selectView];
    self.theSelectView = selectView;


    for (int i = 0; i < titleArrys.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.width = width;
        button.height = height;
        button.x = i*width;
        [button setTitle:titleArrys[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

//        [button layoutIfNeeded];//方法一强制布局
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(theTopViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        if (i == 0) {
//            [button.titleLabel sizeToFit];//方法二自适应文本大小
            button.enabled = NO;
            self.theSelectButton = button;
            self.theSelectView.width = [titleArrys [i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;//button.titleLabel.width;//方法三根据文本算出Width
            self.theSelectView.centerX = button.centerX;
        }
    }
    

    
}
- (void)setUpScrollContentView
{
    UIScrollView *scrollContentView = [[UIScrollView alloc] init];
    scrollContentView.pagingEnabled = YES;
    scrollContentView.frame = CGRectMake(0, 0, Screen_width, Screen_height);
    scrollContentView.delegate = self;
    //    设置内边距
//    [scrollContentView setContentInset:UIEdgeInsetsMake(CGRectGetMaxY(self.theTopView.frame), 0, self.tabBarController.tabBar.height, 0)];
    
//    scrollContentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollContentView];
    
    [scrollContentView setContentSize:CGSizeMake(scrollContentView.width*self.childViewControllers.count, 0)];
    
    [self.view insertSubview:scrollContentView atIndex:0];
    self.theScrollContentView = scrollContentView;
    
    //    显示第一个子控制器
    [self scrollViewDidEndScrollingAnimation:scrollContentView];
    
}
#pragma mark 导航栏左边button事件
- (void)theLeftButtonAction:(UIButton *)button
{
    
    WHTLog(@"+++++++");


}
#pragma mark 顶部视图上的buttons事件
- (void)theTopViewButtonAction:(UIButton *)button
{

    self.theSelectButton.enabled = YES;
    button.enabled = NO;
    self.theSelectButton = button;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.theSelectView.width = button.titleLabel.width;
        self.theSelectView.centerX = button.centerX;
    }];

    //    滚动
    CGPoint offset = self.theScrollContentView.contentOffset;
    offset.x = button.tag*self.theScrollContentView.width;
    [self.theScrollContentView setContentOffset:offset animated:YES];
    
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    UITableViewController *tableViewCtr = self.childViewControllers[index];
    tableViewCtr.view.width = scrollView.width;
    tableViewCtr.view.height = scrollView.height;
    tableViewCtr.view.x = scrollView.contentOffset.x;
    tableViewCtr.view.y = 0;
    
    //设置边距
    CGFloat top = CGRectGetMaxY(self.theTopView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;

    tableViewCtr.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动边距
    tableViewCtr.tableView.scrollIndicatorInsets = tableViewCtr.tableView.contentInset;
    [self.theScrollContentView addSubview:tableViewCtr.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //   当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    [self theTopViewButtonAction:self.theTopView.subviews[index+1]];
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
