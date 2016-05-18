//
//  LGZAddTagToolbar.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZAddTagToolbar.h"
#import "LGZAddTagViewController.h"
@interface LGZAddTagToolbar()

/**
 * 最上面的view
 */
@property (strong, nonatomic) IBOutlet UIView *tooView;

/** 添加标签按钮 */
@property (nonatomic, weak) UIButton *addButton;

/** 存放标签label的数组 */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end


@implementation LGZAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if(!_tagLabels)
    {
        NSMutableArray *tagLabels = [NSMutableArray array];
        _tagLabels = tagLabels;
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    
    addButton.size = [addButton currentImage].size;
    
    [addButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.addButton = addButton;
    
    
    [self.tooView addSubview:addButton];
    
    
    
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.height = CGRectGetMaxY(self.addButton.frame) + 44 +5;
//    self.y = [UIScreen mainScreen].bounds.size.height - self.height;
//
//    }

- (void)buttonClick
{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 获得界面的导航控制器
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    
    LGZAddTagViewController *vc = [[LGZAddTagViewController alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [vc setReturnTagBlock:^(NSArray *tags){
        [weakSelf creatTagLabels:tags];
    }];
    
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    [nav pushViewController:vc animated:YES];
    
}

- (void)creatTagLabels:(NSArray *)tags
{
    if (tags){
        
        [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // 先清空
        
        self.tagLabels = nil;
    }
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.backgroundColor = LGZColorWithRGB(74, 139, 209);
        tagLabel.font = [UIFont systemFontOfSize:14];
        tagLabel.textColor = [UIColor whiteColor];
        [tagLabel sizeToFit];
        tagLabel.width += 2 * 5;
        tagLabel.height = 25;
        [self.tooView addSubview:tagLabel];
        [self.tagLabels addObject:tagLabel];
        
        // 设置位置
        if (i == 0) // 如果是第一个标签
        {
            tagLabel.x = 0;
            tagLabel.y = 0;
            
        }else
        {
            // 取出上一个按钮
            UILabel *lastLabel = self.tagLabels[i - 1];
            // 算出剩余长度
            CGFloat rightWidth = self.tooView.width - CGRectGetMaxX(lastLabel.frame) - 5;
            
            if (tagLabel.width > rightWidth) // 如果剩余长度不够显示,换行
            {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastLabel.frame)+ 5;
            }
            else{
                tagLabel.y = lastLabel.y;
                tagLabel.x = CGRectGetMaxX(lastLabel.frame) + 5;
            }
        }

    }
    // 获取最后一个label
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 5;
    
    // 更新button位置
    if(self.tooView.width - leftWidth >= self.addButton.width)
    {
        self.addButton.centerY = lastTagLabel.centerY;
        self.addButton.x = leftWidth;
    }else
    {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + 5;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
