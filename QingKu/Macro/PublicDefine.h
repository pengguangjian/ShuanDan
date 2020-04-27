//
//  PublicDefine.h
//  Meidebi
//
//  Created by mdb-i on 13-9-29.
//  Copyright (c) 2013年 meidebi. All rights reserved.
//


static NSString * const kRemarkUploadImagesNotification = @"kRemarkUploadImagesNotification";
static NSString * const kRemarkUpdataNotification = @"kRemarkUpdataNotification";
static NSString * const kRemarkErrorTips = @"kRemarkErrorTips";
static NSString * const kGoTopNotificationName = @"goTop";//进入置顶命令
static NSString * const kLeaveTopNotificationName = @"leaveTop";//离开置顶命令
static NSString * const kGoBottomNotificationName = @"goBottom";//进入底部命令
static NSString * const kBrokeUpdataImageNotification = @"kBrokeUpdataImageNotification";
static NSString * const kShaidanDidSuccessSendNotification = @"kShaidanDidSuccessSendShare";
static NSString * const kShaidanUpshareImageManagerNotification = @"kShaidanUpshareImageManager";
static NSString * const kNetworkWairningOnloadNotification = @"kNetworkWairningOnload";


#define kScreenW 250.0


#define IOS_VERSION_6_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)? (YES):(NO))

#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))

#define IOS_VERSION_7_1_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1)? (YES):(NO))

#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

#define IOS_VERSION_8_OR_BEFORE (([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)? (YES):(NO))

#define IOS_VERSION_9_OR_BEFORE (([[[UIDevice currentDevice] systemVersion] floatValue] == 9.0)? (YES):(NO))

#define IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))

#define IOS_VERSION_10_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))

#define IOS_VERSION_11_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? (YES):(NO))

#define IS_IPHONE_4_SCREEN [[UIScreen mainScreen] bounds].size.height <= 480.0f

#define IS_IPHONE_WIDE_SCREEN [[UIScreen mainScreen] bounds].size.width > 320.0f

#define IS_IPHONE_X_SCREEN [[UIScreen mainScreen] bounds].size.height >= 812.0f

#define push_key_isBindPush         @"isBindPush"
#define push_key_isBindLoaction     @"isBindLoaction"
#define push_key_devicetype         @"1"

#define kMainScreenW [UIScreen mainScreen].bounds.size.width
#define kMainScreenH [UIScreen mainScreen].bounds.size.height

#define kScale [UIScreen mainScreen].bounds.size.width / 375.0

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 判断是否是iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)\
|| CGSizeEqualToSize(CGSizeMake(1136, 640), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断是否是iPhone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)\
|| CGSizeEqualToSize(CGSizeMake(960, 640), [[UIScreen mainScreen] currentMode].size) : NO)


// 4.7in
#define iPhone6_or_iphone7 (([UIScreen instancesRespondToSelector:@selector(currentMode)]\
? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)\
|| CGSizeEqualToSize(CGSizeMake(1334, 750), [[UIScreen mainScreen] currentMode].size) : NO))

// 5.5in
#define iPhone6Plus_or_iphone7Plus (([UIScreen instancesRespondToSelector:@selector(currentMode)]\
? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)\
|| CGSizeEqualToSize(CGSizeMake(2208, 1242), [[UIScreen mainScreen] currentMode].size) : NO))

// iPhone 设备的bounds
#define MAIN_SCREEN_FRAME [[UIScreen mainScreen] bounds]
// iPhone 设备的bounds高度
#define BOUNDS_HEIGHT MAIN_SCREEN_FRAME.size.height
// iPhone 设备的bounds宽度
#define BOUNDS_WIDTH MAIN_SCREEN_FRAME.size.width
// iPhone 设备的高度
#define MAIN_SCREEN_HEIGHT MAIN_SCREEN_FRAME.size.height-20

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define OrangeValue @"#fc3305"
#define LightGrayValue @"#cccccc"
#define GrayValue @"#8c8c8c"
#define DarkGrayValue @"#8c8c8c"
#define FSGraycolor [UIColor colorWithRed:238/255.0f green:239/255.0f blue:244/255.0f alpha:1.0]

#define DateFormatter @"yyyy-MM-dd HH:mm:ss"

/**** 通用字体颜色 *****/

#define RadMenuColor [UIColor colorWithRed:253.0/255.0 green:122.0/255.0 blue:15.0/255.0 alpha:1.0]//memu橘色
#define RadDaoHangColor [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]//导航背景
#define RadDaoBiaoColor [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]//导航标签
#define RadLineColor [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]//分割线

#define RadCellBiaoColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]//苏宁易购
#define RadBarBiaoColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]//晒单 标签栏字体颜色

#define RadshuziColor [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]//晒单 标签栏字体颜色

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define TEXT_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]


#define LOGFRAME(f) NSLog(@"\nx:%f\ny:%f\nwidth:%f\nheight:%f\n",f.origin.x,f.origin.y,f.size.width,f.size.height)

/**** 通用资源字体 *****/
#define MAPDRAW_FONT_POPVIEW [UIFont fontWithName:@"HelveticaNeue-Light" size:15]


#ifdef DEBUG

#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DebugLog(s, ... )
//#define NSLog(...)

#endif
