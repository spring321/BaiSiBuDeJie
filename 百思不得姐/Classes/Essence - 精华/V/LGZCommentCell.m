//
//  LGZCommentCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/14.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZCommentCell.h"
#import "LGZHotComment.h"
#import "LGZUser.h"
#import <UIImageView+WebCache.h>
@interface LGZCommentCell()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *voiceButton;

@end


@implementation LGZCommentCell


- (void)setComment:(LGZHotComment *)comment
{
    _comment = comment;
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImage.image = [image circleImage];
    }];
    if ([comment.user.sex isEqualToString:@"m"]){
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.userNameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.contentLabel.text = comment.content;
    
    
    // 判断音频按钮是否隐藏
    if (comment.voicetime){
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    
}
- (IBAction)playVoice:(id)sender {
    
}

// 运行控件成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// 不要系统自带的样式
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = 10;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x * 2;
    
    [super setFrame:frame];
}

@end
