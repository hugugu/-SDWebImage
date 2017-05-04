//
//  ViewController.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

/**
 全局并发队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //实例化队列
    self.queue = [NSOperationQueue new];
    
    //创建自定义的操作
    DownloadOperation *op = [[DownloadOperation alloc]init];
    
    //把操作添加到队列中
    [self.queue addOperation:op];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
