//
//  LGZTopics.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/8.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopics.h"
#import <MJExtension.h>

@implementation LGZTopics
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"smallImage" : @"image0",
             @"largeImage" : @"image1",
             @"middleImage" : @"image2"
             };
}

// imageHeight 图片的高度
- (CGFloat)imageHeight
{
    _imageHeight =  self.height * ([UIScreen mainScreen].bounds.size.width - 40) / self.width;
//    NSLog(@"%f----%f-----%f",_imageHeight,self.height,self.width);
    if (_imageHeight >= 1000){
        _imageHeight = 250;
        _bigView = YES;
    }
    
    return _imageHeight;
}

// cell的高度
- (CGFloat)cellHeight
{
    if(!_cellHeight){
        
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell的高度
        if (_type == 29){
            return _cellHeight =  45 + 10 + textH + 44 + 10 + 10;
        }
        _cellHeight = 45 + 10 + textH + 44 + 10 + 10  + self.imageHeight + 10;
    }
//    NSLog(@"%f",_cellHeight);
    return _cellHeight;
}


// 声音时长
//- (NSString *)voiceTimeStr
//{
//    if (!_voiceTimeStr){
//        NSDate date = [[NSDate alloc] init];
//        
//    }
//}
//
@end
