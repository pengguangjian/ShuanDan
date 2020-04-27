//
//  ViewController.m
//  QingKu
//
//  Created by mdb-losaic on 2019/6/29.
//  Copyright © 2019 penggj. All rights reserved.
//

#import "ViewController.h"
#import "MDBwebVIew.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MDBwebVIew *webview = [[MDBwebVIew alloc] initWithFrame:CGRectMake(0, 0, BOUNDS_WIDTH, 100)];
    [self.view addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [webview loadWebByURL:@"http://tiktok.dottp.com/Home/Index/index.html"];
}


@end
