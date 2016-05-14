//
//  LGZWordViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/8.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZBaseTopicsViewController.h"
#import <AFNetWorking.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "LGZTopics.h"
#import "LGZTopicsCell.h"
#import "LGZCommentViewController.h"

@interface  LGZBaseTopicsViewController()

/** 存放topics模型数组 */
@property (nonatomic, strong) NSMutableArray *topics;
/** maxtime */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation LGZBaseTopicsViewController
static NSString * const ID = @"topicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下拉刷新
    [self getNewTopicWithHeaderAndFooter];
    [self.tableView.mj_header beginRefreshing];
    
    // 设置tableview的初始化设置
    [self setTableViewThing];
}

// 初始化tableview
- (void)setTableViewThing
{
    self.tableView.backgroundColor = [UIColor clearColor];
    // 设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGZTopicsCell class]) bundle:nil] forCellReuseIdentifier:ID];
}
/*
 // 设置下拉刷新控件
 - (void)setHeaderRefresh
 {
 [self.tableView.mj_header beginRefreshing];
 
 }*/

// 下拉刷新
- (void)getNewTopicWithHeaderAndFooter
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewTopics)];
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreTopics)];
    
}
// 获得新数据
- (void)getNewTopics
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [manger GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.topics = [LGZTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 获得更多数据
- (void)getMoreTopics
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *moreTopics = [LGZTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-------");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = !(self.topics.count);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LGZTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topic = self.topics[indexPath.row];
    
        
    return cell;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGZTopics *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGZCommentViewController *vc = [[LGZCommentViewController alloc] init];
    vc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
