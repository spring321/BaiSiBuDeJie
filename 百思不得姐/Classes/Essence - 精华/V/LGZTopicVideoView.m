//
//  LGZTopicVideoView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/13.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "LGZTopics.h"
#import "LGZShowPictureController.h"
@interface LGZTopicVideoView()
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end


@implementation LGZTopicVideoView


+ (instancetype)topicVideoView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

- (void)awakeFromNib
{
    // 设置图片不会跟随xib加载的控件自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    self.backGroundImageView.userInteractionEnabled = YES;
    [self.backGroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)]];
}

- (void)showBigPicture
{
    LGZShowPictureController *showPicture = [[LGZShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:^{
        
    }];
}
- (void)setTopic:(LGZTopics *)topic
{
    _topic = topic;
    
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage]];
    NSInteger minute = self.topic.videotime / 60;
    NSInteger second = self.topic.videotime % 60;
    
    
    // 2代表2位 ,0代表没有的用0填补.
    self.leftLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.rightLabel.text = [NSString stringWithFormat:@"%zd播放",self.topic.playfcount];

}


@end
