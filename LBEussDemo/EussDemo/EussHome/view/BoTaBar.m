//
//  BoTaBar.m
//  baisibobo
//
//  Created by mc on 2017/10/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BoTaBar.h"

#import  "LBPushController.h"

@interface  BoTaBar()

@property (nonatomic, weak) UIButton *publishButton;

@end
@implementation BoTaBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        [self.publishButton addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)pushClick{
    LBPushController *vc = [[LBPushController alloc]init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        // if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
                 // 增加索引
        index++;
    }

    
}


@end
