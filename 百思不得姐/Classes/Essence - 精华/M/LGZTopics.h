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
/** 是否为sina_v */
@property (nonatomic, assign, getter=isSina_v) BOOL *sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的url */
@property (nonatomic, copy) NSString *smallImage;
/** 大图片的url */
@property (nonatomic, copy) NSString *largeImage;
/** 中图片的url */
@property (nonatomic, copy) NSString *middleImage;
/** 返回类型 */
@property (nonatomic, assign) NSInteger type;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playfcount;

/** 声音时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;


/***********额外的属性*************/
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat imageHeight;

/** 是否为处理过的图片 */
@property (nonatomic, assign, getter=isBigView) BOOL bigView;

/** 声音时长计算后 */
@property (nonatomic, assign) NSString *voiceTimeStr;

@end
