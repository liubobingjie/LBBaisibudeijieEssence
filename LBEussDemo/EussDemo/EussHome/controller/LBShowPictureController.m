//
//  LBShowPictureController.m
//  EussDemo
//
//  Created by mc on 2019/10/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBShowPictureController.h"

@interface LBShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;


@end

@implementation LBShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]init];
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)]];
    
    [self.scrollView addSubview:self.imageView];
    
    CGFloat pictureW = [UIScreen mainScreen].bounds.size.width;
    CGFloat pictureH = pictureW * self.topicModel.height /self.topicModel.width;
    
    if(pictureH > [UIScreen mainScreen].bounds.size.height){
        //超出屏幕需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
        
        
    }else{
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image]];
    
    
    
    
    
}
- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
