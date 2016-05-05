//
//  LGZUserModel.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGZUserModel : NSObject
/** userName */
@property (nonatomic, copy) NSString *screen_name;
/** header */
@property (nonatomic, copy) NSString *header;
/** fans_count */
@property (nonatomic, assign) NSInteger fans_count;


@end
