//
//  LGZTagCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTagCell.h"
#import <UIImageView+WebCache.h>
#import "LGZTagsModel.h"
@interface LGZTagCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageListImageView;

@property (strong, nonatomic) IBOutlet UILabel *themeNmaeLabel;
@property (strong, nonatomic) IBOutlet UILabel *subNumberLabel;

@end


@implementation LGZTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTagModel:(LGZTagsModel *)tagModel
{
    _tagModel = tagModel;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list]];
    self.themeNmaeLabel.text = tagModel.theme_name;
    self.subNumberLabel.text = [NSString stringWithFormat:@"%zd",tagModel.sub_number];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= self.x * 2;
    frame.size.height -= 1;
    
    [super setFrame:frame];

    NSLog(@"%f", frame.origin.x);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
