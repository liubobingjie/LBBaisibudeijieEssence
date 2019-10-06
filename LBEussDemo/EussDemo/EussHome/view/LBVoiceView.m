//
//  LBVoiceView.m
//  EussDemo
//
//  Created by mc on 2019/10/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBVoiceView.h"
#import "LBShowPictureController.h"

@interface LBVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *openCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLenght;

@end

@implementation LBVoiceView

+(instancetype)VioceView{
    return [[NSBundle mainBundle]loadNibNamed:@"LBVoiceView" owner:nil options:nil].lastObject;
}

-(void)setTopic:(LBTopicModel *)topic{
    _topic = topic;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.openCount.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.timeLenght.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)]];
    
}

- (void)imageClick{
    
    LBShowPictureController *vc  = [[LBShowPictureController alloc]init];
    vc.topicModel = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}


@end
