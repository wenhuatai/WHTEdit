//
//  NSDate+WHTComperDate.h
//  BSDemo
//
//  Created by etcxm on 16/7/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WHTComperDate)

// self 与 fromDate 的比较
- (NSDateComponents *)distanceFrom:(NSDate *)fromDate;

//是不是今年
- (BOOL)isThisYear;
//是不是今天
- (BOOL)isToday;
//是不是昨天
- (BOOL)isYesterDay;

@end
