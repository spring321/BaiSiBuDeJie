//
//  LGZOtherLoginButton.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZOtherLoginButton.h"

@implementation LGZOtherLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
//    self.backgroundColor = [UIColor redColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


// 设置button空间中imageView与titleLabel的显示位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.width;
    self.titleLabel.width = self.width;
    self.titleLabel.height =  self.height - self.width;
    
    
}

@end
