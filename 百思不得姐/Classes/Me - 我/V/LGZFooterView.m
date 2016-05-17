//
//  LGZFooterView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFooterView.h"
#import <AFNetworking.h>
#import "LGZSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "LGZSquareButton.h"
#import "LGZWebViewController.h"

@interface LGZFooterView()

/** 模型数组 */
@property (nonatomic, strong) NSArray *squares;


@end


@implementation LGZFooterView

- (NSArray *)squares
{
    if (!_squares){
        _squares = [NSArray array];
    }
    return _squares;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
        if (self = [super initWithFrame:frame]){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
//            self.height = 800;
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.squares = [LGZSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            if (self.squares.count){
                [self creatFooterview];
               
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
                }
    return  self;
}

- (void)creatFooterview
{
    NSInteger cols = 4;
    NSInteger buttonW = [UIScreen mainScreen].bounds.size.width / cols;
    NSInteger buttonH = buttonW;

    for (NSInteger i = 0; i < self.squares.count ; i++) {
        LGZSquare *square = self.squares[i];
        
        NSInteger col = i % cols;
        NSInteger row = i / cols;
                LGZSquareButton *button = [LGZSquareButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(col * buttonW, row * buttonH, buttonW, buttonH);
//        button.square = self.squares[i];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.square = square;
//        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
//        [button setTitle:square.name forState:UIControlStateNormal];
         [self addSubview:button];
    }
    NSUInteger rows = (self.squares.count + cols - 1) / cols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];

}


- (void)click:(LGZSquareButton *)button{
    
    LGZWebViewController *wvc = [[LGZWebViewController alloc] init];
    wvc.title = button.square.name;
    wvc.url = button.square.url;
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController *nav = [tabBarController selectedViewController];
    [nav pushViewController:wvc animated:YES];
}
//
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}
//
@end
