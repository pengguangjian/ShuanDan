//
//  MDBwebVIew.m
//  Meidebi
//
//  Created by penggj on 15/1/22.
//  Copyright (c) 2015年 meidebi. All rights reserved.
//

#import "MDBwebVIew.h"

#import "PublicDefine.h"

@implementation MDBwebVIew{
    
    BOOL isLoadHtmlStr;
    NSInteger webViewLoads;
    UIImageView *noNetWorkImageView;
    
    int icount;
    
    BOOL isChangeFount;
    
    BOOL isfinallied;
}
@synthesize delegate=_delegate;
@synthesize webView=_webView;

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _isInteriorSkip = NO;
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled=YES;
        _webView.opaque = NO;
        
        _webView.backgroundColor= [UIColor whiteColor];
        [self addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self loadimageview];
        
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        icount = 0;
        
        [self progressView];
        [self addSubview:self.progressView];
        
    }
    return self;
}

-(void)loadimageview
{
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    imageView.image = [UIImage imageNamed:@"ic_no_network"];
    noNetWorkImageView = imageView;
    [noNetWorkImageView setHidden:YES];
}

- (void)refreshHtml:(NSString *)description{
    if(isfinallied)return;
//    _webView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
//    NSString *str_bigfont=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bigfont" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
//
//    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//
//    NSString *description_bigfont=[NSString stringWithFormat:@"<html>%@%@</html>",str_bigfont,description];
//
//    description_bigfont = [headerString stringByAppendingString:description_bigfont];
    [_webView loadHTMLString:description baseURL:nil];
    
}

- (void)refreshYQHYGZHtml:(NSString *)description{
    if(isfinallied)return;
//    _webView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
//    NSString *str_bigfont=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bigfont03" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
//
//    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
//
//    NSString *description_bigfont=[NSString stringWithFormat:@"<html>%@%@</html>",str_bigfont,description];
//
//    description_bigfont = [headerString stringByAppendingString:description_bigfont];
    [_webView loadHTMLString:description baseURL:nil];
    
}

// 请求网页
- (void)loadWebByURL:(NSString *)paramUrl{
    if(isfinallied)return;
//    _webView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    NSURL *localUrl = [NSURL URLWithString:paramUrl];
    NSURLRequest *request =[NSURLRequest requestWithURL:localUrl];
    [_webView loadRequest:request];
    
//    [_webView loadHTMLString:@"" baseURL:localUrl];
    
//    [_webView loadHTMLString:@"" baseURL:localUrl];
//
//    NSError *error;
//
//    NSURLResponse *response = nil;
//
//    NSData *datat = [NSURLConnection sendSynchronousRequest:request
//
//                                          returningResponse:&response
//
//                                                      error:&error];
//    NSString *strtemp = [[NSString alloc] initWithData:datat encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
//    if(strtemp == nil)
//    {
//        strtemp = [[NSString alloc] initWithData:datat encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
//    }
//     [_webView loadHTMLString:strtemp baseURL:localUrl];
    
}

///页面消失时调用该方法
-(void)finalyLoadWKWebView
{
    if(_webView!=nil)
    {
        [_webView stopLoading];
        [_webView setNavigationDelegate:nil];
        [_webView removeFromSuperview];
        
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        _webView = nil;
        
    }
    
    isfinallied = YES;
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if(isfinallied)return;
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0){
            self.progressView.progress = 0;
            ///加载完成后设置图片点击
            [self obtainImage];
        }
        //加载后获取webview的高度
        NSString *js = @"document.body.scrollHeight";
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable height, NSError * _Nullable error) {
            
            CGFloat h = [height floatValue];
//            h-=20;
            [self webviewContSize:h];
        }];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

///重新调整webview的高度
-(void)webviewContSize:(float)fh
{
//    if(isfinallied)return;
//    [_webView setHeight:fh];
//    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, fh)];
//    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:webview:)]) {
//        [self.delegate webViewDidFinishLoad:fh webview:self];
//    }
//    [_webView setNeedsDisplay];
}


- (void)obtainImage{
    if(isfinallied)return;
    if(isChangeFount)
    {
        
    }
    else
    {
        NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'";
        [_webView evaluateJavaScript:str completionHandler:nil];

    }
    //js方法遍历图片添加点击事件 返回所有图片
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var srcs = [];\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    srcs[i] = objs[i].src;\
    };\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+srcs+','+this.src;\
    };\
    };\
    return objs.length;\
    };";
    [_webView evaluateJavaScript:jsGetImages completionHandler:nil];
    [_webView evaluateJavaScript:@"getImages()" completionHandler:nil];
    
    
    
    
    
}

#pragma mark - WKWebView
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if(isfinallied)return;
    
    NSString *str = navigationAction.request.URL.absoluteString;
    ///图片处理
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        NSArray *imageUrlArr = [str componentsSeparatedByString:@","];


//        [ImageScrollView showImageWithImageArr:imageUrlArr];

//        NSLog(@"%@",imageUrlArr);

        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if (navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        if (_isInteriorSkip) {
            return;
        }
        if ([self.delegate respondsToSelector:@selector(webViewDidPreseeUrlWithLink:webview:)]) {
            
            
            [self.delegate webViewDidPreseeUrlWithLink:[NSString stringWithFormat:@"%@",navigationAction.request.URL] webview:self];
            
            
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    
    }
    
    
    if (navigationAction.targetFrame ==nil) {
        
        [webView loadRequest:navigationAction.request];
        
    }
    // 没有这一句页面就不会显示
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

/// 2 页面开始加载

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    webViewLoads++;

}

/// 4 开始获取到网页内容时返回

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if(isfinallied)return;
    noNetWorkImageView.hidden = YES;
    
}

/// 5 页面加载完成之后调用

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if(isfinallied)return;
    webViewLoads--;
    // 隐藏加载状态
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    noNetWorkImageView.hidden = YES;
}

/// 页面加载失败时调用

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    if(isfinallied)return;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    webViewLoads--;
    noNetWorkImageView.hidden = YES;

}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    if(isfinallied)return;
    if(webView.title.length<1)
    {
        [webView reload];
    }
    
}
#pragma mark - setters and getters
- (void)setWebDescription:(NSString *)webDescription{
    if(isfinallied)return;
    if ([webDescription isEqualToString:@""]) return;
    _webDescription = webDescription;
    [self loadWebByURL:webDescription];
    
}

- (void)setHtmlStr:(NSString *)htmlStr{
    if(isfinallied)return;
    if ([htmlStr isEqualToString:@""]) return;
    _htmlStr = htmlStr;
    isLoadHtmlStr = YES;
    [self refreshHtml:htmlStr];
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, BOUNDS_WIDTH, 4)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor clearColor];
        
    }
    return _progressView;
}

-(void)dealloc
{
    


    NSHTTPCookie *cookie;

    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    for (cookie in [storage cookies])

    {

        [storage deleteCookie:cookie];

    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    if(_webView!=nil)
    {
        if(_webView.isLoading)
        {
            [_webView stopLoading];
        }
        
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [_webView setNavigationDelegate:nil];
        [_webView removeFromSuperview];
        _webView = nil;
    }
    
}



@end
