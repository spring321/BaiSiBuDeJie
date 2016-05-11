//
//  LGZShowPictureController.m
//  百思不得姐
//
//  Created by LGZwr on 16/5/11.
//  Copyright © 2016年 LGZ. All rights reserved.
//

#import "LGZShowPictureController.h"
#import "LGZTopics.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface LGZShowPictureController ()
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
/** image */
@property (nonatomic, strong) UIImageView *bigImageView;

@end

@implementation LGZShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bigImageView = [[UIImageView alloc] init];
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage]];
    
    CGFloat bigImageWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat bigImageHeight = bigImageWidth * self.topic.height / self.topic.width;
    
    self.bigImageView = bigImageView;
    bigImageView.userInteractionEnabled = YES;

    
    if (bigImageHeight > [UIScreen mainScreen].bounds.size.height){
        bigImageView.frame = CGRectMake(0, 0, bigImageWidth, bigImageHeight);
        _bigScrollView.contentSize = CGSizeMake(0, bigImageHeight);
    }else{
//
        bigImageView.y = [UIScreen mainScreen].bounds.size.height * 0.5 - bigImageHeight * 0.5;
        bigImageView.size = CGSizeMake(bigImageWidth, bigImageHeight);
    }
    
        [bigImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    [self.bigScrollView addSubview:bigImageView];
}



- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)save {
    UIImageWriteToSavedPhotosAlbum(self.bigImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


@end
