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
#import "LGZCommentCell.h"

@interface LGZCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

/** 最热评论 */
@property (nonatomic, strong) NSMutableArray *hotComment;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *recentComment;

/** 存储数据模型 */
@property (nonatomic, strong) NSArray *Top_cmt;

/** 页码 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation LGZCommentViewController

- (NSMutableArray *)recentComment
{
    if(!_recentComment){
        _recentComment = [NSMutableArray array];
    }
    return _recentComment;
}

- (NSMutableArray *)hotComment
{
    if(!_hotComment){
        _hotComment = [NSMutableArray array];
        
    }
    return _hotComment;
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
    // 下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableview.mj_header beginRefreshing];
    
    // 上拉加载
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    // 隐藏footer
    self.tableview.mj_footer.hidden = YES;
    
 
}

// 获取更多数据
- (void)loadMoreComment
{
        // 设置请求体
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.data_id;
    params[@"hot"] = @"1";
    params[@"page"] = @(self.page);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.page++;
        [self.tableview.mj_footer endRefreshing];
        [self.tableview reloadData];
        
        // 将数据转为模型存储
        NSArray *hotArrary = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        NSArray *recArrary = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.hotComment addObjectsFromArray:hotArrary];
        [self.recentComment addObjectsFromArray:recArrary];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.recentComment.count >= total){
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.page--;
        [self.tableview.mj_footer endRefreshing];
    }];
}

// 获取新数据
- (void)loadNewComment{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.page = 2;
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.data_id;
    params[@"hot"] = @"1";

    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 第一进来,直接赋值.
        self.hotComment = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.recentComment = [LGZHotComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.recentComment.count >= total){
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self.tableview.mj_header endRefreshing];
    }];
}

// 设置tableviewHeaderview
- (void)setupHeaderview
{
    self.tableview.autoresizesSubviews = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    // 隐藏热门评论
    if (self.topic.top_cmt.count) {
        self.Top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    
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
    
        // 设置cell的高度,ios8之后可用
    self.tableview.estimatedRowHeight = 44;  // 估计高度
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    
        // 监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([LGZCommentCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
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
    
    // 恢复模型数据
    if (self.Top_cmt.count){
        self.topic.top_cmt = self.Top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 设置footer的显示与隐藏
    tableView.mj_footer.hidden = (self.recentComment.count == 0);
    
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
    LGZCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];

    LGZHotComment *comment = [self comment:indexPath][indexPath.row];
    // 将模型传递
    cell.comment = comment;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vc = [[UIView alloc] init];
    vc.size = CGSizeMake(200, 30);
    vc.x = 10;
    vc.backgroundColor = LGZGolbalBG;
    //    vc.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    

    UILabel *label = [[UILabel alloc] init];
    label.textColor = LGZColorWithRGB(67, 67, 67);
    label.backgroundColor = LGZGolbalBG;
    
    if (section == 0){
        label.text = self.hotComment.count ? @"最热评论" : @"最新评论";
    }else if(section == 1){
        label.text = @"最新评论";
    }
    label.size = CGSizeMake(200, 20);
    label.x = 10;
    [vc addSubview:label];
    
        return vc;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LGZCommentCell *cell = (LGZCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    // 让被点击cell成为第一响应者
    [cell becomeFirstResponder];
    
    UIMenuController *menuC = [UIMenuController sharedMenuController];
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(report:)];
    UIMenuItem *jubao = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(jubao:)];
    
    // 设置menuController的item
    menuC.menuItems = @[ding, report, jubao];
    
    // 设置menu显示的大小
    CGRect rect = CGRectMake(0, cell.height / 2, cell.width, cell.height / 2);
    [menuC setTargetRect:rect inView:cell];
    [menuC setMenuVisible:YES animated:YES];
}

- (void)ding:(UIMenuController *)menuController
{
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
    NSLog(@"%@", [([self comment:indexPath][indexPath.row]) content]);
}
- (void)report:(UIMenuController *)menuController
{
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
    NSLog(@"%@", [([self comment:indexPath][indexPath.row]) content]);

}
- (void)jubao:(UIMenuController *)menuController
{
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
    NSLog(@"%@", [([self comment:indexPath][indexPath.row]) content]);

}
// - (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
//
@end
