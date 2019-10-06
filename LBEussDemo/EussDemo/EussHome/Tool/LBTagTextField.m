//
//  LBTagTextField.m
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBTagTextField.h"

@implementation LBTagTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = 25;
        
    }
    return self;
}

-(void)deleteBackward{
     !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
    
}

@end
