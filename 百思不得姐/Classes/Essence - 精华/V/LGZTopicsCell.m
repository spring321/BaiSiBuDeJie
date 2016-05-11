//
//  LGZTopicsCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/9.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTopicsCell.h"
#import "LGZTopics.h"
#import <UIImageView+WebCache.h>
#import "LGZTopicPictureView.h"
@interface LGZTopicsCell()
@property (strong, nonatomic) IBOutlet UIImageView *profile_image;
@property (strong, nonatomic) IBOutlet UILabel *screen_name;
@property (strong, nonatomic) IBOutlet UILabel *created_at;
@property (strong, nonatomic) IBOutlet UIButton *ding;
@property (strong, nonatomic) IBOutlet UIButton *cai;
@property (strong, nonatomic) IBOutlet UIButton *share;
@property (strong, nonatomic) IBOutlet UIButton *comment;
@property (strong, nonatomic) IBOutlet UIImageView *sina_v_image;
@property (strong, nonatomic) IBOutlet UILabel *text_label;
//** 中间的view */
@property (nonatomic, strong) LGZTopicPictureView *pictureView;

@end


@implementation LGZTopicsCell

- (UIView *)pictureView
{
    if (!_pictureView){
        LGZTopicPictureView *pictureView = [LGZTopicPictureView topicPictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
//    [bgView setImage:[UIImage imageNamed:@"mainCellBackground"]];
////    self.backgroundView = bgView;
//    NSInteger left = bgView.image.size.width * 0.5f;
//    NSInteger top = bgView.image.size.height * 0.5f;
//    bgView.image = [bgView.image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    bgView.image = [bgView.image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    self.backgroundView = bgView;
    
}



// 设置模型数据
- (void)setTopic:(LGZTopics *)topic
{
    _topic = topic;
    
//    topic.sina_v = arc4random_uniform(100) % 2;
    
    // 设置用户头像
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]];
    
    // 设置用户名称
    self.screen_name.text = topic.name;
//    self.created_at.text = topic.created_at;
    // 设置发帖时间
    [self setTimeFrom:topic.created_at];
    
    // 设置头像是否加v
    self.sina_v_image.hidden = !topic.isSina_v;
    
    // 设置文字内容
    self.text_label.text = topic.text;
    
    // 将中间的内容加入cell中
    if (topic.type != 29)
    {
    self.pictureView.frame = CGRectMake(0, self.topic.cellHeight - self.topic.imageHeight - 44 - 10 - 10, [UIScreen mainScreen].bounds.size.width - 20, self.topic.imageHeight);
        self.pictureView.topic = topic;
    }

    
    // 设置按钮
    [self setButton:self.ding count:topic.love placeholder:@"顶"];
    [self setButton:self.cai count:topic.cai placeholder:@"踩"];
    [self setButton:self.share count:topic.repost placeholder:@"转发"];
    [self setButton:self.comment count:topic.comment placeholder:@"评论"];
    
    
}


// 发帖时间的设计
- (void)setTimeFrom:(NSString *)createdTime
{
    // 帖子创建的时间
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *created = [format dateFromString:createdTime];
    if (created.isToyear){ // 今年发的
        if(created.isToday){ //是不是今天
            NSDateComponents *comps = [[NSDate date] datefrom:created];
            if (comps.hour >= 1){ // 1小时前
                self.created_at.text = [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute >= 1){ // 大于1分钟小于1小时
                
                self.created_at.text = [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else { // 小于1分钟
                self.created_at.text = @"刚刚";
            }
                
            
        }else if (created.isYesterday) { // 昨天发的
            format.dateFormat = @"昨天 HH:mm:ss";
            self.created_at.text = [format stringFromDate:created];
        }else{ // 其他时间发的
            format.dateFormat = @"MM-dd HH:mm:ss";
            self.created_at.text = [format stringFromDate:created];
        }
    
    }else { //不是今年
        self.created_at.text = createdTime;
    }
    

    
    
}
- (void)setButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count == 0){
        [button setTitle:placeholder forState:UIControlStateNormal];
    }else if (count > 10000){
        placeholder = [NSString stringWithFormat:@"%.1f",count / 10000.0];
        [button setTitle:placeholder forState:UIControlStateNormal];
    }else {
        placeholder = [NSString stringWithFormat:@"%zd",count];
        [button setTitle:placeholder forState:UIControlStateNormal];
    
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
