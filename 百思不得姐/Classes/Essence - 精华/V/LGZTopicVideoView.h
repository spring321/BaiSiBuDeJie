//
//  LGZTopicVideoView.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/13.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGZTopics;

@interface LGZTopicVideoView : UIView
/** 模型 */
@property (nonatomic, strong) LGZTopics *topic;

+ (instancetype)topicVideoView;

- (void)reset;
@end
