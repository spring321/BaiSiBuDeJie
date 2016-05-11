//
//  LGZTopicPictureView.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/11.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGZTopics;
@interface LGZTopicPictureView : UIView

/** 模型 */
@property (nonatomic, strong) LGZTopics *topic;

+ (instancetype)topicPictureView;

@end
