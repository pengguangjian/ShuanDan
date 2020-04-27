//
//  MDB_Imagemanager.h
//  mdb
//
//  Created by 杜非 on 14/12/22.
//  Copyright (c) 2014年 meidebi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface MDB_Imagemanager : NSObject

@end



@interface MDB_Imagemanager (Initialization)


+ (MDB_Imagemanager *)shardInstance;

@end

/*
 
 + (AFHTTPRequestOperation *)sendRequestUrlToService:(NSString *)url
 withParametersDictionry:(NSDictionary *)parameters
 completeHandle:
 (void(^)(AFHTTPRequestOperation * opration, id responceObjct, NSError * error))complete;
 
*/
@interface MDB_Imagemanager (SDWebImage)

//存在同时同一图片多次请求的调用以下接口
-(void)MDBS_ImageWithURL:(NSURL *)imageUrl placeholder:(UIImage *)placeholder UIimageview:(UIImageView *)imageV;

-(void)MDBS_ImageWithURL:(NSURL *)imageUrl placeholder:(UIImage *)placeholder UIimageview:(UIImageView *)imageV
                progress:(void(^)(NSUInteger receiveSize,long long expectedSize))grogess
               completed:(void(^)(UIImage *image,NSError *error,SDImageCacheType caheType))complete;



-(void)MDBS_ImageWithURL:(NSURL *)imageUrl options:(SDWebImageOptions)option;

-(void)MDBS_ImageWithURL:(NSURL *)imageUrl options:(SDWebImageOptions)option
                progress:(void(^)(NSUInteger receiveSize,NSInteger expectedSize))grogess
               completed:(void(^)(UIImage *image,NSError *error,SDImageCacheType caheType, BOOL finished, NSURL *imageURL))complete;

@end




