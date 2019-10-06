//
//  NSDate+Extension.h
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDate (Extension)

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end


