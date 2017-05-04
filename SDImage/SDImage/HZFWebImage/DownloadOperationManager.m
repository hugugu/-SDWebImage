//
//  DownloadOperationManager.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "DownloadOperationManager.h"
#import "DownloadOperation.h"

@interface DownloadOperationManager ()
/**
 操作缓存池
 */
@property (nonatomic,strong)NSMutableDictionary *opCache;

/**
 全局并发队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;

@end

@implementation DownloadOperationManager

+ (instancetype)sharedManager {
    
    static id instance;
    //单例设计模式
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
        
    });
    
    return instance;
}

#pragma mark
#pragma mark - :实例化属性

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.queue = [[NSOperationQueue alloc]init];
        
        self.opCache = [[NSMutableDictionary alloc]init];
        
    }
    
    return self;
}

- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock{
    
    // 使用随机地址下载图片
    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finished:^(UIImage *image) {

        
        if (finishedBlock) {
            //回调VC 的block
            finishedBlock(image);
            
        }
        // 操作对应的图片下载结束后,也是需要移除
        [self.opCache removeObjectForKey:urlStr];

        
    }];
    
    //添加到操作缓存池
    [self.opCache setObject:op forKey:urlStr];
    //添加到队列
    [self.queue addOperation:op];

    
    
}

@end
