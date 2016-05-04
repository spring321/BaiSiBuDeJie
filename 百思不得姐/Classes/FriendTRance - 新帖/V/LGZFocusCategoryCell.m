//
//  LGZFocusCategoryCell.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFocusCategoryCell.h"
#import "LGZFocusCategory.h"
@interface LGZFocusCategoryCell()
@property (strong, nonatomic) IBOutlet UIView *markView;

@end


@implementation LGZFocusCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LGZColorWithRGB(230, 230, 230);
}

- (void)setCategory:(LGZFocusCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.markView.hidden = !selected;
    self.textLabel.textColor = selected ?  LGZColorWithRGB(219, 21, 26) : LGZColorWithRGB(78, 78, 78);
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.height = self.textLabel.height - 2;
}

@end
