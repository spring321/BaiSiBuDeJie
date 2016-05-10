//
//  LGZTopics.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/8.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGZTopics : NSObject
/** 用户名字 */
@property (nonatomic, copy) NSString *name;
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *created_at;
/** 发帖内容 */
@property (nonatomic, copy) NSString *text;

/** 点赞数 */
@property (nonatomic, assign) NSInteger love;
/** cai */
@property (nonatomic, assign) NSInteger cai;
/** 转发数 */
@property (nonatomic, assign) NSInteger repost;
/** 讨论 */
@property (nonatomic, assign) NSInteger comment;

@end
