//
//  ViewController.m
//  SDImage
//
//  Created by 胡古古 on 2017/5/4.
//  Copyright © 2017年 hugugu. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "APPModel.h"
#import "DownloadOperationManager.h"
#import "UIImageView+HZF.h"

@interface ViewController ()



/**
 操作缓存池
 */
@property (nonatomic,strong)NSMutableDictionary *opCache;

/**
 模型数组
 */
@property (nonatomic,strong) NSArray *dataArray;

/**
 图片控件
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 全局并发队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;
/**
 记录上次的图片地址
 */
@property (nonatomic,copy) NSString *lastUrlStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //实例化队列
    self.queue = [NSOperationQueue new];
    
    //实例化操作缓存池
    self.opCache = [[NSMutableDictionary alloc]init];
    
    //加载数据
    [self loadData];

}

#pragma mark
#pragma mark - :点击屏幕让图片模型里的图片随机显示
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //获取随机数
    int random = arc4random_uniform((uint32_t)self.dataArray.count);
    
    //获取随机模型
    APPModel *model = self.dataArray[random];
    
    
    [self.imageView HZF_setImageWithURLString:model.icon];
    
    
    //在建立下载操作前,判断本次传入的URL和上次的URL是否一样,如果不一样,就需要上次正在执行的下载操作
    
//    if (![model.icon isEqualToString:self.lastUrlStr] && self.lastUrlStr != nil) {
//        
//        //单例接管取消操作
//        [[DownloadOperationManager sharedManager] cancelOperationWithLastUrlStr:self.lastUrlStr];
//    
//    }
//    
//    //保存图片地址
//    self.lastUrlStr = model.icon;
//    
//    //单例接管图片下载
//    [[DownloadOperationManager sharedManager] downloadWithUrlStr:model.icon finished:^(UIImage *image) {
//        
//        self.imageView.image = image;
//        
//    }];
    
//    // 使用随机地址下载图片
//    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:model.icon finished:^(UIImage *image) {
//        //展示图片
//        self.imageView.image = image;
//        //操作对应的图片下载完成,也要移除操作
//        [self.opCache removeObjectForKey:model.icon];
//    }];
//    
//    //添加到操作缓存池
//    [self.opCache setObject:op forKey:model.icon];
//    //添加到队列
//    [self.queue addOperation:op];
    
}

#pragma mark
#pragma mark - :加载数据用于测试
- (void)loadData {
    
    NSString *urlStr = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM05/master/apps.json";
    
    //AFN默认在子线程发送网络请求,在主线程中回调代码块
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典转模型
        self.dataArray = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        
        NSLog(@"%@",self.dataArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息 %@",error);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
