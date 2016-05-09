//
//  LGZTopicsCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/9.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopicsCell.h"
#import "LGZTopics.h"

@implementation LGZTopicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
//    [bgView setImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = bgView;
}

// 设置模型数据
- (void)setTopic:(LGZTopics *)topic
{
    _topic = topic;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
