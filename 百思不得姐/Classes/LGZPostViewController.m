//
//  LGZPostViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZPostViewController.h"
#import "LGZPlaceholderTextView.h"
#import "LGZAddTagToolbar.h"

@interface LGZPostViewController () <UITextViewDelegate>
/** toolbar */
@property (nonatomic, weak) LGZAddTagToolbar *toolView;
/** 文本输入框 */
@property (nonatomic, strong) LGZPlaceholderTextView *textView;

@end

@implementation LGZPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    
}

- (void)setupTextView
{
    LGZPlaceholderTextView *textView = [[LGZPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子请在这里输入段子";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    LGZAddTagToolbar *toolView = [LGZAddTagToolbar loadViewFromXib];
    toolView.width = self.view.width;
    toolView.y = self.view.height - toolView.height;
    
    [self.view addSubview:toolView];
    self.toolView = toolView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)keyboardChangFrame:(NSNotification *)note
{
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animateTime = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animateTime animations:^{
        
        self.toolView.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - [UIScreen mainScreen].bounds.size.height);
        
        
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 设置导航栏
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 由于设置后,颜色显示不正常,所以强制刷新这个界面
    [self.navigationController.navigationBar layoutIfNeeded];

}

- (void)post{
    
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
