//
//  HTTPManager.m
//  mdb
//
//  Created by 杜非 on 14/12/10.
//  Copyright (c) 2014年 meidebi. All rights reserved.
//

#import "HTTPManager.h"
#import <AFNetworking/AFNetworking.h>
#import "GMDCircleLoader.h"
#import "MDB_ShareExstensionUserDefault.h"
#import "NSString+extend.h"

#import <sys/utsname.h>

@interface HTTPManager ()
@property (nonatomic, copy) NSURL * baseAPI_URL;
@property (nonatomic, copy) NSURL * download_URL;
//@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic, strong) AFHTTPSessionManager * manager;
@end


static BOOL kIsRightInit = NO;

@implementation HTTPManager


+ (HTTPManager *)shardInstance{
    static dispatch_once_t onceToken;
    static HTTPManager * singleton = nil;
    kIsRightInit = YES;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    kIsRightInit = NO;
    if (singleton) {
        [singleton initSomthing];
    }
    
    
    return singleton;
}
- (instancetype)init {
    NSAssert(kIsRightInit, @"请不要直接使用\"-init\"初始化");
    self = [super init];
    return self;
}
- (void)initSomthing{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        // 设置可以接收无效的证书
        [securityPolicy setAllowInvalidCertificates:YES];
        securityPolicy.validatesDomainName = NO;
        _manager.securityPolicy = securityPolicy;
    }
}



//+ (AFHTTPRequestOperation *)sendHtmlRequestUrlToService:(NSString *)url
//                                     completeHandler:(void(^)(AFHTTPRequestOperation * opration, id responceObjct, NSError * error))complete{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    AFHTTPRequestOperation * op = [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (complete) {
//            complete(operation,responseObject,nil);
//
//        }}
//                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                             if (complete) {
//                                                 complete(operation,nil,error);
//                                             }
//                                        }];
//    [op setResponseSerializer:[AFCompoundResponseSerializer serializer]];
//    [op start];
//    return op;
//
//}

+ (NSURLSessionTask *)sendHtmlRequestUrlToService:(NSString *)url
                                        completeHandler:(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURLSessionTask * op = [manager GET:url parameters:nil success:^(NSURLSessionTask *operation, id responseObject) {
        if (complete) {
            complete(operation,responseObject,nil);
            
        }}
                                       failure:^(NSURLSessionTask *operation, NSError *error) {
                                           if (complete) {
                                               complete(operation,nil,error);
                                           }
                                       }];
//    [op setResponseSerializer:[AFCompoundResponseSerializer serializer]];
//    [op start];
    [op resume];
    return op;
    
}

+ (NSURLSessionTask *)sendRequestUrlToService:(NSString *)url
                            withParametersDictionry:(NSDictionary *)parameters
                                               view:(UIView *)showView
                                     completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete{
    

    return [[HTTPManager shardInstance] sendRequestUrlToService:url withParametersDictionry:parameters view:showView completeHandle:complete];
}

+ (NSURLSessionTask *)sendGETRequestUrlToService:(NSString *)url
                            withParametersDictionry:(NSDictionary *)parameters
                                               view:(UIView *)showView
                                     completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete{
    

    return [[HTTPManager shardInstance] sendGETRequestUrlToService:url withParametersDictionry:parameters view:showView completeHandle:complete];
    
}


- (NSURLSessionTask *)sendRequestUrlToService:(NSString *)url
                                     withParametersDictionry:(NSDictionary *)parameters
                                               view:(UIView *)showView
                                          completeHandle:
(void (^)(NSURLSessionTask *, id, NSError *))complete {
  
    if (showView) {
        [GMDCircleLoader setOnView:showView withTitle:nil animated:YES];
    }
    _manager.requestSerializer.timeoutInterval=40.0;
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:[NSString nullToString:[[MDB_ShareExstensionUserDefault defaultInstance] applicationVersion]] forKey:@"version"];
    
    
    [dic setObject:[[HTTPManager shardInstance] iphoneType] forKey:@"devicename"];
    
    NSDictionary *dicsss=[NSDictionary dictionaryWithDictionary:dic];
    NSURLSessionTask * op = [_manager POST:url parameters:dicsss success:^(NSURLSessionTask *operation, id responseObject) {
        [GMDCircleLoader hideFromView:showView animated:YES];
        if (complete && responseObject) {
            responseObject = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSDictionary *dicAll;
            NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            dicAll=[str JSONValue];
            if ([[dicAll objectForKey:@"status"]intValue] == -1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkWairningOnload" object:nil];
            }else{
                complete(operation,responseObject,nil);
            }
        }
        
    }
    failure:^(NSURLSessionTask *operation, NSError *error) {
        [GMDCircleLoader hideFromView:showView animated:YES];
        if (complete) {
            complete(operation,nil,error);
        }
    }];
    
    
//    [op setResponseSerializer:[AFCompoundResponseSerializer serializer]];
//    [op start];
    [op resume];
    return op;
}

- (NSURLSessionTask *)sendGETRequestUrlToService:(NSString *)url
                               withParametersDictionry:(NSDictionary *)parameters
                                                  view:(UIView *)showView
                                        completeHandle:
