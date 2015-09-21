//
//  CenterViewController.m
//  CreatTabBar
//
//  Created by zgq on 15/7/12.
//  Copyright (c) 2015年 zgq. All rights reserved.
//

#import "CenterViewController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "TopViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"

@interface CenterViewController (){
    
    UIImageView *_tabBarView;
}

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatTabBarView];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self creatChildViewControllers];
}
- (void)creatTabBarView{
    
    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight, kScreenWidth, kTabBarHeight)];
    //image view要开启响应用户事件
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.image = [UIImage imageNamed:@"mask_navbar.png"];
    
    [self.view addSubview:_tabBarView];
    
    NSArray *imageNames = @[
                            @"home_tab_icon_1",
                            @"home_tab_icon_2",
                            @"home_tab_icon_3",
                            @"home_tab_icon_4",
                            @"home_tab_icon_5"
                            ];
    float itemWidth = kScreenWidth / 5;
    for (int i = 0; i < imageNames.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemWidth * i, 0, itemWidth, kTabBarHeight);
        
        button.tag = 100+i;
        
        button.showsTouchWhenHighlighted = YES;
        
        [button setImage:[UIImage imageNamed:imageNames[i]]
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(selectTabButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [_tabBarView addSubview:button];
        
    }

}

- (void)creatChildViewControllers{
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    TopViewController *topVC = [[TopViewController alloc]init];
    ProfileViewController *profileVC = [[ProfileViewController alloc]init];
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    
    NSArray *viewControllers = @[homeVC,messageVC,topVC,profileVC,moreVC];
    
    for (UIViewController *viewController in viewControllers) {
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:viewController];
        
        [self addChildViewController:navVC];
        navVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight);
    }
    
    //取得第一个导航控制器
    UINavigationController *firstNavVC = [self.childViewControllers firstObject];
    //加到self.view上显示
    [self.view insertSubview:firstNavVC.view belowSubview:_tabBarView];
}
- (void)selectTabButton:(UIButton *)button{
    
    self.selectedIndex = button.tag-100;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex) {
        UIViewController *currentVC = [self.childViewControllers objectAtIndex:selectedIndex];
        UIViewController *preVC = [self.childViewControllers objectAtIndex:_selectedIndex];
        
        [UIView transitionFromView:preVC.view toView:currentVC.view duration:.25 options:UIViewAnimationOptionTransitionNone completion:^(BOOL finished) {
            
        }];
        
        [preVC.view removeFromSuperview];
        _selectedIndex = selectedIndex;
    }
}

@end
