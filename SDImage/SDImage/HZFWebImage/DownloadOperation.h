//
//  DownloadOperation.h
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation



+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finished:(void(^)(UIImage *image))finishedBlock;

@end
