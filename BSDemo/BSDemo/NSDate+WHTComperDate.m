//
//  NSDate+WHTComperDate.m
//  BSDemo
//
//  Created by etcxm on 16/7/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "NSDate+WHTComperDate.h"

@implementation NSDate (WHTComperDate)

// self 与 fromDate 的比较
- (NSDateComponents *)distanceFrom:(NSDate *)fromDate;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components =  [calendar components:NSCalendarUnitDay|kCFCalendarUnitHour|kCFCalendarUnitMinute|NSCalendarUnitSecond fromDate:fromDate toDate:self options:0];
    return components;

}

//是不是今年
- (BOOL)isThisYear;
{
    //    self  Now
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == nowYear;
}
//是不是今天
- (BOOL)isToday;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfComps.year == nowComps.year && selfComps.month == nowComps.month && selfComps.day == nowComps.day;
}
//是不是昨天
- (BOOL)isYesterDay;
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
    
}
@end
