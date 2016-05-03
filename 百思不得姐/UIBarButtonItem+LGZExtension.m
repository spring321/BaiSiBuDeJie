//
//  UIBarButtonItem+LGZExtension.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "UIBarButtonItem+LGZExtension.h"

@implementation UIBarButtonItem (LGZExtension)

+ (instancetype)itemWithImage:(NSString *)image Highlight:(NSString *)highlight traget:(id)traget action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:traget action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
