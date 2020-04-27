//
//  MDBwebVIew.h
//  Meidebi
//
//  Created by penggj on 15/1/22.
//  Copyright (c) 2015年 meidebi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

@class MDBwebVIew;
@protocol MDBwebDelegate <NSObject>

@required
-(void)webViewDidFinishLoad:(float)h webview:(MDBwebVIew *)webView;

@optional
-(void)webViewDidPreseeUrlWithLink:(NSString *)link webview:(MDBwebVIew *)webView;
@end

@interface MDBwebVIew : UIView<WKNavigationDelegate>

@property(nonatomic,weak)id <MDBwebDelegate>delegate;
@property(nonatomic,retain)WKWebView* webView;
@property(nonatomic,assign)int  typet;//type=1 活动
@property (nonatomic, retain) NSString *webDescription;
@property (nonatomic, retain) NSString *htmlStr;
@property (nonatomic, assign) BOOL isInteriorSkip;
@property (nonatomic , strong) UIProgressView *progressView;

///页面消失时调用该方法
-(void)finalyLoadWKWebView;

- (void)refreshHtml:(NSString *)description;

////白色子图
- (void)refreshYQHYGZHtml:(NSString *)description;
// 请求网页
- (void)loadWebByURL:(NSString *)paramUrl;


@end
