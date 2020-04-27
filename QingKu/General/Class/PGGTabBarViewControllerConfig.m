//
//  PGGTabBarViewControllerConfig.m
//  Meidebi
//
//  Created by mdb-losaic on 2018/6/7.
//  Copyright © 2018年 meidebi. All rights reserved.
//

#import "PGGTabBarViewControllerConfig.h"
#import "MyMainViewController.h"
#import "TaoXunMainViewController.h"
#import "FenLeiMainViewController.h"
#import "JingXuanMainViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>


@interface PGGBaseNavigationController : UINavigationController
@end
@implementation PGGBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}
@end


@interface PGGTabBarViewControllerConfig ()

///页面
@property (nonatomic , retain) NSArray *arrVC;
///选中后的图片
@property (nonatomic , retain) NSMutableArray *arrSelectimg;
///默认图片
@property (nonatomic , retain) NSMutableArray *arrnomimg;
///按钮标题
@property (nonatomic , readwrite) NSMutableArray *arrbttitle;
///选中的字体颜色
@property (nonatomic , retain) UIColor *colorSelect;
///默认颜色
@property (nonatomic , retain) UIColor *colornomo;
///当前选中的是那个按钮
@property (nonatomic , retain) UIButton *btnowselect;


@property (nonatomic , retain) NSMutableArray *arrallbt;

@end

@implementation PGGTabBarViewControllerConfig
@synthesize viewTabBar;

//数组数据和颜色
-(void)writeData
{
    self.arrVC = [self PGGviewControllers];
    self.arrbttitle = [[NSMutableArray alloc]initWithObjects:@"精选",@"分类",@"淘讯",@"我的", nil];
    self.colornomo = [UIColor grayColor];
    
    self.colorSelect = [UIColor colorWithHexString:@"#faa159"];
    self.arrSelectimg = [[NSMutableArray alloc]initWithObjects:@"home_select",@"yijiandaigou_select",@"original_select",@"user_select", nil];
    self.arrnomimg = [[NSMutableArray alloc]initWithObjects:@"home_normal",@"yijiandaigou_normal",@"original_normal",@"user_normal", nil];
}

- (NSArray *)PGGviewControllers {
    
    UIViewController *firstController = [[JingXuanMainViewController alloc] init];
    UIViewController *secondController = [[FenLeiMainViewController alloc] init];
    UIViewController *thirdController = [[TaoXunMainViewController alloc] init];
    UIViewController *fourthController = [[MyMainViewController alloc] init];
    
    
    ///这里占用了部分cup20%
    PGGBaseNavigationController *firstNavigationController = [[PGGBaseNavigationController alloc]
                                                              initWithRootViewController:firstController];
    
    PGGBaseNavigationController *secondNavigationController = [[PGGBaseNavigationController alloc]
                                                               initWithRootViewController:secondController];
    
    PGGBaseNavigationController *thirdNavigationController = [[PGGBaseNavigationController alloc]
                                                              initWithRootViewController:thirdController];
    
    
    PGGBaseNavigationController *fourthNavigationController = [[PGGBaseNavigationController alloc]
                                                               initWithRootViewController:fourthController];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    
    return viewControllers;
}

-(NSMutableDictionary *)dictiaozhuanitem:(NSArray *)arr andident:(NSString *)strident
{
    
    NSMutableDictionary *dicitemtemp = [NSMutableDictionary new];
    [dicitemtemp setObject:arr forKey:@"title"];
    [dicitemtemp setObject:strident forKey:@"identifier"];
    return dicitemtemp;
}

-(CSSearchableItem *)setitemValue:(NSString *)title andidentifier:(NSString *)identifier
{
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
    attributeSet.title = title;
    attributeSet.contentType = @"测试";
    UIImage *thumbImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon120.png"]];
    attributeSet.thumbnailData = UIImagePNGRepresentation(thumbImage);//beta 1 there is a bug
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:identifier                                                                                                                                                                                                                                      domainIdentifier:@"com.meidebi.iPhone"                                                                                                                                                                                  attributeSet:attributeSet];
    return item;
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
            titleSize:(CGFloat)size
        titleFontName:(NSString *)fontName
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{
    
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    tabbarItem.imageInsets = UIEdgeInsetsMake(0, -10, -6, -10);
    if(title.length==0)
    {
        tabbarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    
    // S未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self writeData];

    for(int i = 0 ; i <_arrVC.count ; i++)
    {
        UIViewController *homeVC=_arrVC[i];
        [self setTabBarItem:homeVC.tabBarItem
                      title:self.arrbttitle[i]
                  titleSize:11.0
              titleFontName:@"HeiTi SC"
              selectedImage:self.arrSelectimg[i]
         selectedTitleColor:self.colorSelect
                normalImage:self.arrnomimg[i]
           normalTitleColor:self.colornomo];
    }
    self.viewControllers = _arrVC;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSetItem:) name:@"tabbarselectother" object:nil];
    
    UIImage *i = [UIImage imageNamed:@"write_back_tabbar.png"];
    
    [self.tabBar setBackgroundImage:i];
    
    [self.tabBar setShadowImage:i];
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, -1, self.tabBar.width, 1)];
    [viewline setBackgroundColor:RGB(245, 245, 245)];
    [self.tabBar addSubview:viewline];
    self.tabBar.layer.shadowColor = RGB(0, 0, 0).CGColor;
    // 设置阴影偏移量
    self.tabBar.layer.shadowOffset = CGSizeMake(0,-2);
    // 设置阴影透明度
    self.tabBar.layer.shadowOpacity = 0.2;
    // 设置阴影半径
    self.tabBar.layer.shadowRadius = 4;
    
    
    
    
}


-(void)selectSetItem:(NSNotification *)notifi
{
    NSInteger itemp = [notifi.object integerValue];
    if(itemp<0)
    {
        itemp=0;
    }
    if(itemp>=self.arrVC.count)return;
    self.selectedIndex = itemp;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
