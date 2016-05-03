//
//  LGZNewViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZNewViewController.h"

@interface LGZNewViewController ()

@end

@implementation LGZNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    UIImage *titleImage = [UIImage imageNamed:@"MainTitle"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleImage];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" Highlight:@"MainTagSubIconClick" traget:self action:@selector(newClick)];
    self.view.backgroundColor = LGZGolbalBG;
}

- (void)newClick
{
    LGZLog(@"%s",__func__);
}

@end
