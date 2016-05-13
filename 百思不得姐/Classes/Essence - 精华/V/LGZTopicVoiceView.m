//
//  LGZTopicVoiceView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/13.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopicVoiceView.h"
#import "LGZTopics.h"
#import <UIImageView+WebCache.h>
#import "LGZShowPictureController.h"

@interface LGZTopicVoiceView()
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *topRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomRightLabel;

@end


@implementation LGZTopicVoiceView


+ (instancetype)topicVoiceView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

- (void)awakeFromNib
{
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
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
    
    NSInteger minute = self.topic.voicetime / 60;
    NSInteger second = self.topic.voicetime % 60;
    
    
    // 2代表2位 ,0代表没有的用0填补.
    self.topRightLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.bottomRightLabel.text = [NSString stringWithFormat:@"%zd播放",self.topic.playfcount];
    
    
}

@end
