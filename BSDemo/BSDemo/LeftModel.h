//
//  LeftModel.h
//  百思不得姐关注Demo
//
//  Created by etcxm on 16/7/7.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *id;


@property(nonatomic,strong)NSMutableArray *uesrRightArray;

/*总条数*/
@property(nonatomic,assign) NSInteger total;

/*当前页数*/
@property(nonatomic,assign) NSInteger currentPage;
@end
