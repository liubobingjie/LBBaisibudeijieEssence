//
//  LBCommentHeaderView.h
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
