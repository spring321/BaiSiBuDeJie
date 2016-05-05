//
//  LGZTagsModel.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/5.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGZTagsModel : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
