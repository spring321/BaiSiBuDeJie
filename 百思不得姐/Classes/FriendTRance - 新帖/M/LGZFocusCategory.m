//
//  LGZFocusCategory.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/4.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZFocusCategory.h"

@implementation LGZFocusCategory


-(NSMutableArray *)users
{
    if(!_users){
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
