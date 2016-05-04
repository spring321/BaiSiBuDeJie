//
//  LGZNavgationController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZNavgationController.h"

@interface LGZNavgationController ()

@end

@implementation LGZNavgationController


// 在initialize中统一设置LGZNavgationController中的navigationbar的背景图片,而且只会调用一次该方法
+ (void)initialize
{
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [nav setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 当不是根控制器时,才会添加返回按钮
    if (self.childViewControllers.count > 0){
        
        // 由于返回按钮无法自定义出想要的结果,所以设置left 按钮
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        // 设置按钮内容左移
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 设置按钮大小
        leftButton.size = CGSizeMake(70, 30);
        
        // 给按钮添加点击事件
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 将按钮向左边移动
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        viewController.navigationItem.leftBarButtonItem = left;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
