//
//  LoginView.m
//  QingKu
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 mcxzfa. All rights reserved.
//

#import "LoginView.h"
#import <AuthenticationServices/AuthenticationServices.h>

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self drawUI];
    }
    return self;
}

-(void)drawUI
{
    NSArray *arr = @[@"请输入手机号",@"请输入密码"];
    
    for(int i = 0 ; i < arr.count; i++)
    {
        UIView *viewitem = [[UIView alloc] init];
        [self addSubview:viewitem];
        [viewitem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.offset(50+55*i);
            make.height.offset(55);
        }];
        UITextField *field = [self drawItem:viewitem];
        [field setPlaceholder:arr[i]];
    }
    
    UIButton *btdengl = [[UIButton alloc] init];
    [btdengl setTitle:@"登录" forState:UIControlStateNormal];
    [btdengl setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btdengl.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btdengl setBackgroundColor:RGB(90, 90, 234)];
    [btdengl.layer setMasksToBounds:YES];
    [btdengl.layer setCornerRadius:25];
    [self addSubview:btdengl];
    [btdengl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.offset(190);
        make.height.offset(50);
    }];
    
    
    
    UIButton *btzc = [[UIButton alloc] init];
    [btzc setTitleColor:RGB(90, 90, 234) forState:UIControlStateNormal];
    [btzc setTitle:@"立即注册" forState:UIControlStateNormal];
    [btzc.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:btzc];
    [btzc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btdengl);
        make.top.equalTo(btdengl.mas_bottom);
        make.height.offset(40);
    }];
    
    UIButton *btforgetPWd = [[UIButton alloc] init];
    [btforgetPWd setTitleColor:RGB(90, 90, 234) forState:UIControlStateNormal];
    [btforgetPWd setTitle:@"忘记密码" forState:UIControlStateNormal];
    [btforgetPWd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:btforgetPWd];
    [btforgetPWd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btdengl);
        make.top.equalTo(btdengl.mas_bottom);
        make.height.offset(40);
    }];
    
    UILabel *lbother = [[UILabel alloc] init];
    [lbother setText:@"其它登录"];
    [lbother setTextColor:RGB(180, 180, 180)];
    [lbother setTextAlignment:NSTextAlignmentCenter];
    [lbother setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:lbother];
    [lbother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btforgetPWd.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    UIView *viewleft = [[UIView alloc] init];
    [viewleft setBackgroundColor:RGB(234, 234, 234)];
    [self addSubview:viewleft];
    [viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(lbother.mas_left).offset(-15);
        make.centerY.equalTo(lbother);
        make.height.offset(1);
    }];
    
    UIView *viewright = [[UIView alloc] init];
    [viewright setBackgroundColor:RGB(234, 234, 234)];
    [self addSubview:viewright];
    [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(15);
        make.left.equalTo(lbother.mas_right).offset(15);
        make.centerY.equalTo(lbother);
        make.height.offset(1);
    }];
    
    UIButton *btfacebook = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btfacebook setImage:[UIImage imageNamed:@"faceBook"] forState:UIControlStateNormal];
    
    UIButton *btzalo = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btzalo setImage:[UIImage imageNamed:@"zalo"] forState:UIControlStateNormal];
    NSArray *arrotherlogin = @[btfacebook,btzalo];
    
    UIStackView *stackview = [[UIStackView alloc] initWithArrangedSubviews:arrotherlogin];
    stackview.spacing = 20;
    [self addSubview:stackview];
    [stackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(lbother.mas_bottom).offset(20);
        make.height.offset(40);
    }];
    
    
    if (@available(iOS 13.0, *)) {
           // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleBlack];
        appleIDBtn.frame = CGRectMake(0, 0, 40, 40);
        appleIDBtn.layer.cornerRadius = 20.0f;
//        [appleIDBtn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [stackview insertArrangedSubview:appleIDBtn atIndex:0];
    }
}


-(UITextField *)drawItem:(UIView *)view
{
    UITextField *field = [[UITextField alloc] init];
    [field setTextColor:RGB(30, 30, 30)];
    [field setTextAlignment:NSTextAlignmentLeft];
    [field setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(view).offset(-15);
        make.top.equalTo(view);
        make.bottom.equalTo(view).offset(-2);
    }];
    
    
    UIView *viewline = [[UIView alloc] init];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [view addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(field);
        make.bottom.equalTo(view);
        make.height.offset(1);
    }];
    
    return field;
}

@end
