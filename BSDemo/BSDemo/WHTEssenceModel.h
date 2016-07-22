//
//  WHTEssenceModel.h
//  BSDemo
//
//  Created by etcxm on 16/7/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHTEssenceModel : NSObject
/*名字*/
@property(nonatomic,copy) NSString *name;
/*头像*/
@property(nonatomic,copy) NSString *profile_image;
/*时间*/
@property(nonatomic,copy) NSString *passtime;
/*顶*/
@property(nonatomic,assign) NSInteger ding;
/*踩*/
@property(nonatomic,assign) NSInteger cai;
/*转发*/
@property(nonatomic,assign) NSInteger repost;
/*评论*/
@property(nonatomic,assign) NSInteger comment;

@end
