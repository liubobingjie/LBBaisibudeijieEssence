//
//  LBCommentModel.h
//  EussDemo
//
//  Created by mc on 2019/10/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBUserModel.h"

@interface LBCommentModel : NSObject

@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LBUserModel *user;

@end


