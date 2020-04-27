//
//  MDB_ShareExstensionUserDefault.h
//  Meidebi
//
//  Created by mdb-admin on 16/8/3.
//  Copyright © 2016年 meidebi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MDB_ShareExstensionUserDefault : NSObject

+ (instancetype)defaultInstance;


- (void)saveUserToken:(NSString *)token;
- (NSString *)readUserTokenFromNSUserDefaults;

//提示
+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view;

-(void)setViewWithImage:(UIImageView *)imageV url:(NSString *)urlStr options:(SDWebImageOptions)options;

- (NSString *)applicationVersion;
+(NSString *)currentTime;
@end
