//
//  UINavigationBar+FixMargin.m
//  Meidebi
//
//  Created by mdb-admin on 2017/11/9.
//  Copyright © 2017年 meidebi. All rights reserved.
//

#import "UINavigationBar+FixMargin.h"
#import <objc/runtime.h>
static CGFloat const kFixMargin = 0;
@implementation UINavigationBar (FixMargin)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class selfClass = [self class];

        SEL oriSEL = @selector(layoutSubviews);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);

        SEL cusSEL = @selector(lee_layoutSubviews);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);

        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }

    });
    
}

- (void)lee_layoutSubviews{
    [self lee_layoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.layoutMargins = UIEdgeInsetsZero;
        for (UIView *view in self.subviews) {
            if ([NSStringFromClass(view.class) containsString:@"ContentView"]) {
                self.layoutMargins = UIEdgeInsetsMake(0, kFixMargin, 0, kFixMargin);
            }
        }
    }
}


@end
