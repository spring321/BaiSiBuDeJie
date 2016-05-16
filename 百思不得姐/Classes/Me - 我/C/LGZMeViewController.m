//
//  LGZMeViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/4/3.
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
    
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" Highlight:@"mine-setting-icon-click" traget:self action:@selector(settingClick)];
    
    
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" Highlight:@"mine-moon-icon-click" traget:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                               settingButton,
                                               moonButton
                                               
                                               ];
    self.view.backgroundColor = LGZGolbalBG;

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
