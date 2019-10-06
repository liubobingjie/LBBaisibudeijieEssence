//
//  VerticalButton.m
//  LBbaisibudejie
//
//  Created by mc on 2019/10/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.width = self.width;
    
}

@end
