//
//  LGZEssenceViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZEssenceViewController.h"

@interface LGZEssenceViewController ()

@end

@implementation LGZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    UIImage *titleImage = [UIImage imageNamed:@"MainTitle"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleImage];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" Highlight:@"MainTagSubIconClick" traget:self action:@selector(tagClick)];
    self.view.backgroundColor = LGZGolbalBG;
}

- (void)tagClick
{
    LGZLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
