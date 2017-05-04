//
//  UIImageView+HZF.h
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HZF)

@property (nonatomic,copy) NSString *lastUrlStr;

- (void)HZF_setImageWithURLString:(NSString *)URLString;

@end
