//
//  LGZHotComment.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/13.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LGZUser;

@interface LGZHotComment : NSObject
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频地址 */
@property (nonatomic, copy) NSString *voiceurl;
/** 评论文字 */
@property (nonatomic, copy) NSString *content;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LGZUser *user;

@end
