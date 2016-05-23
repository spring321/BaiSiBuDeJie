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
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface LGZTopicVideoView()
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

/** 播放器 */
@property (nonatomic, strong) AVPlayer *player;
/** 播放器 */
@property (nonatomic, strong) MPMoviePlayerController *playController;

/** 字典 */
@property (nonatomic, strong) NSMutableDictionary *dicts;
@end


@implementation LGZTopicVideoView


-(NSMutableDictionary *)dicts
{
    if(!_dicts){
        _dicts = [NSMutableDictionary dictionary];
    }
    return _dicts;
}

- (MPMoviePlayerController *)playController
{
    if(!_playController){
        
        NSURL *rul = [NSURL URLWithString:self.topic.videouri];
        _playController = [[MPMoviePlayerController alloc] initWithContentURL:rul];
        _playController.view.frame = self.bounds;
        [self addSubview:_playController.view];
        
//        [self.dicts setObject:_playController forKey:self.topic.videouri];
    }
    return _playController;
}

- (AVPlayer *)player
{
    if(!_player)
    {
        
        NSURL *url = [NSURL URLWithString:self.topic.videouri];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:item];
        
        // 添加layer
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , self.topic.imageHeight);
        [self.backGroundImageView.layer addSublayer:layer];
    }
    return _player;
}

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
- (IBAction)playVideo:(id)sender {
    
    
    
    [self.playController play];
}

- (void)reset
{
    [self.playController.view removeFromSuperview];
    [self.playController pause];
    self.playController = nil;
    
}


@end
