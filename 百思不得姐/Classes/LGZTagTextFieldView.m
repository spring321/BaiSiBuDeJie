//
//  LGZTagTextFieldView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/18.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZTagTextFieldView.h"

@implementation LGZTagTextFieldView


- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}

@end
