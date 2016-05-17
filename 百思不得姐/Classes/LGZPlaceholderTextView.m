//
//  LGZPlaceholderTextView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZPlaceholderTextView.h"

@implementation LGZPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        self.placeholderColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) return;
    
    // 设置绘制的区域
    CGRect placeholderRect = CGRectMake(4, 7, self.width - 6, self.height);
    
    // 设置文字属性
    NSMutableDictionary *attris = [NSMutableDictionary dictionary];
    attris[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attris[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attris];
}

#pragma mark - 重写各种setter方法

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


@end
