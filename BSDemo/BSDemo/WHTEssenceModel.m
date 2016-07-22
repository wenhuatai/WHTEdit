//
//  WHTEssenceModel.m
//  BSDemo
//
//  Created by etcxm on 16/7/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "WHTEssenceModel.h"
#import "NSDate+WHTComperDate.h"
@implementation WHTEssenceModel

- (NSString *)passtime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *createDate = [formatter dateFromString:_passtime];
    if ([createDate isThisYear]) { //是今年
        if ([createDate isToday]) { //今天
            NSDateComponents *comps = [[NSDate date] distanceFrom:createDate];

            
            if (comps.hour > 1) {
                return [NSString stringWithFormat:@"%ld小时前",comps.hour];
            }else if (comps.minute > 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前",comps.minute];
            }else
            {
                return @"刚刚";
            }
        }else if ([createDate isYesterDay]) //昨天
        {
            [formatter setDateFormat:@"昨天 HH:mm:ss"];
            return [formatter stringFromDate:createDate];
        }else //其他的
        {
            [formatter setDateFormat:@"MM-dd HH:mm:ss"];
            return [formatter stringFromDate:createDate];
            
        }
    }else//不是今年
    {
        return _passtime;
    }
    
    
}
@end
