//
//  HTTPManager.h
//  mdb
//
//  Created by 杜非 on 14/12/10.
//  Copyright (c) 2014年 meidebi. All rights reserved.



#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
@interface HTTPManager : NSObject{

}

@end

@interface HTTPManager (Initialization)//Initialization

+ (HTTPManager *)shardInstance;
@end


@interface HTTPManager (AFNetworking)

/**
 返回网络请求操作的对象，便于取消；同时向服务器发起请求。
 
 */
+ (NSURLSessionTask *)sendRequestUrlToService:(NSString *)url
                                     withParametersDictionry:(NSDictionary *)parameters
                                               view:(UIView *)showView
                                          completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete;

+ (NSURLSessionTask *)sendGETRequestUrlToService:(NSString *)url
                            withParametersDictionry:(NSDictionary *)parameters
                                               view:(UIView *)showView
                                     completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete;

////无默认参数
+ (NSURLSessionTask *)sendGETRequestNotNomoUrlToService:(NSString *)url
                         withParametersDictionry:(NSDictionary *)parameters
                                            view:(UIView *)showView
                                  completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete;


+ (void)sendRequestUrlToService:(NSString *)url
        withParametersDictionry:(NSDictionary *)parameters
                       fileDate:(NSData *)data
                           name:(NSString *)name
                       filename:(NSString *)filename
                       mimeType:(NSString *)mimeType
                 completeHandle:(void (^)(NSURLSessionTask *, id, NSError *))complete;

+ (void)sendRequestUrlToService:(NSString *)url
        withParametersDictionry:(NSDictionary *)parameters
                      fileDates:(NSArray *)datas
                       mimeType:(NSString *)mimeType
                     showInView:(UIView *)showView
                 completeHandle:(void (^)(NSURLSessionTask *, id, NSError *))complete;

+ (NSURLSessionTask *)sendHtmlRequestUrlToService:(NSString *)url
                                        completeHandler:(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete;




@end










