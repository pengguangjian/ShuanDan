//
//  UITabBar+badge.h
//  PreschoolCloud
//
//  Created by HYKj on 15/11/3.
//  Copyright © 2015年 losaic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
