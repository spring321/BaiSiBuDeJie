//
//  LGZUserCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZUserCell.h"
#import "LGZUserModel.h"
#import <UIImageView+WebCache.h>

@interface LGZUserCell()
@property (strong, nonatomic) IBOutlet UIImageView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *fansLabel;

@end


@implementation LGZUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setUserModel:(LGZUserModel *)userModel
{
    _userModel = userModel;
    self.userName.text = userModel.screen_name;
    self.fansLabel.text = [NSString stringWithFormat:@"%zd 人关注",userModel.fans_count ];
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headerView.image = [image circleImage];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
