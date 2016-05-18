//
//  LGZAddTagViewController.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGZAddTagViewController : UIViewController
/** 回传标签Block */
@property (nonatomic, copy) void (^returnTagBlock)(NSArray *);

/** 所有标签数组 */
@property (nonatomic, strong) NSArray *tags;
@end
