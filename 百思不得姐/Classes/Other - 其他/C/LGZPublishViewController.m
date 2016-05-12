//
//  LGZPublishViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/12.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZPublishViewController.h"
#import "LGZOtherLoginButton.h"

@interface LGZPublishViewController ()

@end

@implementation LGZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景文字
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    topImage.y = [UIScreen mainScreen].bounds.size.height * 0.12;
    topImage.centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    [self.view addSubview:topImage];
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    CGFloat buttonW = 70;
    CGFloat buttonH = buttonW + 30;
    CGFloat startY = ([UIScreen mainScreen].bounds.size.height - 2 * buttonH) * 0.5;
    CGFloat startX = 15;
    CGFloat marginX = (([UIScreen mainScreen].bounds.size.width - 2 * startX) - buttonW * 3) / 2;
    for (int i = 0; i < 6; i++) {
        LGZOtherLoginButton *button = [[LGZOtherLoginButton alloc] init];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        // 行号
        int row = i / 3;
        
        // 列号
        int col = i % 3;
        button.x = startX + (buttonW + marginX) * col;
        button.y = startY + (buttonH) * row;
        button.width = buttonW;
        button.height = buttonH;
        [self.view addSubview:button];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
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
