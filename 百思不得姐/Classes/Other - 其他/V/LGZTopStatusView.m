//
//  LGZTopStatusView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/14.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopStatusView.h"

@implementation LGZTopStatusView

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.backgroundColor = [UIColor redColor];
//    window_.rootViewController = [[LGZEssenceViewController alloc] init];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTop)]];
}

+ (void)scrollToTop
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    NSLog(@"----");
}

// 用递归方法查找所有ScrollView
+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *view in superView.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]){
            [view setContentOffset:CGPointZero animated:YES];
        }
        [self searchScrollViewInView:view];
    }
    
  
}


+ (void)show{
    window_.hidden = NO;
}

@end
