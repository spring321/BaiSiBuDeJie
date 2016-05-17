//
//  LGZPlaceholderTextView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZPlaceholderTextView.h"
@interface LGZPlaceholderTextView()

/** 占位label */
@property (nonatomic, weak) UILabel *textViewLabel;
@end


@implementation LGZPlaceholderTextView

- (UILabel *)textViewLabel
{
    if (!_textViewLabel)
    {
        UILabel *textViewLabel = [[UILabel alloc] init];
        textViewLabel.numberOfLines = 0;
        textViewLabel.x = 4;
        textViewLabel.y = 7;
//        textViewLabel.width = [UIScreen mainScreen].bounds.size.width - 2 * textViewLabel.x;
        [self addSubview:textViewLabel];
        _textViewLabel = textViewLabel;
        
        
    }
    
    return _textViewLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        // 设置始终可以拖拽
        self.alwaysBounceVertical = YES;
        self.placeholderColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)textDidChange
{
    self.textViewLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)drawRect:(CGRect)rect {
//    
//    if (self.hasText) return;
//    
//    // 设置绘制的区域
//    CGRect placeholderRect = CGRectMake(4, 7, self.width - 6, self.height);
//    
//    // 设置文字属性
//    NSMutableDictionary *attris = [NSMutableDictionary dictionary];
//    attris[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    attris[NSForegroundColorAttributeName] = self.placeholderColor;
//    
//    [self.placeholder drawInRect:placeholderRect withAttributes:attris];
//}

#pragma mark - 重写各种setter方法

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.textViewLabel.text = self.placeholder;
    [self textDidChange];
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.textViewLabel.textColor = self.placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.textViewLabel.font = font;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
    [self setNeedsLayout];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textViewLabel.width = self.width - 2 * self.textViewLabel.x;
    [self.textViewLabel sizeToFit];
}

@end
