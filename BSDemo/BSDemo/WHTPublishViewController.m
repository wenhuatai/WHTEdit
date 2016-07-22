//
//  WHTPublishViewController.m
//  BSDemo
//
//  Created by etcxm on 16/7/18.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTPublishViewController.h"
#import "ZRButton.h"
#import <pop/POP.h>
@interface WHTPublishViewController ()
{
}


- (IBAction)theCancerAction:(id)sender;

@end

@implementation WHTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.userInteractionEnabled = NO;
    
    NSArray *theImagesArry = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *theTitlesArry = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];

    NSInteger maxcol = 3;//总的列数
    CGFloat buttonW = 70;//button的宽度
    CGFloat buttonH = buttonW + 30;//button的高度
    
    CGFloat buttonBeginX = 20;//
    CGFloat marginX = (Screen_width  - 2*buttonBeginX - maxcol*buttonW)/(maxcol -1);//列与列之间的Button间距
    
    CGFloat marginY = 10;//行与行button之间的间距
    CGFloat buttonBeginY = (Screen_height - 2*buttonH -marginY)*0.5;
    for (int i = 0; i < theImagesArry.count; i++) {
        
        ZRButton *button = [[ZRButton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(theButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:theTitlesArry[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:theImagesArry[i]] forState:UIControlStateNormal];
        
        //计数ButtonX、Y
        NSInteger row = i/maxcol;
        NSInteger col = i%maxcol;
        CGFloat buttonX = buttonBeginX+col*(marginX+buttonW);
//        CGFloat buttonY = buttonBeginY+row*(buttonH+marginY);
        CGFloat buttonToY = buttonBeginY+row*(buttonH+marginY);
        
        CGFloat buttonFromY = buttonToY - Screen_height;
        
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
        
        POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anmi.springSpeed = 10;
        anmi.springBounciness = 10;
        anmi.beginTime = CACurrentMediaTime() + 0.1*(theTitlesArry.count-i);
        
        anmi.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonFromY, buttonW, buttonH)];
        anmi.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonToY, buttonW, buttonH)];

        
        [button pop_addAnimation:anmi forKey:@"buttonkey"];
   
    }
    
    //加载图片和图片动画
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:imageView];

    POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anmi.springSpeed = 10;
    anmi.springBounciness = 10;
    anmi.beginTime = CACurrentMediaTime() + 0.1*theTitlesArry.count;
    
    CGFloat centerX = Screen_width*0.5;
    
    CGFloat centerToY = Screen_height*0.2;
    
    CGFloat centerFromY = centerToY-Screen_height;
    
    anmi.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerFromY)];
    anmi.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerToY)];
    
    [anmi setCompletionBlock:^(POPAnimation *pop, BOOL finnished) {
        self.view.userInteractionEnabled = YES;
    }];
    [imageView pop_addAnimation:anmi forKey:@"imagekey"];
    
}
#pragma mark 点击视图所触发的事件的
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancerAction:nil];
}
#pragma mark 内存警告
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

#pragma mark Publish取消事件
- (IBAction)theCancerAction:(id)sender {
    
    [self cancerAction:nil];
}
#pragma mark 取消方法
- (void)cancerAction:(finishBlock)finishBlock
{

    NSInteger bottonIndex = 2;
    for (NSInteger i = bottonIndex; i<self.view.subviews.count; i++)
    {
        
        UIView *button = [self.view.subviews objectAtIndex:i];
        
        POPBasicAnimation *anmi = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        anmi.beginTime = CACurrentMediaTime() + 0.05*(i-bottonIndex);
        
        CGFloat centerX = button.centerX;
        CGFloat centerFromY = button.centerY;
        
        CGFloat centerToY = centerFromY+Screen_height;
        
        if (i == self.view.subviews.count-1) {
            [anmi setCompletionBlock:^(POPAnimation *pop, BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self dismissViewControllerAnimated:NO completion:^{
                    
                }];
                //block的调用
                !finishBlock ?  :finishBlock();
            }];
        }
        anmi.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerFromY)];
        anmi.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerToY)];

        [button pop_addAnimation:anmi forKey:nil];
    }
}
#pragma mark 图标按钮点击事件入口
- (void)theButtonAction:(UIButton *)button
{
    [self cancerAction:^{
        switch (button.tag) {
            case 0:
                WHTLog(@"发视频");
                break;
            case 1:
                WHTLog(@"发图片");
                break;
            case 2:
                WHTLog(@"发段子");
                break;
            case 3:
                WHTLog(@"发声音");
                break;
            case 4:
                WHTLog(@"审帖");
                break;
            case 5:
                WHTLog(@"离线下载");
                break;
                
            default:
                WHTLog(@"点击错误");
                break;

        }
    }];


}
@end
