//
//  LGZPublishViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/12.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZPublishViewController.h"
#import "LGZOtherLoginButton.h"
#import <POP.h>
#import "LGZPostViewController.h"
#import "LGZUser.h"

#import "LGZNavgationController.h"

@interface LGZPublishViewController ()

@end

@implementation LGZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
        CGFloat buttonX = startX + (buttonW + marginX) * col;
        CGFloat buttonY = startY + (buttonH) * row;
//        button.width = buttonW;
//        button.height = buttonH;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        POPSpringAnimation *anim= [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, button.height - [UIScreen mainScreen].bounds.size.height, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX,buttonY, buttonW, buttonH)];
        
        // 设置开始时间
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        
        // 设置弹簧效果
        anim.springBounciness = 10;
        anim.springSpeed = 14;
        
        [button pop_addAnimation:anim forKey:nil];
    }
    // 背景文字
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    topImage.centerY = -topImage.height;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height * 0.12;
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    // 设置动画效果
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, -100)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.beginTime = CACurrentMediaTime() + 0.1 * 7;
    // 设置弹簧效果
    anim.springBounciness = 10;
    anim.springSpeed = 14;

    
    [topImage pop_addAnimation:anim forKey:nil];
    [self.view addSubview:topImage];

    

}

- (void)cancelWithBlock:(void (^)())completionBlock{
    self.view.userInteractionEnabled = NO;
    for (int i = 2; i < self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, [UIScreen mainScreen].bounds.size.height + subView.centerY)];
        anim.beginTime = CACurrentMediaTime() + 0.1 * (i - 2);
        
        [subView pop_addAnimation:anim forKey:nil];
        if (i == (self.view.subviews.count - 1)){
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finisher) {
                //                self.view.userInteractionEnabled = YES;
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completionBlock){
                    completionBlock();
                }else{
                    return ;
                }
            }];
        }
        
    }
    

}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithBlock:^{
        if (button.tag == 2){
            
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            
            LGZPostViewController *vc = [[LGZPostViewController alloc] init];
            
            LGZNavgationController *nav = [[LGZNavgationController alloc] initWithRootViewController:vc];
            
            vc.title = @"发表段子";
            
            [root presentViewController:nav animated:YES completion:nil];
            
            
            
        }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self cancelWithBlock:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss:nil];
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
