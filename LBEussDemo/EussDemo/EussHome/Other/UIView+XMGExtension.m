//
//  UIView+XMGExtension.m
//  01-百思不得姐
//
//
//

#import "UIView+XMGExtension.h"

@implementation UIView (XMGExtension)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
    
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;

}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)centerY{
    return self.center.y;
    
}
-(CGFloat)centerX{
     return self.center.x;    
}

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [window convertRect:self.frame fromView:self.superview];
    
    CGRect winBounds = window.bounds;
     // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersect = CGRectIntersectsRect(newFrame, winBounds);
    
     return !self.isHidden && self.alpha > 0.01 && self.window == window && intersect;
    
    
}
@end
