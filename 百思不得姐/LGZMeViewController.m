//
//  LGZMeViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZMeViewController.h"

@interface LGZMeViewController ()

@end

@implementation LGZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏左边的按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
        [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    moonButton.size = moonButton.currentBackgroundImage.size;
    [moonButton addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[
                                               [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                               [[UIBarButtonItem alloc] initWithCustomView:moonButton]
                                               
                                               ];

}

- (void)settingClick
{
    LGZLog(@"%s",__func__);
}

- (void)moonClick
{
    LGZLog(@"%s",__func__);
}


@end
