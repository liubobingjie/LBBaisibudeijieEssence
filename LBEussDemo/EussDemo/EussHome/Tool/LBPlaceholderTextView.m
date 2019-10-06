//
//  LBPlaceholderTextView.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBPlaceholderTextView.h"

@interface LBPlaceholderTextView()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation LBPlaceholderTextView
- (UILabel *)placeholderLabel{
    if(_placeholderLabel == nil){
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor= [UIColor grayColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)textDidChange{
    self.placeholderLabel.hidden = self.hasText;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


@end
