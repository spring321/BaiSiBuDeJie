//
//  LGZTagTextFieldView.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGZTagTextFieldView : UITextField

/** 删除按钮点击回调block */
@property (nonatomic, copy) void (^deleteBlock)();

@end
