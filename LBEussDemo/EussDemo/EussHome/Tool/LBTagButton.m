//
//  LBTagButton.m
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBTagButton.h"

@implementation LBTagButton

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = LBTagBg;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    //15间距
    self.width = self.width + 15;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //5是间距
    self.titleLabel.x = 5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

@end
