//
//  NSDate+LGZExtension.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/10.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LGZExtension)

/**
 * 直接返回比较出来的时间
 */
- (NSDateComponents *) datefrom:(NSDate *)from;

- (BOOL)isToday;
- (BOOL)isToyear;
- (BOOL)isYesterday;

@end
