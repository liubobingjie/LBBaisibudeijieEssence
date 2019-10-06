//
//  LBAddtagController.m
//  EussDemo
//
//  Created by mc on 2019/10/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBAddtagController.h"
#import "LBTagButton.h"
#import "LBTagTextField.h"

@interface LBAddtagController ()<UITextFieldDelegate>

/** 内容 */
@property (nonatomic, weak) UIView *contentView;

/** 文本输入框 */
@property (nonatomic, weak) LBTagTextField *textField;

/** 添加按钮 */
@property (nonatomic, strong) UIButton *addButton;

/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation LBAddtagController

static int TagMargin = 5;

-(UIButton *)addButton{
    if(_addButton == nil){
        
        _addButton = [[UIButton alloc]init];
        _addButton.width = self.contentView.width;
         _addButton.height = 35;
         [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:14];
         _addButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        _addButton.backgroundColor = LBTagBg;
        _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_addButton];
        
    }
    return _addButton;
    
}

- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        
        self.tags = nil ;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.tagButtons = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    [self setupContentView];
    
    [self setupField];
    
    [self setupTags];
}
//辅助的view 设置边距
- (void)setupContentView
{
    //int TagMargin = 5;
    UIView *contentView = [[UIView alloc] init];
    contentView.x = TagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + TagMargin;
    contentView.height = LBScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
     self.textField.width = self.contentView.width;
}

-(LBTagTextField *)textField{
    if(_textField == nil){
         __weak typeof(self) weakSelf = self;
         LBTagTextField *textField = [[LBTagTextField alloc]init];
        [textField setDeleteBlock:^{
            if (weakSelf.textField.hasText) return;
            
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        }];
        
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        textField = textField;
        textField.delegate = self;
         self.textField = textField;
    }
    return _textField;
}

- (void)setupField{
    //UITextField *textField = [[UITextField alloc]init];
//    textField.width = LBScreenW;
//    textField.height = 25;
    
    
   // [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
   
    
}

- (void)addButtonClick{
    
    
    if(self.tagButtons.count == 5){
        [SVProgressHUD showErrorWithStatus:@"最多5个标签"];
        return;
    }
    
    LBTagButton *tagButton = [[LBTagButton alloc]init];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    [self updateTagButtonFrame];
    
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    
}

- (void)tagButtonClick:(UIButton*)btn{
    [btn removeFromSuperview];
    [self.tagButtons removeObject:btn];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
    
}

- (void)updateTagButtonFrame{
    
    for (int i = 0; i<self.tagButtons.count; i++) {
        LBTagButton *tagButton = self.tagButtons[i];
        if(i==0){
            tagButton.x = 0;
            tagButton.y = 0;
        }else{
            LBTagButton *lasttagButton = self.tagButtons[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lasttagButton.frame)+5;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if(rightWidth >= tagButton.width){
                tagButton.y = lasttagButton.y;
                tagButton.x= leftWidth;
            }else{//换行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lasttagButton.frame) + TagMargin;
                
            }
        }
    }
    //取出最后一个
     LBTagButton *lasttagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lasttagButton.frame) + TagMargin;
    
    if(self.contentView.width - leftWidth >= [self textFieldTextWidth]){
        self.textField.y = lasttagButton.y;
        self.textField.x = leftWidth;
    }else{
          self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lasttagButton.frame) + TagMargin;
    }
    
    
}

- (void)textDidChange{
    if(self.textField.hasText){
         self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + 5;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
    }else{
         self.addButton.hidden = YES;
    }
    [self updateTagButtonFrame];
    
    
}

- (void)done{
    
//    NSMutableArray *tags = [NSMutableArray array];
//       for (LBTagButton *tagButton in self.tagButtons) {
//        [tags addObject:tagButton.currentTitle];
//        }
    
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.hasText){
        [self addButtonClick];
    }
    return YES;
}




@end
