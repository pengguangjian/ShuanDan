//
//  LoginVC.m
//  QingKu
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 mcxzfa. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    [self drawUI];
    
}

-(void)drawUI
{
    LoginView *lview = [[LoginView alloc] init];
    [self.view addSubview:lview];
    [lview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            if(kTopHeight<64)
            {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
            }
            else
            {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kTopHeight, 0, 0, 0));
            }
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
