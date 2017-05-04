//
//  DownloadOperation.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation
#pragma mark
#pragma mark - :重写main 操作的入口方法,该方法默认在子线程执行
- (void)main{
    
    //下载图片
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSData *data  =[NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //在主线程中回调
    if (self.finishedBlock) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //回到主线程回调block
            self.finishedBlock(image);
            
        }];
        
        
    }
    
    
}


@end
