//
//  LBTopicModel.h
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCommentModel.h"

@interface LBTopicModel : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的w宽度 */
@property (nonatomic,assign) CGFloat width;
/** 图片的w高度 */
@property (nonatomic,assign) CGFloat height;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/**评论数组*/
@property (nonatomic, strong) LBCommentModel *top_cmt;




@property (nonatomic,assign) NSInteger type;
//图片的尺寸
@property (nonatomic,assign) CGRect pictureFrame;
//声音尺寸
@property (nonatomic,assign) CGRect voiceFrame;

@property (nonatomic, assign) CGRect voideFrame;

/** 图片路径 */
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *middle_image;

@property (nonatomic, assign)BOOL bigImage;



/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

@property (nonatomic,assign) CGFloat cellHeight;

@end

