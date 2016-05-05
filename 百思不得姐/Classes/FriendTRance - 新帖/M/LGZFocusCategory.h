//
//  LGZFocusCategory.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGZFocusCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** count */
@property (nonatomic, assign) NSInteger count;
/** name */
@property (nonatomic, copy) NSString *name;
/** 右边的关注 */
@property (nonatomic, strong) NSMutableArray *users;

/** 总个数 */
@property (nonatomic, assign) NSInteger total;

/** 下一页 */
@property (nonatomic, assign) NSInteger next_page;

/** 总页数 */
@property (nonatomic, assign) NSInteger total_page;


@end
