//
//  LBAddtagView.m
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBAddtagView.h"
#import "LBAddtagController.h"

@interface LBAddtagView()
@property (weak, nonatomic) IBOutlet UIView *topView;

/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;

@end

@implementation LBAddtagView

+ (instancetype)addTagView{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LBAddtagView class]) owner:nil options:nil].lastObject;
}

-(NSMutableArray *)tagLabels{
    if(_tagLabels == nil){
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    UIButton *addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = 10;
    [self.topView addSubview:addButton];
    self.addButton = addButton;

}

- (void)addButtonClick{
    LBAddtagController *vc = [[LBAddtagController alloc]init];
    __weak typeof(self) weakSelf = self;
    [vc setTagsBlock:^(NSArray * _Nonnull tags) {
         [weakSelf createTagLabels:tags];
        
    }];
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
     UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    
    [nav pushViewController:vc animated:YES];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 5;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + 5;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 5;
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + 5;
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
    
}


/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
     [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = LBTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * 5;
        tagLabel.height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    
     [self setNeedsLayout];
    
}

@end
