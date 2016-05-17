//
//  LGZMeViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/4/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZMeViewController.h"
#import "LGZMeCell.h"
#import "LGZFooterView.h"

@interface LGZMeViewController ()

@end

@implementation LGZMeViewController

static NSString * const meId = @"meCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];

    
    // 设置tableview
    [self setupTableview];
}

- (void)setupTableview
{
    // 设置没有分割线
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    // 调整tableview的显示问题
    self.tableView.sectionHeaderHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 900, 0);
    
    [self.tableView registerClass:[LGZMeCell class] forCellReuseIdentifier:meId];
    
    // 设置tableview的footerView
    LGZFooterView *view = [[LGZFooterView alloc] init];
    self.tableView.tableFooterView = view;
        
    
//    self.tableView.tableFooterView.height = ;
}



- (void)setupNav
{
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



#pragma mark - <UITableViewDatasource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meId];
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"登陆/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else
    {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
