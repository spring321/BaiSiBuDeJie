//
//  LGZTabBarController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTabBarController.h"

@interface LGZTabBarController ()

@end

@implementation LGZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建自定,只是tabbar字体的颜色大小等
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // 通过appearance统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];

    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.view.backgroundColor = [UIColor redColor];
    vc01.tabBarItem.title = @"精华";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    
//    [vc01.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    [self addChildViewController:vc01];
    
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.view.backgroundColor = [UIColor blueColor];
    vc02.tabBarItem.title = @"最新";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
//    [vc02.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    [self addChildViewController:vc02];
    
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.view.backgroundColor = [UIColor greenColor];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
//     [vc03.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    [self addChildViewController:vc03];
    
    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.view.backgroundColor = [UIColor grayColor];
    vc04.tabBarItem.title = @"我的";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
//     [vc04.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    [self addChildViewController:vc04];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
