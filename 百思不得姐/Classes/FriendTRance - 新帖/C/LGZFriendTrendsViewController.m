//
//  LGZFriendTrendsViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/4/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFriendTrendsViewController.h"
#import "LGZFocusController.h"
#import "LGZVLoginResginController.h"

@interface LGZFriendTrendsViewController ()

@end

@implementation LGZFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" Highlight:@"friendsRecommentIcon-click" traget:self action:@selector(friendClick)];
    self.view.backgroundColor = LGZGolbalBG;
    
}

- (void)friendClick
{
    LGZFocusController *vc = [[LGZFocusController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)loginResginBtn:(id)sender {
    
    LGZVLoginResginController *vc = [[LGZVLoginResginController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
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
