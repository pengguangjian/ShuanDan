//
//  UIImage+ExtensionScal.m
//  Meidebi
//
//  Created by mdb-admin on 2017/7/25.
//  Copyright © 2017年 meidebi. All rights reserved.
//

#import "UIImage+ExtensionScal.h"

@implementation UIImage (ExtensionScal)

#pragma mark -按照你想要的比例去缩放图片
- (UIImage *)scaleToWidth:(CGFloat)width{
    
    // 如果传入的宽度比当前宽度还要大,就直接返回
    
    if (width > self.size.width) {
        return  self;
    }
    // 计算缩放之后的高度
    CGFloat height = (width / self.size.width) * self.size.height;
    
    // 初始化要画的大小
    CGRect  rect = CGRectMake(0, 0, width, height);
    
    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 2. 画到上下文中 (会把当前image里面的所有内容都画到上下文)
    [self drawInRect:rect];
    
    // 3. 取到图片
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    // 5. 返回
    return image;
}

@end
