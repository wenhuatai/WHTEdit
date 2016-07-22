//
//  AttentionViewController.m
//  百思不得姐关注Demo
//
//  Created by etcxm on 16/7/7.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "AttentionViewController.h"
#import "AFNetworking.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>

#import "MJExtension.h"
#import "LeftModel.h"
#import "RightModel.h"
//static  NSString *identifier = @"Mycell";


@interface AttentionViewController ()
{
}
/*左侧数据数组*/
@property(nonatomic,strong) NSMutableArray *theLeftArry;

@property (weak, nonatomic) IBOutlet UITableView *theLeftTabelView;
@property (weak, nonatomic) IBOutlet UITableView *theRightTabelView;
//返回左侧选中的model
- (LeftModel *)leftSelectModel;
@end
static  NSString *identifier = @"Mycell";
static  NSString *identifier1 = @"Mycell1";
@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推荐关注";
    self.view.backgroundColor = [UIColor clearColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
  
    [self setUpNibCell];
    [self loadLeftData];

    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(theSearchAction:)];
    self.navigationItem.rightBarButtonItem = right;
    

    
    
 

}

- (LeftModel *)leftSelectModel
{
    NSInteger leftSelect = self.theLeftTabelView.indexPathForSelectedRow.row;
   LeftModel *leftModel = [self.theLeftArry objectAtIndex:leftSelect];
    return leftModel;
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
#pragma mark NIB
- (void)setUpNibCell
{
    
    self.theLeftTabelView.backgroundColor = WHTRGB(237, 237, 237);
    self.theRightTabelView.backgroundColor =WHTRGB(237, 237, 237);

    //    注册cell
    [self.theLeftTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([LeftTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];

    [self.theRightTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([RightTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier1];

    self.theRightTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRightNewData)];

    self.theRightTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRightMoreDatas)];


}

#pragma mark 检查每一个footer的状态
- (void)checkFooter
{
    LeftModel *leftModel = self.leftSelectModel;
    
    //        如果没有数据，就隐藏mj_footer
    self.theRightTabelView.mj_footer.hidden = (leftModel.uesrRightArray.count == 0 || leftModel.uesrRightArray.count == leftModel.total);
    
    if (leftModel.uesrRightArray.count == leftModel.total) {
        [self.theRightTabelView.mj_footer endRefreshingWithNoMoreData];

    }else
    {
    //        结束刷新
        [self.theRightTabelView.mj_footer endRefreshing];
    }
}
- (void)loadRightNewData
{
    LeftModel *model = self.leftSelectModel;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    //                第一次加载页数为1
    model.currentPage = 1;
    //    先创建AFN管理类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    让manager这个管理类 不要帮我们解析数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    1、url
    NSString *urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *theDic = [NSMutableDictionary dictionary];
    [theDic setObject:@"list" forKey:@"a"];
    [theDic setObject:@"subscribe" forKey:@"c"];
    [theDic setObject:model.id forKey:@"category_id"];
    
    [manager GET:urlString parameters:theDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *listArray = [json objectForKey:@"list"];
        NSArray *arrayModel = [RightModel mj_objectArrayWithKeyValuesArray:listArray];
        [model.uesrRightArray removeAllObjects];
        [model.uesrRightArray addObjectsFromArray:arrayModel];
        
        NSLog(@"listArray = %@",listArray);
        
        //                保存总条数
        model.total =[[json objectForKey:@"total"] integerValue];
        
        [self.theRightTabelView reloadData];
        
        application.networkActivityIndicatorVisible = NO;
        
        [SVProgressHUD dismiss];
        
        [self checkFooter];
        
        [self.theRightTabelView.mj_header endRefreshing ];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 = %@",error);
        [self.theRightTabelView.mj_header endRefreshing ];
        application.networkActivityIndicatorVisible = NO;
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
 
    

}
- (void)loadRightMoreDatas
{
    LeftModel *leftModel = self.leftSelectModel;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    //    先创建AFN管理类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    让manager这个管理类 不要帮我们解析数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    1、url
    NSString *urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *theDic = [NSMutableDictionary dictionary];
    NSInteger page = leftModel.currentPage;
    [theDic setObject:@"list" forKey:@"a"];
    [theDic setObject:@"subscribe" forKey:@"c"];
    [theDic setObject:leftModel.id forKey:@"category_id"];
    [theDic setObject:@(++page) forKey:@"page"];
    [manager GET:urlString parameters:theDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        [self.theRightTabelView.mj_header endRefreshing ];
        
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *listArray = [json objectForKey:@"list"];
        NSArray *arrayModel = [RightModel mj_objectArrayWithKeyValuesArray:listArray];
        [leftModel.uesrRightArray addObjectsFromArray:arrayModel];
        
        NSLog(@"listArray = %@",listArray);
        [self.theRightTabelView reloadData];
        application.networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        
        [self checkFooter];
        
        leftModel.currentPage++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 = %@",error);
        [self.theRightTabelView.mj_header endRefreshing ];
        application.networkActivityIndicatorVisible = NO;
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];




}
#pragma park  请求左边网络数据
- (void)loadLeftData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    //    先创建AFN管理类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    让manager这个管理类 不要帮我们解析数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    1、url
    NSString *urlString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *theDic = [NSMutableDictionary dictionary];
    
    [theDic setObject:@"category" forKey:@"a"];
    [theDic setObject:@"subscribe" forKey:@"c"];

    [manager GET:urlString parameters:theDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        [SVProgressHUD dismiss];
        
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
       NSArray *listArray = [json objectForKey:@"list"];

        self.theLeftArry = [LeftModel mj_objectArrayWithKeyValuesArray:listArray];
        
        NSLog(@"listArray = %@",self.theLeftArry);
        
        [self.theLeftTabelView reloadData];
        //        左侧cell显示选中第一行
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.theLeftTabelView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        application.networkActivityIndicatorVisible = NO;
        [self.theRightTabelView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 = %@",error);

        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
        application.networkActivityIndicatorVisible = NO;
       
    }];
    
    
    
}


#pragma mark 搜索点击事件
- (void)theSearchAction:(UIButton *)button
{
    NSLog(@"搜索点击事件");

}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.theLeftTabelView) {
        
        return self.theLeftArry.count;
    }else {
        //        返回左侧选中的行数
        [self checkFooter];
        return  self.leftSelectModel.uesrRightArray.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.theLeftTabelView) {
        return 40;
    }else {
        return 60;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (tableView == self.theLeftTabelView) {
        
       LeftTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

      cell.model = self.theLeftArry[indexPath.row];
    
      return cell;
    }else {
        RightTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    
        cell.model = self.leftSelectModel.uesrRightArray[indexPath.row];
        return cell;
    
    
    }


    
    
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.theLeftTabelView) {
                   //        点击左侧，右侧刷新要全部结束
    [self.theRightTabelView.mj_footer  endRefreshing];
    [self.theRightTabelView.mj_header  endRefreshing];
        
    LeftModel *model = [self.theLeftArry objectAtIndex:indexPath.row];
        if (model.uesrRightArray.count != 0) {

            [self.theRightTabelView reloadData];
            
        }else {
            //        解决网络慢的问题
            [self.theRightTabelView reloadData];
            //        开始刷新
            [self.theRightTabelView.mj_header beginRefreshing];
            
        }
    }
}














@end
