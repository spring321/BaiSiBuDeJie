//
//  LGZGuidePushView.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/6.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZGuidePushView.h"

@implementation LGZGuidePushView


+ (instancetype)guidePage
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

+ (void)show
{
    NSString *guideKey = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[guideKey];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] valueForKey:guideKey];
//    NSLog(@"%@,-------- %@",currentVersion, sanboxVersion);
    if (![currentVersion isEqualToString:sanboxVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LGZGuidePushView *guidepage = [LGZGuidePushView guidePage];
        guidepage.frame = window.bounds;
        [window addSubview:guidepage];
        
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:guideKey];
    }
}
- (IBAction)done:(id)sender {
    [self removeFromSuperview];
}

@end
