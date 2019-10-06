//
//  LBTopicCell.m
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBTopicCell.h"

#import "LBTopicPictureView.h"
#import "LBVoiceView.h"

#import "LBVideoView.h"
#import "LBCommentModel.h"
#import "LBUserModel.h"

@interface LBTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTime;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *recommentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sinaV;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIView *top_cmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;


@property (nonatomic, strong) LBTopicPictureView *pictureView;

@property (nonatomic ,strong) LBVoiceView * voiceView;

@property (nonatomic ,strong) LBVideoView * videoView;

@end

@implementation LBTopicCell

-(LBVideoView *)videoView{
    if(_videoView == nil){
        _videoView = [LBVideoView videocView];
         [self.contentView addSubview:_videoView];
    }
    
    return _videoView;
}

-(LBVoiceView *)voiceView{
    if(_voiceView == nil){
        _voiceView = [LBVoiceView VioceView];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
    
}


-(LBTopicPictureView *)pictureView{
    if(_pictureView == nil){
        _pictureView = [LBTopicPictureView pictureView];
         [self.contentView addSubview:_pictureView];
       
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     self.autoresizingMask = UIViewAutoresizingNone;
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageview;
    
}

-(void)setTopic:(LBTopicModel *)topic{
    _topic = topic;
    self.sinaV.hidden = !topic.isSina_v;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.creatTime.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@" 顶"];
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@" 踩"];
    [self setupButtonTitle:self.shareBtn count:topic.repost placeholder:@" 分享"];
    [self setupButtonTitle:self.recommentBtn count:topic.comment placeholder:@" 评论"];
    
    //设置文字
    self.text_Label.text = topic.text;
    //图片
    if (topic.type == 10){
        self.pictureView.hidden = NO;
         self.pictureView.frame = topic.pictureFrame;
        self.pictureView.topic = topic;
    }
    //声音
    if (topic.type == 31){
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.voiceFrame;
        self.voiceView.topic = topic;
    }
    
    //视频
        if (topic.type == 41){
             self.videoView.hidden = NO;
            self.videoView.frame = topic.voideFrame;
            self.videoView.topic = topic;
        }
    //段子
    if(topic.type == 29){
        self.videoView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }
    LBCommentModel *cmt = [topic top_cmt];
    
    if(cmt){
        self.top_cmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
        
    }else{
        self.top_cmtView.hidden = YES;
    }
    
    
    
    
    
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@" %.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@" %zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2* frame.origin.x;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (IBAction)dingClick:(id)sender {
}
- (IBAction)caiClick:(id)sender {
}
- (IBAction)shareClick:(id)sender {
}
- (IBAction)recommentClick:(id)sender {
}

@end