(void (^)(NSURLSessionTask *, id, NSError *))complete {
    
    if (showView) {
        [GMDCircleLoader setOnView:showView withTitle:nil animated:YES];
    }
    _manager.requestSerializer.timeoutInterval=40.0;
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:[NSString nullToString:[[MDB_ShareExstensionUserDefault defaultInstance] applicationVersion]] forKey:@"version"];
    [dic setObject:[[HTTPManager shardInstance] iphoneType] forKey:@"devicename"];
    
    NSDictionary *dicsss=[NSDictionary dictionaryWithDictionary:dic];
    NSURLSessionTask * op = [_manager GET:url parameters:dicsss
                                        success:^(NSURLSessionTask *operation, id responseObject) {
        [GMDCircleLoader hideFromView:showView animated:YES];
        if (complete && responseObject) {
            NSDictionary *dicAll;
            responseObject = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            dicAll=[str JSONValue];
            
            if ([[dicAll objectForKey:@"status"]intValue] == -1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkWairningOnload" object:nil];
            }else{
                complete(operation,responseObject,nil);
            }
        }}
         failure:^(NSURLSessionTask *operation, NSError *error) {
             [GMDCircleLoader hideFromView:showView animated:YES];
             if (complete) {
                 complete(operation,nil,error);
             }
         }];
    [op resume];
//    [op setResponseSerializer:[AFCompoundResponseSerializer serializer]];
//    [op start];
    return op;
}
////无默认参数
+ (NSURLSessionTask *)sendGETRequestNotNomoUrlToService:(NSString *)url
                                withParametersDictionry:(NSDictionary *)parameters
                                                   view:(UIView *)showView
                                         completeHandle:
(void(^)(NSURLSessionTask * opration, id responceObjct, NSError * error))complete
{
    
    return [[HTTPManager shardInstance] sendGETRequestNotNomoUrlToService:url withParametersDictionry:parameters view:showView completeHandle:complete];
}
- (NSURLSessionTask *)sendGETRequestNotNomoUrlToService:(NSString *)url
                         withParametersDictionry:(NSDictionary *)parameters
                                            view:(UIView *)showView
                                  completeHandle:
(void (^)(NSURLSessionTask *, id, NSError *))complete
{
    if (showView) {
        [GMDCircleLoader setOnView:showView withTitle:nil animated:YES];
    }
    _manager.requestSerializer.timeoutInterval=40.0;
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDictionary *dicsss=[NSDictionary dictionaryWithDictionary:dic];
    NSURLSessionTask * op = [_manager GET:url parameters:dicsss
                                  success:^(NSURLSessionTask *operation, id responseObject) {
                                      [GMDCircleLoader hideFromView:showView animated:YES];
                                      if (complete && responseObject) {
                                          NSDictionary *dicAll;
                                          responseObject = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                                          NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                          dicAll=[str JSONValue];
                                          
                                          if ([[dicAll objectForKey:@"status"]intValue] == -1) {
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkWairningOnload" object:nil];
                                          }else{
                                              complete(operation,responseObject,nil);
                                          }
                                      }}
                                  failure:^(NSURLSessionTask *operation, NSError *error) {
                                      [GMDCircleLoader hideFromView:showView animated:YES];
                                      if (complete) {
                                          complete(operation,nil,error);
                                      }
                                  }];
    [op resume];
    //    [op setResponseSerializer:[AFCompoundResponseSerializer serializer]];
    //    [op start];
    return op;
}

+ (void)sendRequestUrlToService:(NSString *)url
                            withParametersDictionry:(NSDictionary *)parameters
                                           fileDate:(NSData *)data
                                               name:(NSString *)name
                                           filename:(NSString *)filename
                                           mimeType:(NSString *)mimeType
                                     completeHandle:(void (^)(NSURLSessionTask *, id, NSError *))complete{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:[[HTTPManager shardInstance] iphoneType] forKey:@"devicename"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:filename mimeType:mimeType];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            complete(nil,nil,error);
        } else {
            complete(nil,responseObject,nil);
        }
    }];
    
    [uploadTask resume];
}

+ (void)sendRequestUrlToService:(NSString *)url
        withParametersDictionry:(NSDictionary *)parameters
                      fileDates:(NSArray *)datas
                       mimeType:(NSString *)mimeType
                     showInView:(UIView *)showView
                 completeHandle:(void (^)(NSURLSessionTask *, id, NSError *))complete{
    if (showView) {
        [GMDCircleLoader setOnView:showView withTitle:nil animated:YES];
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:[NSString nullToString:[[MDB_ShareExstensionUserDefault defaultInstance] applicationVersion]] forKey:@"version"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSInteger i= 0; i<datas.count; i++) {
            NSString *name = [[MDB_ShareExstensionUserDefault currentTime] stringByAppendingString:[NSString stringWithFormat:@"%@.png",@(i)]];
            [formData appendPartWithFileData:datas[i] name:name fileName:name mimeType:mimeType];
        }
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (showView) {
            [GMDCircleLoader hideFromView:showView animated:YES];
        }
        if (error) {
            complete(nil,nil,error);
        } else {
            complete(nil,responseObject,nil);
        }
    }];
    [uploadTask resume];
}
#pragma mark - AFNetworking
- (NSURLSessionTask *)actionRequestUrlToService:(NSString *)url actionwithParametersDictionry:(NSDictionary *)parameters
{
    
    _manager.responseSerializer=[AFJSONResponseSerializer serializer];//返回json类型
    _manager.requestSerializer.timeoutInterval=40.0;
    NSURLSessionTask * op = [_manager POST:url parameters:parameters success:nil failure:nil];
    
    return op;
}


- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}


@end
