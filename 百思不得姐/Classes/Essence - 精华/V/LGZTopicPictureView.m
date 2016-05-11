//
//  LGZTopicPictureView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/11.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopicPictureView.h"
#import "LGZTopics.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "LGZShowPictureController.h"
@interface LGZTopicPictureView()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIImageView *gifView;
@property (strong, nonatomic) IBOutlet UIButton *seeBigViewButton;
@property (strong, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end


@implementation LGZTopicPictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.backgroundImage.userInteractionEnabled = YES;
    [self.backgroundImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)]];
}

- (void)showBigPicture
{
    LGZShowPictureController *showPicture = [[LGZShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:^{
        
    }];
}

+ (instancetype)topicPictureView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}
- (void)setTopic:(LGZTopics *)topic
{
    _topic = topic;
    [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:topic.middleImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    NSString *extension = topic.largeImage.pathExtension;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    
    if (topic.isBigView){
        self.seeBigViewButton.hidden = NO;
        self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
//        self.backgroundImage.contentMode = UIViewContentModeTop;
    }else{
        self.seeBigViewButton.hidden = YES;
    }
}
@end
