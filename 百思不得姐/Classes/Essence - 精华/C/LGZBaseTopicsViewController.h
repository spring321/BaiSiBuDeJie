//
//  LGZBaseTopicsViewController.h
//  百思不得姐
//
//  Created by LGZwr on 16/5/10.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LGZTopicTypeAll = 1,
    LGZTopicTypeVideo = 41,
    LGZTopicTypeVoice = 31,
    LGZTopicTypePicture = 10,
    LGZTopicTypeWord = 29
    
} LGZTopicType;

@interface LGZBaseTopicsViewController : UITableViewController

/** 获取数据类型 */
@property (nonatomic, assign) LGZTopicType type;
@end
