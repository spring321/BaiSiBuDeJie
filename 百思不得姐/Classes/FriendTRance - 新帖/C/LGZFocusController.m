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

@interface LGZFocusController () <UITableViewDelegate,UITableViewDataSource>
/** 存储模型数组 */
@property (nonatomic, strong) NSMutableArray *categorys;

/** 存储右边用户的数组 */
@property (nonatomic, strong) NSMutableArray *usersModel;

/**右边的tableView*/
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

/**左边的tableView*/
@property (strong, nonatomic) IBOutlet UITableView *focusCategoryTabView;

@end

@implementation LGZFocusController

static NSString * const categoryId = @"category";
static NSString * const userId = @"userCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    // 设置hud
    [SVProgressHUD show];
    
    
    // 设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        
        // 将字典数组转换为模型数组
        self.categorys = [LGZFocusCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [SVProgressHUD dismiss];
        [self.focusCategoryTabView reloadData];
        [self.focusCategoryTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    


}

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
        return self.usersModel.count;
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
        cell.userModel = self.usersModel[indexPath.row];
        return cell;

    }

}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.focusCategoryTabView){
    
        LGZFocusCategory *category = self.categorys[indexPath.row];
        NSLog(@"%@", category.name);
        
        // 通过左边的来请求右边的数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(category.id);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        NSLog(@"%@", responseObject[@"list"]);
            self.usersModel = [LGZUserModel  mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
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
