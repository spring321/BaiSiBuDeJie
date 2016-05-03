//
//  LGZTabBar.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTabBar.h"

@interface LGZTabBar()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation LGZTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        self.publishButton = publishButton;
        [self addSubview:self.publishButton];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.width / 2, self.height / 2);
    
    // 设置其他按钮的位置
    NSInteger index = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            CGFloat buttonX = 0;
            
            buttonX = buttonW * ((index > 1)?(index +1):index);
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
           
        }
    }
}

@end
