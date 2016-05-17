//
//  LGZSquareButton.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/17.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZSquareButton.h"
#import "LGZSquare.h"
#import <UIButton+WebCache.h>

@implementation LGZSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
   
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    
}


- (void)setSquare:(LGZSquare *)square
{
    _square = square;
        [self sd_setImageWithURL:[NSURL URLWithString:self.square.icon] forState:UIControlStateNormal];
        [self setTitle:self.square.name forState:UIControlStateNormal];
    
    
}

// 设置button空间中imageView与titleLabel的显示位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 10;
    self.imageView.width = 35;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;  // 这个值放前放后竟然改变imageView点击后的变化

   
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 10;
    self.titleLabel.width = self.width;
    self.titleLabel.height =  self.height - self.imageView.height;
    
}

-(void)setFrame:(CGRect)frame
{
    self.imageView.centerX = self.width / 2;
    [super setFrame:frame];
}

@end
