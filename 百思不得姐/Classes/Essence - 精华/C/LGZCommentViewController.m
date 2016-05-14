//
//  LGZCommentViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/13.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZCommentViewController.h"
#import "LGZTopicsCell.h"
#import "LGZTopics.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "LGZHotComment.h"
#import <MJExtension.h>

@interface LGZCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComment;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *recentComment;

@end

@implementation LGZCommentViewController

- (NSMutableArray *)recentComment
{
    if(!_recentComment){
        _recentComment = [NSMutableArray array];
    }
    return _recentComment;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUp];
    
    // 设置tableview的headerView
    [self setupHeaderview];
    
    // 设置刷新
    [self setRefresh];
}

// 设置刷新
- (void)setRefresh{
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableview.mj_header beginRefreshing];
}

// 获取新数据
- (void)loadNewComment{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.data_id;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotComment = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.recentComment = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self.tableview.mj_header endRefreshing];
    }];
}

// 设置tableviewHeaderview
- (void)setupHeaderview
{
    self.tableview.autoresizesSubviews = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    LGZTopicsCell *topCell = [LGZTopicsCell cell];
    topCell.topic = self.topic;
    
    topCell.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.topic.height);
    
    
    UIView *view = [[UIView alloc] init];
    view.height = topCell.height + 20;
    
    [view addSubview:topCell];
    self.tableview.tableHeaderView = view;
    
}
// 基本设置
- (void)setUp
{
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" Highlight:@"comment_nav_item_share_icon_click" traget:self action:nil];
    // 设置tableview背景色
    self.tableview.backgroundColor = LGZGolbalBG;
    
        // 监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


// 监听到键盘改变的通知
- (void)keyboardChange:(NSNotification *)note
{
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    self.bottomHeight.constant = [UIScreen mainScreen].bounds.size.height - keyboardY;
    
    // 获取键盘的动画时间
    CGFloat timeChange = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:timeChange animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    // 销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){ // 最热
        return self.hotComment.count ? self.hotComment.count : self.recentComment.count;
    }else if (section == 1){
        return self.recentComment.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComment.count){
        return 2;
    }else if (self.recentComment.count){
        return 1;
    }else{
        return 0;
    }
}

- (NSArray *)comment:(NSIndexPath *)indexpath
{
    if (indexpath.section == 0){
        return self.hotComment.count ? self.hotComment : self.recentComment;
    }
    return self.recentComment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
        LGZHotComment *comment = [self comment:indexPath][indexPath.row];
        cell.textLabel.text = comment.content;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = LGZColorWithRGB(67, 67, 67);
    label.backgroundColor = LGZGolbalBG;
    
    if (section == 0){
        label.text = self.hotComment.count ? @"最热评论" : @"最新评论";
    }else if(section == 1){
        label.text = @"最新评论";
    }
    return label;

}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0){
//        return self.hotComment.count ? @"最热评论" : @"最新评论";
//    }else if(section == 1){
//        return  @"最新评论";
//    }
//    return nil;
//}

@end
