//
//  LGZTagButton.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTagButton.h"

@implementation LGZTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = LGZColorWithRGB(74, 139, 209);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += (3 * 5);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}
@end
