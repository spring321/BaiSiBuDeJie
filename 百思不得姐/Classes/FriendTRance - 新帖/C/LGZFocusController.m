//
//  LGZFocusController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFocusController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "LGZFocusCategory.h"
#import "LGZFocusCategoryCell.h"
#import "LGZUserCell.h"
#import "LGZUserModel.h"
#import <MJRefresh.h>

#define LGZFocusSelected self.categorys[self.focusCategoryTabView.indexPathForSelectedRow.row]

@interface LGZFocusController () <UITableViewDelegate,UITableViewDataSource>
/** 存储左边模型数组 */
@property (nonatomic, strong) NSMutableArray *categorys;

///** 存储右边用户的数组 */
//@property (nonatomic, strong) NSMutableArray *usersModel;

/**右边的tableView*/
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

/**左边的tableView*/
@property (strong, nonatomic) IBOutlet UITableView *focusCategoryTabView;

/** 存储请求 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** afn的manger */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LGZFocusController

static NSString * const categoryId = @"category";
static NSString * const userId = @"userCell";

- (AFHTTPSessionManager *)manager
{
    if (!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self setTableViewFoot];
    // 设置hud
    [SVProgressHUD show];
    
    
    [self getLeftCategory];
}

// 获得左侧数据
- (void)getLeftCategory
{
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@", responseObject);
        
        // 将字典数组转换为模型数组
        self.categorys = [LGZFocusCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [SVProgressHUD dismiss];
        [self.focusCategoryTabView reloadData];
        [self.focusCategoryTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    
    

}

#pragma mark - 设置刷新控件
- (void)setTableViewFoot
{
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}

- (void)loadNewUsers
{
    
        LGZFocusCategory *c = LGZFocusSelected;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        
        self.params = params;
        [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        NSLog(@"%@", responseObject[@"list"]);
            if (self.params != params) return;
            NSArray *usersModel = [LGZUserModel  mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [c.users removeAllObjects];
            [c.users addObjectsFromArray:usersModel];
            c.total = [responseObject[@"total"] integerValue];
            c.total_page = [responseObject[@"total_page"] integerValue];
            c.next_page = [responseObject[@"next_page"] integerValue];
            
            [self.userTableView reloadData];
            
            [self.userTableView.mj_header endRefreshing];
            
            // 判断一下页数是否大于总页数
            if(c.next_page > c.total_page){
                [self.userTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.userTableView.mj_footer endRefreshing];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    

}

- (void)loadMoreUsers
{
    LGZFocusCategory *c = LGZFocusSelected;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    
    params[@"page"] = @(c.next_page);
    
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@", responseObject[@"list"]);
        if (self.params != params) return;
        NSArray *usersModel = [LGZUserModel  mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [c.users addObjectsFromArray:usersModel];
        c.total = [responseObject[@"total"] integerValue];
        c.total_page = [responseObject[@"total_page"] integerValue];
        c.next_page = [responseObject[@"next_page"] integerValue];
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_footer endRefreshing];
        
        if (c.next_page > c.total_page){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

// 设置tableView
- (void)setUpTableView
{

    self.view.backgroundColor = LGZGolbalBG;
    // 设置title
    self.navigationItem.title = @"推荐关注";
    
    // 注册左边cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LGZFocusCategoryCell class]) bundle:nil];
    [self.focusCategoryTabView registerNib:nib forCellReuseIdentifier:categoryId];
    
    // 注册右边的cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGZUserCell class]) bundle:nil] forCellReuseIdentifier:userId];
    // 设置tabView的背景色为透明
    self.focusCategoryTabView.backgroundColor = [UIColor clearColor];
    
    // 设置不自动空出一段距离
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.focusCategoryTabView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userTableView.rowHeight = 70;


}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.focusCategoryTabView ){
        return self.categorys.count;
    }else{
        LGZFocusCategory *c = LGZFocusSelected;
        self.userTableView.mj_footer.hidden = (c.users.count == 0);
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.focusCategoryTabView){
        LGZFocusCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
        cell.category = self.categorys[indexPath.row];
        return cell;
    }else{
        LGZUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userId];
        
        LGZFocusCategory *c = LGZFocusSelected;
        cell.userModel = c.users[indexPath.row];
        return cell;

    }

}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LGZFocusCategory *category = self.categorys[indexPath.row];
//    LGZUserModel *c = [LGZFocusSelected users];
    [self.userTableView.mj_header endRefreshing];
    if ([LGZFocusSelected users].count)
    {
        [self.userTableView reloadData];
    }else{
        
            // 防止点击没反应
            [self.userTableView reloadData];
            [self.userTableView.mj_header beginRefreshing];

        
        }
 }

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
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
