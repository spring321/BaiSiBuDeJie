//
//  LGZAddTagViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZAddTagViewController.h"
#import "LGZTagButton.h"
#import "LGZTagTextFieldView.h"

@interface LGZAddTagViewController () <UITextFieldDelegate>

/** 内容视图 */
@property (nonatomic, weak) UIView *contentView;


/** 文本输入框 */
@property (nonatomic, weak) LGZTagTextFieldView *textFiled;

/** 添加标签按钮  */
@property (nonatomic, weak) UIButton *addTagButton;

/** 存放所有标签数组 */
@property (nonatomic, strong) NSMutableArray *tagButtons;



@end



@implementation LGZAddTagViewController

// 懒加载
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons)
    {
        NSMutableArray *tagButtons = [NSMutableArray array];
        _tagButtons = tagButtons;
    }
    return _tagButtons;
}

- (UIButton *)addTagButton
{
    if(!_addTagButton)
    {
        UIButton *addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 对button做一些一次性初始化
        addTagButton.width = self.contentView.width;
        addTagButton.height = 35;
        // 设置背景色
        addTagButton.backgroundColor = LGZColorWithRGB(74, 139, 209);
        // 设置字体颜色
        [addTagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        
        // 设置内部空间靠左
        [addTagButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        [addTagButton addTarget:self action:@selector(addTagClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addTagButton];
        
        _addTagButton = addTagButton;

    }
    return _addTagButton;
}

// 添加标签的点击事件
- (void)addTagClick
{
    LGZTagButton *button = [LGZTagButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [button setTitle:self.textFiled.text forState:UIControlStateNormal];
    
//    [button sizeToFit];
    [self.contentView addSubview:button];
    button.height = self.textFiled.height;
    
    // 清空textFiled
    self.textFiled.text = nil;
    self.addTagButton.hidden = YES;
    
    // 将按钮存放在数组中
    [self.tagButtons addObject:button];
    
    
    
    [self updateButtonFrame];
    
    
}
// 监听tagButton的点击事件
- (void)tagButtonClick:(LGZTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self updateButtonFrame];
    }];
}

// 计算按钮的位置和textFiled的位置变化
- (void)updateButtonFrame
{
    if(self.tagButtons.count == 0)
    {
        self.textFiled.x = 0;
        self.textFiled.width = self.contentView.width;
        
    }
    
    for (int i = 0; i< self.tagButtons.count; i++) {
        
        // 取出对应按钮
        LGZTagButton *button = self.tagButtons[i];
        if (i == 0) // 如果是第一个标签
        {
            button.x = 0;
            button.y = 0;
            
        }else
        {
            // 取出上一个按钮
            LGZTagButton *lastButton = self.tagButtons[i - 1];
            // 算出剩余长度
            CGFloat rightWidth = self.contentView.width - CGRectGetMaxX(lastButton.frame) - 5;
            
            if (button.width > rightWidth) // 如果剩余长度不够显示,换行
            {
                button.x = 0;
                button.y = CGRectGetMaxY(lastButton.frame)+ 5;
            }
            else{
                button.y = lastButton.y;
                button.x = CGRectGetMaxX(lastButton.frame) + 5;
            }
        }
        self.textFiled.x = CGRectGetMaxX(button.frame) + 5;
        self.textFiled.width = self.contentView.width - self.textFiled.x;
        if (self.textFiled.width < 200) // textFiled换行
        {
            self.textFiled.y = CGRectGetMaxY(button.frame) + 5;
            self.textFiled.width = self.contentView.width;

            self.textFiled.x = 0;

        }else
        {
            self.textFiled.centerY = button.centerY;

        }
        
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setContentView];
    
    [self setTextFiled];
    
    [self tagsForIn];
    
}

- (void)tagsForIn
{
    if (self.tags.count == 0) return;
    for (NSString *text in self.tags) {
        self.textFiled.text = text;
        [self addTagClick];

    }
}


- (void)setTextFiled
{
    LGZTagTextFieldView *textFiled = [[LGZTagTextFieldView alloc] init];
    textFiled.width = self.contentView.width;
    textFiled.height = 35;
    textFiled.placeholder = @"请用换行添加标签";
    textFiled.delegate = self;
    
    
    // 防止循环引用
    __weak typeof(self) weakSelf = self;
    // 实现textFiled的block
    textFiled.deleteBlock = ^(){
      
        if(self.textFiled.hasText) return;
        
        [weakSelf tagButtonClick:[self.tagButtons lastObject]];
    };
    
    [textFiled addTarget:self action:@selector(textFiledChangText) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textFiled];
    self.textFiled = textFiled;
}

#pragma mark - <LGZTagTextFieldViewDelegate>
- (BOOL)textFieldShouldReturn:(LGZTagTextFieldView *)textField
{
    if(textField.hasText)
    {
        [self addTagClick];
    }
    return YES;
    
}

// 监听textfiled的输入情况
- (void)textFiledChangText
{
    self.addTagButton.hidden = !(self.textFiled.hasText);
    self.addTagButton.y = CGRectGetMaxY(self.textFiled.frame);
    [self.addTagButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textFiled.text] forState:UIControlStateNormal];
}


- (void)setContentView
{
    UIView *contentView = [[UIView alloc] init];
    
    contentView.x = 5;
    contentView.width = [UIScreen mainScreen].bounds.size.width - 2 * contentView.x;
    contentView.y = 64 + 10;
    contentView.height = [UIScreen mainScreen].bounds.size.height;
//    contentView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupNav
{
    self.navigationItem.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishClick)];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.frame = [UIScreen mainScreen].bounds;
}

// 监听完成按钮点击
- (void)finishClick
{
    // 通过kvc获取每个按钮的title
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    
    // 回调
    !self.returnTagBlock ? : self.returnTagBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textFiled becomeFirstResponder];
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
