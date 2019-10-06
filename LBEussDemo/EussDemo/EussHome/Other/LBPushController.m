//
//  LBPushController.m
//  EussDemo
//
//  Created by mc on 2019/10/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBPushController.h"
#import "VerticalButton.h"
#import "Pop.h"
#import "LBPostWordController.h"

@interface LBPushController ()

@property (weak, nonatomic) UIImageView *sloganView;

@end

@implementation LBPushController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.userInteractionEnabled = YES;
    CGFloat bottonW = 72;
    CGFloat bottonH = bottonW + 30;
    CGFloat bottonY = (LBScreenH - 2* bottonH) *0.5;
    int maxCols = 3;
    int bottonStartX = 20;
    int xMargin = (LBScreenW - 2*bottonStartX - maxCols *bottonW)/(maxCols-1);
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    for(int i = 0; i<6; i++){
        VerticalButton *btn = [[VerticalButton alloc]init];
        btn.tag = i + 100;
        [self.view addSubview:btn];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.width = bottonW;
        btn.height = bottonH;
        int row = i/maxCols;
        int col = i % maxCols;
        btn.x = bottonStartX + col *(xMargin + bottonW);
        btn.y = bottonY + row * bottonH;
        CGFloat starY =  btn.y - LBScreenH;
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + 0.15 * i;
        anim.fromValue= [NSValue valueWithCGRect:CGRectMake(bottonStartX + col *(xMargin + bottonW), starY, bottonW, bottonH)];
        anim.toValue= [NSValue valueWithCGRect:CGRectMake(bottonStartX + col *(xMargin + bottonW), bottonY + row * bottonH, bottonW, bottonH)];
        
        [btn pop_addAnimation:anim forKey:nil];
        
        
    }
    
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
//    sloganView.y = LBScreenH * 0.2;
//    sloganView.centerX = LBScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, -100)];
    anim.toValue =  [NSValue valueWithCGPoint:CGPointMake(LBScreenW * 0.5, LBScreenH * 0.2)];
    
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.15;
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    
    [sloganView pop_addAnimation:anim forKey:nil];
    
    
    
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleX];
    
    [self cancelWithCompletionBlock:nil];
    
    
    
}

- (void)btnClick:(UIButton*)button{
    
    [self cancelWithCompletionBlock:^{
        if(button.tag == 102){
            //NSLog(@"发段子");
            LBPostWordController *vc = [[LBPostWordController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
            
            
        }
    }];
    
}

- (void)cancelWithCompletionBlock:(void(^)(void))completionBlock{
    
    self.view.userInteractionEnabled = NO;
    for(int i =2; i<self.view.subviews.count;i++){
        UIView *view = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centY = view.centerY + LBScreenH;
        //anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, -100)];
        anim.toValue =  [NSValue valueWithCGPoint:CGPointMake(view.centerX, centY)];
        
        //       anim.springSpeed = 10;
        //       anim.springBounciness = 10;
        //从2开始
        anim.beginTime = CACurrentMediaTime() + (i-2) * 0.1;
        
        [view pop_addAnimation:anim forKey:nil];
        
        if(i == self.view.subviews.count-1){
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                !completionBlock ? : completionBlock();
            }];
        }
        
    }
    
    
}

- (IBAction)cannel:(id)sender {
    //从2开始拿到做动画的控件
  
    [self cancelWithCompletionBlock:nil];
    
   
}


@end
