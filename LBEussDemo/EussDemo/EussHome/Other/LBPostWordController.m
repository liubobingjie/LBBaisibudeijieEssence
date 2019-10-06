//
//  LBPostWordController.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBPostWordController.h"
#import "LBPlaceholderTextView.h"

#import "LBAddtagView.h"

@interface LBPostWordController ()<UITextViewDelegate>
/** 文本输入控件 */
@property (nonatomic, weak) LBPlaceholderTextView *textView;

/** 工具条 */
@property (nonatomic, strong) LBAddtagView *toolbar;

@end

@implementation LBPostWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发段子";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    
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
    [self.navigationController.navigationBar layoutIfNeeded];
    
    [self setupText];
    
    [self setupToolbar];
    
    
    
}

- (void)setupToolbar{
    self.toolbar = [LBAddtagView addTagView];
    self.toolbar.width = self.view.width;
    self.toolbar.y = self.view.height - self.toolbar.height;
    
    [self.view addSubview:self.toolbar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - LBScreenH);
    }];
}

- (void)setupText{
    LBPlaceholderTextView *textView = [LBPlaceholderTextView new];
    textView.placeholder =  @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion: nil];
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)post{
    
}


@end
