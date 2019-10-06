//
//  LBTopicPictureView.h
//  EussDemo
//
//  Created by mc on 2019/10/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBTopicModel.h"

@interface LBTopicPictureView : UIView

@property (nonatomic, strong)LBTopicModel * topic;

+(instancetype)pictureView;

@end

