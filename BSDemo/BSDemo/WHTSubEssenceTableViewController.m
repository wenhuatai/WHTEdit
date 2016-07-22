//
//  WHTWordTableViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/19.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTSubEssenceTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#import "WHTEssenceTableViewCell.h"
#import "WHTEssenceModel.h"
@interface WHTSubEssenceTableViewController ()
{
}
//  段子的数组内容
@property (nonatomic,strong) NSMutableArray *topicArry;
//当前页数
@property (nonatomic,assign) NSInteger page;
//加载上一页的maxtime
@property (nonatomic,copy) NSString *maxtime;

//记住当前请求的参数
@property (nonatomic,strong) NSMutableDictionary *parserDic;


@end
static NSString *identifier = @"wordcell";
@implementation WHTSubEssenceTableViewController
- (NSMutableArray *)topicArry
{
    if (_topicArry == nil) {
        _topicArry = [[NSMutableArray alloc] init];
    }
    return _topicArry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setUpTableView];//设置表视图
    
    [self setUpRefresh];//设置刷新
}

- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopicData)];
    
    //    自动刷新改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopicData)];
}

- (void)setUpTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = WHTRGB(237, 237, 237);
    
    //    注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WHTEssenceTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}
- (void)loadNewTopicData //新的数据
{
    //    停止上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    
    //    1、url
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    //   2、参数
    NSMutableDictionary *theParserDic = [NSMutableDictionary dictionary];
    theParserDic[@"a"] = @"list";
    theParserDic[@"c"] = @"data";
    theParserDic[@"type"] = self.type;
    self.parserDic = theParserDic;
    
    //   3、发送请求
    [[AFHTTPSessionManager manager] GET:url parameters:theParserDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parserDic !=  theParserDic) {
            return;
        }
        NSLog(@"responseObject = %@",responseObject);
        //        结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //     保存maxtime 为下页准备着
        self.maxtime = [[responseObject objectForKey:@"info"] objectForKey:@"maxtime"];
        //        获取list的数据
        NSArray *arry = [responseObject objectForKey:@"list"];
        //        数组字典------》 数组模型
        [self.topicArry removeAllObjects];
        //        self.topicArry = [NSMutableArray arrayWithArray:arry];
        self.topicArry  = [WHTEssenceModel mj_objectArrayWithKeyValuesArray:arry];
        
        //       下拉刷新 页数为0
        self.page = 0;
        //        更新UI
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

- (void)loadMoreTopicData //更多数据
{
    //    停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *theParserDic = [NSMutableDictionary dictionary];
    theParserDic[@"a"] = @"list";
    theParserDic[@"c"] = @"data";
    theParserDic[@"type"] = self.type;
    NSInteger page = self.page;
    theParserDic[@"page"] = @(page++);
    theParserDic[@"maxtime"] = self.maxtime;  //第二页 用一页的maxtime
    //    第三页  用第二页的maxtime
    
    self.parserDic = theParserDic;
    
    
    [[AFHTTPSessionManager manager] GET:url parameters:theParserDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parserDic !=  theParserDic) {
            return;
        }
        
        NSLog(@"responseObject = %@",responseObject);
        
        [self.tableView.mj_footer endRefreshing];
        
        self.maxtime = [[responseObject objectForKey:@"info"] objectForKey:@"maxtime"];
        //        获取list的数据
        NSArray *arry = [responseObject objectForKey:@"list"];
        //        数组字典------》 数组模型
        
        //        self.topicArry = [NSMutableArray arrayWithArray:arry];
        NSArray *modelArry = [WHTEssenceModel mj_objectArrayWithKeyValuesArray:arry];
        
        //        把新数据 加入到 旧数据的数组后面
        [self.topicArry addObjectsFromArray:modelArry];
        
        //        更新UI
        [self.tableView reloadData];
        
        //       请求成功  页数才能+1
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topicArry.count == 0);
    return self.topicArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WHTEssenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.model = self.topicArry[indexPath.row];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    TopicModel *model = self.topicArry[indexPath.row];
    //    获取每一个model的cell高度
    //    return model.cellHeight;
    return 200;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
