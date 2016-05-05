//
//  LGZVLoginResginController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZVLoginResginController.h"

@interface LGZVLoginResginController ()
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

// 登陆框距离父控件的距离
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LGZVLoginResginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置圆角图片
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
    
//    // 判断输入框是不是第一响应者
//    if ([self.phoneField isFirstResponder])
//    {
//        [self setWhiteTextColor];
//    }else
//    {
//        [self setGrayTextColor];
//    }
//    if ([self.passwordField isFirstResponder])
//    {
//        [self setWhiteTextColor];
//    }else
//    {
//        [self setGrayTextColor];
//    }
//
    
    
}


//// 这是输入框palceHolder字体颜色
//- (void)setWhiteTextColor
//{
//    NSMutableDictionary *attribitus = [NSMutableDictionary dictionary];
//    attribitus[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attribitus];
//    
//}
//- (void)setGrayTextColor
//{
//    NSMutableDictionary *attribitus = [NSMutableDictionary dictionary];
//    attribitus[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attribitus];
//}
//
- (IBAction)loginOrResingButton:(UIButton *)sender {
    
    if (self.loginViewLeftMargin.constant == 0){
    self.loginViewLeftMargin.constant = - self.view.width;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }else{
        self.loginViewLeftMargin.constant = 0;
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
