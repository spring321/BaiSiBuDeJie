//
//  LGZCommentCell.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/14.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGZHotComment;
@interface LGZCommentCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) LGZHotComment *comment;
@end
