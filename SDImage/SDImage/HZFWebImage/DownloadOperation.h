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

@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,copy) void(^finishedBlock)(UIImage *image);

@end
