//
//  LGZTagTableViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTagTableViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "LGZTagCell.h"
#import <MJExtension.h>
#import "LGZTagsModel.h"
@interface LGZTagTableViewController ()
/** 存储tags模型数组 */
@property (nonatomic, strong) NSMutableArray *tagsArrary;

@end

@implementation LGZTagTableViewController

static NSString * const tagId = @"tag";

- (NSMutableArray *)tagsArrary
{
    if (!_tagsArrary)
    {
        _tagsArrary = [NSMutableArray array];
    }
    return _tagsArrary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setUpTableView];
    
    // 发送请求
    [self sendGet];
    
    [SVProgressHUD show];
    
}

- (void)setUpTableView
{
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LGZGolbalBG;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGZTagCell class]) bundle:nil] forCellReuseIdentifier:tagId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)sendGet
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseObject);
        self.tagsArrary = [LGZTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
                NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = self.tagsArrary.count;
    NSLog(@"%zd",count);

    return count;
    }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LGZTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagId];
    cell.tagModel = self.tagsArrary[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
