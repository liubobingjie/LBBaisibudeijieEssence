//
//  LBProgressView.m
//  EussDemo
//
//  Created by mc on 2019/10/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBProgressView.h"

@implementation LBProgressView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{

    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
