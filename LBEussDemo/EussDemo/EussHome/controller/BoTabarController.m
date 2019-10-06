 //
//  BoTabarController.m
//  baisibobo
//
//  Created by mc on 2017/10/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BoTabarController.h"
#import "EssenceViewController.h"
#import "ViewController.h"
#import "BoTaBar.h"
@interface BoTabarController ()

@end

@implementation BoTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [self setupChindVc:[[EssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" SelectedImage:@"tabBar_essence_click_icon"];
    [self setupChindVc:[[ViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" SelectedImage:@"tabBar_new_click_icon"];
    
    [self setupChindVc:[[ViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" SelectedImage:@"tabBar_friendTrends_click_icon"];
     [self setupChindVc:[[ViewController alloc] init] title:@"我" image:@"tabBar_me_icon" SelectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[BoTaBar alloc]init] forKey:@"tabBar"];
    
    
}
//初始化控制器
-(void)setupChindVc:(UIViewController*)vc title:(NSString*)title image:(NSString *)image SelectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
   
    
}



@end
