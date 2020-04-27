//
//  NSString+extend.m
//  Integration_Project
//
//  Created by HYKj on 15/5/19.
//  Copyright (c) 2015年 losaic. All rights reserved.
//

#import "NSString+extend.h"
#import <YYKit/YYKit.h>
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (extend)

#pragma mark - 判断是否为空对象
+ (NSString *)nullToString:(id)data
{
    return [self nullToString:data preset:@""];
}

#pragma mark - 判断是否为空对象,并设置预设值
+ (NSString *)nullToString:(id)data preset:(NSString *)presetStr{
    NSString *str;
    if (data == [NSNull null] || data == nil || data == Nil || [data isKindOfClass:[NSNull class]] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",data] isEqualToString:@"<NULL>"]) {
        str = presetStr;
    }else{
        str = [NSString stringWithFormat:@"%@",data];
    }
    return str;
}

#pragma mark - 判断字符串为空格解决办法
- (BOOL)isBlankString:(NSString *)string{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
    
}
#pragma mark - 判断电话号码
- (BOOL)CheckInput:(NSString *)phoneNumber

{
    NSString *phoneRegex = @"1[34578]([0-9]){9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark - 当前客服端版本号
- (NSString *)getVersion{
    //获取本地的版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}

#pragma mark - 获取手机系统（名称+版本号）
+ (NSString *)getSystemName{
    
    NSString * name = [[UIDevice currentDevice] systemName];
    NSString * number = [[UIDevice currentDevice] systemVersion];
    name = [name stringByAppendingString:@"|"];
    NSString * system = [name stringByAppendingString:number];
    return system;
}

#pragma mark - Dic -> String
+ (NSString *) DicToJsonStr:(NSDictionary *)dic
{
    NSError *error = nil;
    if(dic==nil)dic=[NSDictionary new];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if ([str length] > 0 && error == nil){
        return str;
    }else{
        return nil;
    }
}


-(id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if(data==nil)data=[NSData new];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}

#pragma mark - 检查表情
- (BOOL)isContainsEmoji:(NSString *)string {
    
    
    
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        
        
        const unichar hs = [substring characterAtIndex:0];
        
        // surrogate pair
        
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                
                const unichar ls = [substring characterAtIndex:1];
                
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    
                    isEomji = YES;
                    
                }
                
            }
            
        } else if (substring.length > 1) {
            
            const unichar ls = [substring characterAtIndex:1];
            
            if (ls == 0x20e3) {
                
                isEomji = YES;
                
            }
            
            
            
        } else {
            
            // non surrogate
            
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                
                isEomji = YES;
                
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                
                isEomji = YES;
                
            } else if (0x2934 <= hs && hs <= 0x2935) {
                
                isEomji = YES;
                
            } else if (0x3297 <= hs && hs <= 0x3299) {
                
                isEomji = YES;
                
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                
                isEomji = YES;
                
            }
            
        }
        
    }];
    return isEomji;
    
}


- (NSString*)md532BitLower
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
- (NSString*)md532BitUpper
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

@end
