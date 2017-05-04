//
//  UIImageView+HZF.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "UIImageView+HZF.h"
#import <objc/runtime.h>
#import "DownloadOperationManager.h"

@implementation UIImageView (HZF)


- (void)setLastUrlStr:(NSString *)lastUrlStr{
    
    objc_setAssociatedObject(self, "hzf",lastUrlStr , OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (NSString *)lastUrlStr {
    
    
    return objc_getAssociatedObject(self, "hzf");
}

- (void)HZF_setImageWithURLString:(NSString *)URLString {
    
    if (![URLString isEqualToString:self.lastUrlStr] && self.lastUrlStr != nil) {
        
        //单例接管取消操作
        [[DownloadOperationManager sharedManager] cancelOperationWithLastUrlStr:self.lastUrlStr];
        
    }
    
    //保存图片地址
    self.lastUrlStr = URLString;
    
    //单例接管图片下载
    [[DownloadOperationManager sharedManager] downloadWithUrlStr:URLString finished:^(UIImage *image) {
        
        self.image = image;
        
    }];

    
    
}

@end
