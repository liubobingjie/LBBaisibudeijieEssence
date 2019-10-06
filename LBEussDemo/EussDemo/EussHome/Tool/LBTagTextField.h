//
//  LBTagTextField.h
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBTagTextField : UITextField

@property (nonatomic, copy) void(^deleteBlock)();

@end

NS_ASSUME_NONNULL_END
