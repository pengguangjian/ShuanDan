//
//  MDB_ShareExstensionUserDefault.m
//  Meidebi
//
//  Created by mdb-admin on 16/8/3.
//  Copyright © 2016年 meidebi. All rights reserved.
//

#import "MDB_ShareExstensionUserDefault.h"
#import "BDKNotifyHUD.h"

@interface MDB_ShareExstensionUserDefault ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation MDB_ShareExstensionUserDefault

+ (instancetype)defaultInstance {
    static dispatch_once_t onceToken;
    static MDB_ShareExstensionUserDefault * userDefault = nil;
    dispatch_once(&onceToken, ^{
        userDefault = [[MDB_ShareExstensionUserDefault alloc] init];
    });
    return userDefault;
}

- (void)saveUserToken:(NSString *)token{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.meidebi"];
    [shared setObject:token forKey:@"userToken"];
    [shared synchronize];
}
- (NSString *)readUserTokenFromNSUserDefaults{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.meidebi"];
    NSString *value = [shared valueForKey:@"userToken"];
    return value;
}

+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view{
    if (notify_str) {
        BDKNotifyHUD *noti=[BDKNotifyHUD notifyHUDWithImage:nil text:notify_str];
        noti.center = CGPointMake(view.center.x, view.center.y );
        [view addSubview:noti];
        [noti presentWithDuration:1.0 speed:0.5 inView:view completion:^{
            [noti removeFromSuperview];
        }];
    }
}

-(void)setViewWithImage:(UIImageView *)imageV url:(NSString *)urlStr options:(SDWebImageOptions)options{
   [imageV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"punot.png"] options:options];
}

- (NSString *)applicationVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString * applicationVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return applicationVersion;
}

+(NSString *)currentTime{
    return  [[[MDB_ShareExstensionUserDefault alloc] init].dateFormatter stringFromDate:[NSDate date]];
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    }
    return _dateFormatter;
}
@end
