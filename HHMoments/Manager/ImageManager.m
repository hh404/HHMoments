//
//  ImageManager.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "ImageManager.h"

@interface ImageManager ()
@property (nonatomic, strong) NSCache *imageCache;              //图片内存缓存
@property (nonatomic, strong) NSMutableDictionary *operations;  //操作缓存
@property (nonatomic, strong) NSOperationQueue *queue;          //下载队列

@end

// Constants
// NSString * const ImageManagerDidSomethingNotification = @"ImageManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";
static ImageManager *gImageManager = nil;

@implementation ImageManager

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Default

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

+ (instancetype)shareManager;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gImageManager = [[ImageManager alloc] init];
    });
    return gImageManager;
}

- (void)imageWithURL:(NSString*)url success:(success)successBlock failure:(failure)failureBlock
{
    //查询内存缓存
    UIImage *image = [self.imageCache objectForKey:[url MD5Digest]];
    
    //找到了缓存
    if (image) {
        
        successBlock(image);
        
    }else{
        
        //没有找到内存缓存，查询沙盒缓存
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [url MD5Digest];
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];

        if (imageData) {
            
            //找到了沙盒缓存
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageCache setObject:image forKey:fileName];
            successBlock(image);
            
        }else{

            //开始下载
            NSBlockOperation *download = [self.operations objectForKey:fileName];
            
            if (download) {
                
                //什么都不做，因为存在下载该url的线程
                
            }else{
                
                
                //下载任务
                download = [NSBlockOperation blockOperationWithBlock:^{
                    
                    //通过url下载图片
                    NSURL *imageURL = [NSURL URLWithString:url];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    //没有拿到图片
                    if (image == nil) {
                        [self.operations removeObjectForKey:fileName];
                        failureBlock(nil);
                        return;
                    }
                    
                    //拿到图片了，缓存内存缓存
                    [self.imageCache setObject:image forKey:fileName];
                    successBlock(image);
                    
                    //缓存沙盒缓存
                    [imageData writeToFile:filePath atomically:YES];
                    [self.operations removeObjectForKey:fileName];
                    
                }];
                
                //将操作添加到操作缓存中
                [self.operations setObject:download forKey:fileName];
                
                //将下载任务添加到队列里
                [self.queue addOperation:download];
            }
        }
    }
    
}

#pragma mark - 
#pragma mark Private methods

#pragma mark- Lazy Loads
    
    

    
-(NSOperationQueue*)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

-(NSCache*)imageCache
{
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache ;
}


-(NSMutableDictionary*)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

    
#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
