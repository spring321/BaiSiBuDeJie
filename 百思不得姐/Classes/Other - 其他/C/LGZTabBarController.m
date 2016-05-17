//
//  LGZTabBarController.m
//  百思不得姐
//
//  Created by LGZwr on 16/4/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTabBarController.h"
#import "LGZEssenceViewController.h"
#import "LGZNewViewController.h"
#import "LGZFriendTrendsViewController.h"
#import "LGZMeViewController.h"
#import "LGZTabBar.h"
#import "LGZNavgationController.h"

@interface LGZTabBarController () <UITabBarControllerDelegate>

/** 记录点击控制器 */
@property (nonatomic, strong) UIViewController *lastController;

@end

@implementation LGZTabBarController

// 通过initialize一次性设置tabbar样式
+ (void)initialize
{
    // 创建自定,只是tabbar字体的颜色大小等
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // 通过appearance统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpChild:[[LGZEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChild:[[LGZNewViewController alloc] init] title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChild:[[LGZFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChild:[[LGZMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[LGZTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // 设置进来的第一个控制器为默认控制器
    self.lastController = self.childViewControllers[0];
    
    self.delegate = self;
    
}


// 设置tabBarItem属性
- (void)setUpChild:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    vc.view.backgroundColor = [UIColor grayColor];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    
    //     [vc04.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    // 为每个控制器包装一个navigation
    LGZNavgationController *nav = [[LGZNavgationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

#pragma mark - <UITabBarControllerDelegate>

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.lastController == viewController)
    {
//        NSDictionary *userInfo = @{
//                                   @"tableView" : viewController
//                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonClick" object:viewController userInfo:nil];
    }
    self.lastController = viewController;
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
