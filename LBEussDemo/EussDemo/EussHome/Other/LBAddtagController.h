//
//  LBAddtagController.h
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBAddtagController : UIViewController

/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;

@end

NS_ASSUME_NONNULL_END
