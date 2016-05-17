//
//  LGZWebViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZWebViewController.h"
#import <NJKWebViewProgress.h>

@interface LGZWebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goForwardButton;
/** 三方框架的指示器 */
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation LGZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.autoresizingMask = NO;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    self.goForwardButton.enabled = NO;
    self.goBackButton.enabled = NO;
    
    
    // 解决循环引用问题
    __weak typeof(self) weakSelf = self;
    
    self.progressProxy.progressBlock = ^(float progress) {
        [weakSelf.progress setProgress:progress animated:YES];
        
        // 加载完成隐藏指示器
        weakSelf.progress.hidden = (progress == 1.0);
    };


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
    
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackButton.enabled = self.webView.canGoBack;
    self.goForwardButton.enabled = self.webView.canGoForward;
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
