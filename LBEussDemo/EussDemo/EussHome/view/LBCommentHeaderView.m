//
//  LBCommentHeaderView.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBCommentHeaderView.h"

@interface LBCommentHeaderView()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation LBCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LBCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[LBCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SystemGlobaBG;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LBRGBColor(67, 67, 67);
        label.width = 200;
        label.x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}



@end
