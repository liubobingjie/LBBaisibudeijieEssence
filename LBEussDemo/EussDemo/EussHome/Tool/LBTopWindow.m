//
//  LBTopWindow.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBTopWindow.h"

@implementation LBTopWindow
static  UIWindow *window_;

+(void)initialize{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake(0, 0, LBScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
    
}
+ (void)show{
    window_.hidden = NO;
}
+ (void)hide
{
    window_.hidden = YES;
}

+ (void)windowClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
    
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top -35;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end
