//
//  LBTopicModel.m
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LBTopicModel.h"
#import "NSDate+Extension.h"
#import "LBTopicPictureView.h"
#import "LBVoiceView.h"
#import "LBCommentModel.h"

#import "LBCommentModel.h"
#import "LBUserModel.h"


@implementation LBTopicModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             
             };
    
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"top_cmt":[LBCommentModel class]};
}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight{
    
    NSLog(@"%@",self.large_image);
    
    if(_cellHeight == 0){

        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //    //10 指的是底部工具条的间距 第二个10指的是减去的间距
        _cellHeight = 55 + textH + 44 + 10 + 10;
        
        //图片
        if (self.type == 10){
            //图片的宽度
            CGFloat imageW = size.width;
            CGFloat imageH = imageW * self.height / self.width;
            //1000规定一个d高度范围
            if(imageH >= 1000){
                self.bigImage = YES;
                //超过1000就设置250
                imageH = 250;
                
            }else{
                self.bigImage = NO;
            }
            
            //计算图片的尺寸
            _pictureFrame = CGRectMake(10, 55 + textH + 10, imageW, imageH);
            
            _cellHeight += imageH + 10;
            
        }
        //声音
        if (self.type == 31){
            CGFloat voiceX = 10;
             CGFloat voiceY = 55 + textH + 10;
             CGFloat voiceW = size.width;
             CGFloat voiceH = voiceW * self.height / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + 10;
            
        }
          //视频
        if(self.type == 41){
            CGFloat voiceX = 10;
            CGFloat voiceY = 55 + textH + 10;
            CGFloat voiceW = size.width;
            CGFloat voiceH = voiceW * self.height / self.width;
             _voideFrame= CGRectMake(voiceX, voiceY, voiceW, voiceH);
             _cellHeight += voiceH + 10;
            
        }
        
        //段子
        if (self.type == 29){
            
        }
        
        LBCommentModel *comt = self.top_cmt;
        if(comt != nil){
            //最热评论标题高度 16 10:底部间距
            NSString *conment = [NSString stringWithFormat:@"%@ : %@",comt.user.username,comt.content];
            
            CGFloat conmentH = [conment boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            _height = _height + 16 + 10 + conmentH;
            
        }
        
        
    }
    
   
  

    return _cellHeight;
}

@end
