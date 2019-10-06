//
//  EssenceViewController.m
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EssenceViewController.h"
#import "LBWordViewController.h"
#import "LBAllViewController.h"
#import "LBvideoViewController.h"
#import "LBVoiceViewController.h"
#import "LBPictureViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, strong) UIButton *selecteButton;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精华";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = SystemGlobaBG;
    //初始化自控制器
    [self setupChildView];
    
     [self setupTitleView];
    //设置底部scrollview
    [self setupscrollview];
    
    
   
    
   
    
}

- (void)setupChildView{
   
    LBAllViewController *all = [[LBAllViewController alloc]init];
    [self addChildViewController:all];
    LBvideoViewController *video = [[LBvideoViewController alloc]init];
    [self addChildViewController:video];
    LBVoiceViewController *voice = [LBVoiceViewController new];
    [self addChildViewController:voice];
    LBPictureViewController *picture = [[LBPictureViewController alloc]init];
    [self addChildViewController:picture];
    LBWordViewController *word = [[LBWordViewController alloc]init];
    [self addChildViewController:word];
   
    
}

- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]init];
//    titleView.backgroundColor = [UIColor redColor];
//    titleView.alpha = 0.5;
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.y = 64;
    [self.view addSubview:titleView];
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    //self.indicatorView = indicatorView;
     [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    self.titleView = titleView;

    for(int i = 0;i<titles.count;i++){
        UIButton * btn = [[UIButton alloc]init];
        btn.width = titleView.width/titles.count;
        btn.height = titleView.height;
        btn.tag = i + 100;
        btn.x = i * titleView.width/titles.count;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:btn];
        if(i == 0 ){
          [btn layoutIfNeeded];
            [self btnClick:btn];
            
//            self.selecteButton.enabled = YES;
//            btn.enabled = NO;
//            self.selecteButton = btn;
//            self.indicatorView.width = btn.titleLabel.width;
//            self.indicatorView.centerX = btn.centerX;
        }
        
    }
    
    
    
   
   
    
    
}

-(void)btnClick:(UIButton*)button{
    self.selecteButton.enabled = YES;
    button.enabled = NO;
    self.selecteButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
        
    }];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (button.tag - 100) * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];

    

}

- (void)setupscrollview{
    UIScrollView *contenView = [[UIScrollView alloc]init];
    contenView.frame = self.view.bounds;
    contenView.delegate = self;
    contenView.pagingEnabled = YES;
//    CGFloat top = CGRectGetMaxY(self.titleView.frame);
//    contenView.contentInset = UIEdgeInsetsMake(top, 0, 49, 0);
    [self.view insertSubview:contenView atIndex:0];
    contenView.contentSize = CGSizeMake(contenView.width * self.childViewControllers.count, 0);
    self.contentView = contenView;
    
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc  = self.childViewControllers[index];
   
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    
    
    [self btnClick:(UIButton*)[self.titleView viewWithTag:index + 100]];
  
}



@end
