//
//  DownloadOperationManager.h
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperationManager : NSOperation

+ (instancetype)sharedManager;

/**
 单例下载图片主方法
 
 @param urlStr 图片地址
 @param finishedBlock 下载完成回调
 */
- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void(^)(UIImage *image))finishedBlock;

/**
 取消操作的主方法
 
 @param lastUrlStr 上次下载的图片地址
 */
- (void)cancelOperationWithLastUrlStr:(NSString *)lastUrlStr;


@end
