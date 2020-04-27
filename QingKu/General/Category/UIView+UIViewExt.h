//
//  UIView+UIViewExt.h
//  Meidebi
//
//  Created by mdb-admin on 16/6/3.
//  Copyright © 2016年 meidebi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExt)
/**
 *  frame.origin.x
 */
@property (nonatomic) CGFloat left;

/**
 *  frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 * Return frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Return frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Return frame.size.width
 */
@property (nonatomic) CGFloat width;

/**
 * Return frame.size.height
 */
@property (nonatomic) CGFloat height;

/**
 * Return center.x
 */
@property (nonatomic) CGFloat centerX;

/**
 * Return center.y
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

- (void)removeAllSubviews;
@end
