//
//  NSDate+LGZExtension.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/10.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "NSDate+LGZExtension.h"

@implementation NSDate (LGZExtension)

- (NSDateComponents *)datefrom:(NSDate *)from
{
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSCalendarUnit comps = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calender components:comps fromDate:from toDate:self options:0];
}


- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit comps = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *compoments = [calendar components:comps fromDate:self toDate:nowDate options:0];
    return (compoments.year == 0) && (compoments.month == 0) && (compoments.day == 0);
    
}

- (BOOL)isToyear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *copms = [calendar components:NSCalendarUnitYear fromDate:self toDate:nowDate options:0];
    return (copms.year == 0);
}

- (BOOL)isYesterday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit comps = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *compoments = [calendar components:comps fromDate:self toDate:nowDate options:0];
    return (compoments.year == 0) && (compoments.month == 0) && (compoments.day == 1);


}

@end
