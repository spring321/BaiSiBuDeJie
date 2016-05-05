//
//  LGZWhitePlaceholderFiled.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZWhitePlaceholderFiled.h"

@implementation LGZWhitePlaceholderFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
}

// 成为第一响应者时,设置placeholder的颜色为白色
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    return [super becomeFirstResponder];
}

// 失去第一响应者时,设置placeholder的颜色为灰色
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    return [super resignFirstResponder];
}
@end
