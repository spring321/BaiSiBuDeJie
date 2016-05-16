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
    window_.backgroundColor = [UIColor clearColor];
    
    // 由于window必须有个跟控制器,不然程序崩溃,所以添加了一个随便的控制器;
    window_.rootViewController = [[UIViewController alloc] init];
//    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTop)]];
}

+ (void)scrollToTop
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    
    }

// 用递归方法查找所有ScrollView
+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *view in superView.subviews) {
        // 得到view的frame
        CGRect newFrame = [view.superview convertRect:view.frame toView:nil];
        CGRect winFrame = [UIApplication sharedApplication].keyWindow.bounds;
        
        BOOL isShowingOnWindow = !view.hidden && view.alpha > 0.01 && CGRectIntersectsRect(newFrame, winFrame);
        if ([view isKindOfClass:[UIScrollView class]] && isShowingOnWindow){
            CGPoint offset = view.contentOffset;
            offset.y = - view.contentInset.top;
            [view setContentOffset:offset animated:YES];
        }
        [self searchScrollViewInView:view];
    }
    
  
}


+ (void)show{
    window_.hidden = NO;
}

@end
