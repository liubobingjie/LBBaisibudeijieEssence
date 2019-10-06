//
//  LBTopicPictureView.m
//  EussDemo
//
//  Created by mc on 2019/10/3.
//  Copyright © 2019 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LBTopicPictureView.h"
#import "LBProgressView.h"
#import "LBShowPictureController.h"


@interface LBTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *ClickBtn;
@property (weak, nonatomic) IBOutlet LBProgressView *progressView;

//图片的最大高度

@end

@implementation LBTopicPictureView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)]];
    
}

+(instancetype)pictureView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LBTopicPictureView class]) owner:nil options:nil].lastObject;
}
- (void)imageClick{
    
    LBShowPictureController *vc  = [[LBShowPictureController alloc]init];
    vc.topicModel = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

-(void)setTopic:(LBTopicModel *)topic{
    _topic = topic;
    
    if([topic.large_image hasSuffix:@".gif"]){
        self.gifImageView.hidden = NO;
         self.progressView.hidden = NO;
        
       
    }else{
         self.progressView.hidden = NO;
          self.gifImageView.hidden = YES;
    
    }
        self.ClickBtn.hidden = !topic.bigImage;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
       
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
        
        if(!topic.bigImage) return;
        
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        CGFloat width = topic.pictureFrame.size.width;
        
        CGFloat height = width* image.size.height/image.size.width;
        
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];
//
//    if(topic.bigImage){
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//
//    }else{
//         self.imageView.contentMode = UIViewContentModeScaleToFill;
//
//    }
    

    
}



    

- (IBAction)clickBtnJump:(id)sender {
    [self imageClick];
}
@end
