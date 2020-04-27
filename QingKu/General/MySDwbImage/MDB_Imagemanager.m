//
//  MDB_Imagemanager.m
//  mdb
//
//  Created by 杜非 on 14/12/22.
//  Copyright (c) 2014年 meidebi. All rights reserved.
//

#import "MDB_Imagemanager.h"

@interface MDB_Imagemanager ()


   
@end
static BOOL kIsRightInit = NO;
@implementation MDB_Imagemanager


+ (MDB_Imagemanager *)shardInstance {
    static dispatch_once_t onceToken;
    static MDB_Imagemanager * singleTon = nil;
    kIsRightInit = YES;
    dispatch_once(&onceToken, ^{
        singleTon = [[self alloc] init];
    });
    kIsRightInit = NO;
    return singleTon;
}

- (instancetype)init {
    NSAssert(kIsRightInit, @"请不要直接使用\"-init\"初始化");
    self = [super init];
    if (self) {
        [self initSomething];
    }
    return self;
}
-(void)initSomething{
    

}

//存在同时同一图片多次请求的调用以下接口


-(void)MDBS_ImageWithURL:(NSURL *)imageUrl placeholder:(UIImage *)placeholder UIimageview:(UIImageView *)imageV{
    //[imageV setImageWithURL:imageUrl placeholderImage:placeholder];
    [imageV sd_setImageWithURL:imageUrl placeholderImage:placeholder];

    
}

-(void)MDBS_ImageWithURL:(NSURL *)imageUrl placeholder:(UIImage *)placeholder UIimageview:(UIImageView *)imageV
                progress:(void(^)(NSUInteger receiveSize,long long expectedSize))grogess
               completed:(void(^)(UIImage *image,NSError *error,SDImageCacheType caheType))complete{
    
    [imageV sd_setImageWithURL:imageUrl placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

-(void)MDBS_ImageWithURL:(NSURL *)imageUrl options:(SDWebImageOptions)option{

    [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl options:option progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
    }];
}

-(void)MDBS_ImageWithURL:(NSURL *)imageUrl options:(SDWebImageOptions)option
                progress:(void(^)(NSUInteger receiveSize,NSInteger expectedSize))grogess
               completed:(void(^)(UIImage *image,NSError *error,SDImageCacheType caheType, BOOL finished, NSURL *imageURL))complete{
    
    [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl options:option progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (grogess) {
            grogess(receivedSize,expectedSize);
        }
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (complete) {
            complete(image,error,cacheType,finished,imageUrl);
        }
    }];

}




@end
