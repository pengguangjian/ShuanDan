//
//  NSString+extend.h
//  Integration_Project
//
//  Created by HYKj on 15/5/19.
//  Copyright (c) 2015年 losaic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extend)

/**
 *  判断是否为空对象
 *
 *  @param data 待判断对象
 *
 *  @return 处理结果
 */
+ (NSString *)nullToString:(id)data;


/**
 判断是否为空对象,并设置预设值

 @param data 待判断对象
 @param presetStr 预设值
 @return 处理结果
 */
+ (NSString *)nullToString:(id)data preset:(NSString *)presetStr;

/**
 *  判断字符串为空格解决办法
 *
 *  @param string 待处理字符串
 *
 *  @return 处理结果
 */
- (BOOL)isBlankString:(NSString *)string;

/**
 *  判断电话号码
 *
 *  @param phoneNumber 待处理电话
 *
 *  @return 处理结果
 */
- (BOOL)CheckInput:(NSString *)phoneNumber;

/**
 *
 *  当前客服端版本号
 *
 */
- (NSString *)getVersion;

/**
 *
 *  获取手机系统（名称+版本号）
 *
 */
+ (NSString *)getSystemName;

/**
 *
 *  Dic -> String
 *
 */
+ (NSString *) DicToJsonStr:(NSDictionary *)dic;

/**
 *  Json -> dict
 *
 *  @return dict
 */
-(id)JSONValue;

/**
 *  检查表情
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  时间处理
 *
 *  @param date 时间
 *
 *  @return 时间字符串
 */
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

- (NSString*)md532BitLower;
- (NSString*)md532BitUpper;
@end
