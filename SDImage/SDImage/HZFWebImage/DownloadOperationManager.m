//
//  DownloadOperationManager.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "DownloadOperationManager.h"
#import "DownloadOperation.h"
#import "NSString+path.h"

@interface DownloadOperationManager ()
/**
 操作缓存池
 */
@property (nonatomic,strong)NSMutableDictionary *opCache;

/**
 图片缓存池
 */
@property (nonatomic,strong) NSMutableDictionary *imageCache;

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
        
        self.imageCache = [[NSMutableDictionary alloc]init];
        
    }
    
    return self;
}

- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock{
    
    //判断是否有缓存
    if ([self checkCache:urlStr]) {
        
        if (finishedBlock) {
            
            finishedBlock([self.imageCache objectForKey:urlStr]);
        }
        
        return;
    }
    
    //建立操作时判断操作是否存在
    
    if ([self.opCache objectForKey:urlStr]) {
        
        return;
        
    }
    
    // 使用随机地址下载图片
    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finished:^(UIImage *image) {

        
        if (finishedBlock) {
            //回调VC 的block
            finishedBlock(image);
            
        }
        //实现内存缓存
        if (image) {
            
            [self.imageCache setObject:image forKey:urlStr];
            
        }
        
        // 操作对应的图片下载结束后,也是需要移除
        [self.opCache removeObjectForKey:urlStr];

        
    }];
    
    //添加到操作缓存池
    [self.opCache setObject:op forKey:urlStr];
    //添加到队列
    [self.queue addOperation:op];

}

- (void)cancelOperationWithLastUrlStr:(NSString *)lastUrlStr {
    
    // 获取上次正在执行的操作
    DownloadOperation *lastOp = [self.opCache objectForKey:lastUrlStr];
    
    if (lastOp) {
        
        // 取消上次正在执行的操作 : 一旦调用的该方法,cancelled属性就是YES,表示该操作是个非正常操作
        [lastOp cancel];
        //移除已经取消的操作
        [self.opCache removeObjectForKey:lastUrlStr];
        
    }

    
}

- (BOOL)checkCache :(NSString *)urlStr {
    
    //判断是否有内存缓存
    if ([self.imageCache objectForKey:urlStr]) {
        
        NSLog(@"内存中加载");
        
        return YES;
        
    }
    
    //判断是否有沙盒缓存
    UIImage *image = [UIImage imageWithContentsOfFile:[urlStr appendCachePath]];
    
    if (image) {
        
        NSLog(@"沙盒中加载");
        
        [self.imageCache setObject:image forKey:urlStr];
        
        return YES;
        
    }
    
    return NO;
}

@end
