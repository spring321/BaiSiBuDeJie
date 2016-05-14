//
//  LGZEssenceViewController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZEssenceViewController.h"
#import "LGZTagTableViewController.h"
#import "LGZBaseTopicsViewController.h"

@interface LGZEssenceViewController () <UIScrollViewDelegate>
/** 底部指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 指示器选中状态 */
@property (nonatomic, weak) UIButton *selectedBtn;

/** ScrollView */
@property (nonatomic, weak) UIScrollView *scrollVc;

/** titlesView */
@property (nonatomic, weak) UIView *titlesView;


@end

@implementation LGZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置子控制器
    [self setChildViewController];
    
    // 设置UIScrollView
    [self setScrollView];

    
    // 设置顶部标题栏
    [self setTitlesView];
    

    [self scrollViewDidEndScrollingAnimation:self.scrollVc];
}

// 设置子控制器
- (void)setChildViewController
{
    LGZBaseTopicsViewController *vc0 = [[LGZBaseTopicsViewController alloc] init];
    vc0.title = @"全部";
    vc0.type = LGZTopicTypeAll;
    [self addChildViewController:vc0];
    LGZBaseTopicsViewController *vc1 = [[LGZBaseTopicsViewController alloc] init];
    vc1.title = @"视频";
    vc1.type = LGZTopicTypeVideo;
    [self addChildViewController:vc1];
    LGZBaseTopicsViewController *vc2 = [[LGZBaseTopicsViewController alloc] init];
    vc2.title = @"声音";
    vc2.type = LGZTopicTypeVoice;
    [self addChildViewController:vc2];
    LGZBaseTopicsViewController *vc3 = [[LGZBaseTopicsViewController alloc] init];
    vc3.title = @"图片";
    vc3.type = LGZTopicTypePicture;
    [self addChildViewController:vc3];
    LGZBaseTopicsViewController *vc4 = [[LGZBaseTopicsViewController alloc] init];
    vc4.title = @"段子";
    vc4.type = LGZTopicTypeWord;
    [self addChildViewController:vc4];


}

// 设置UIScrollView
- (void)setScrollView
{
    UIScrollView *scrollVc = [[UIScrollView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollVc.frame = self.view.bounds;
    scrollVc.pagingEnabled = YES;
    scrollVc.delegate = self;
    scrollVc.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count,0);
//    scrollVc.backgroundColor = [UIColor redColor];
    
    self.scrollVc = scrollVc;
    [self.view addSubview:scrollVc];
}

# pragma mark -UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 通过偏移获取索引
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = self.view.width * index;
    vc.view.y = 0;
    vc.view.height = self.view.height;
    
    // 设置内边距
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);

    CGFloat bottom = self.tabBarController.tabBar.height;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;

    [scrollView addSubview:vc.view];
    
        
    self.selectedBtn.enabled = YES;
    UIButton *btn = (UIButton *)self.titlesView.subviews[index];
    
    btn.enabled = NO;
    self.selectedBtn = btn;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


// 设置顶部标题栏
- (void)setTitlesView
{
    // 设置titlesView
    UIView *titlesView = [[UIView alloc] init];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.x = 0;
    titlesView.y = 64;
    titlesView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 设置指示器标签
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = titlesView.width / self.childViewControllers.count;
        btn.height = titlesView.height;
        btn.y = 0;
        btn.x = i * btn.width;
        btn.tag = i;
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titlesView addSubview:btn];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0){
            btn.enabled = NO;
            self.selectedBtn = btn;
            // 更新titleLabel的大小
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
    }
    
    // 设置指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - 2;
    
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;

    
}

// 标签的点击事件
- (void)click:(UIButton *)button
{
    button.enabled = NO;
    self.selectedBtn.enabled = YES;
    self.selectedBtn = button;
    
    // 动画的点击事件
    [UIView animateWithDuration:0.4 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;

    }];
    
    CGPoint content = self.scrollVc.contentOffset;
    content.x = self.selectedBtn.tag * self.scrollVc.width;
    [self.scrollVc setContentOffset:content animated:YES];
}

-(void)setupNav
{
    // 设置标题
    UIImage *titleImage = [UIImage imageNamed:@"MainTitle"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleImage];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" Highlight:@"MainTagSubIconClick" traget:self action:@selector(tagClick)];
    self.view.backgroundColor = LGZGolbalBG;

}

- (void)tagClick
{
    
    LGZTagTableViewController *vc = [[LGZTagTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
