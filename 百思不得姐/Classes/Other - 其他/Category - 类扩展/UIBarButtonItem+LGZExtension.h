//
//  UIBarButtonItem+LGZExtension.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/3.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LGZExtension)

+ (instancetype)itemWithImage:(NSString *)image Highlight:(NSString *)highlight traget:(id)traget action:(SEL)action;
@end
