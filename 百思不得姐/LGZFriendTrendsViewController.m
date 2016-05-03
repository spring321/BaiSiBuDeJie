//
//  LGZFriendTrendsViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFriendTrendsViewController.h"

@interface LGZFriendTrendsViewController ()

@end

@implementation LGZFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" Highlight:@"friendsRecommentIcon-click" traget:self action:@selector(friendClick)];
    
}

- (void)friendClick
{
    LGZLog(@"%s",__func__);
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
