//
//  DownloadOperation.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "DownloadOperation.h"

@interface DownloadOperation ()
/**
 保存外界传入的数据
 */
@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,copy) void(^finishedBlock)(UIImage *image);


@end

@implementation DownloadOperation

+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock{
    //实例化保留外面传进来的数据
    DownloadOperation *op = [[DownloadOperation alloc]init];
    
    op.urlStr = urlStr;
    
    op.finishedBlock = finishedBlock;
    
    return op;
}

#pragma mark
#pragma mark - :重写main 操作的入口方法,该方法默认在子线程执行
- (void)main{
    
    NSLog(@"传入 %@",self.urlStr);
    
//    // 模拟网络延迟 : 没有实际意义
    [NSThread sleepForTimeInterval:1.0];

    //下载图片
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSData *data  =[NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    // 需要在操作执行的过程中,判断该操作是否是被取消的 : 可以在多个位置写,但是一定要在耗时操作的后面有个判断;不要在回调后面写,已经晚了
    if (self.cancelled == YES) {
        NSLog(@"取消 %@",self.urlStr);
        return;
    }

    //在主线程中回调
    if (self.finishedBlock) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //回到主线程回调block
            NSLog(@"完成 %@",self.urlStr);
            
            self.finishedBlock(image);
            
        }];
        
        
    }
    
    
}


@end
