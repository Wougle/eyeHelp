//
//  CustomTabBarController.m
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "CustomNavigationController.h"
#import "EHMineTableViewController.h"
#import "EHConsultTableViewController.h"
#import "EHScienceTableViewController.h"
#import "EHScreenTableViewController.h"
#import "EHCourseViewController.h"
@interface CustomTabBarController ()<CustomTabBarTypeDelegate>

@property (nonatomic,strong) CustomTabBar *itemTabBar;
@end

@implementation CustomTabBarController


- (void)selectedBarItemWithType:(CustomTabBarType)type{
    
    if (type!=CustomTabBarTypeScreen) {
        self.selectedIndex = type - CustomTabBarTypeCourse;
        return;
    }
    self.selectedIndex = 2;
    return;
//    LaunchViewController *launchView = [[LaunchViewController alloc] init];
//    [self presentViewController:launchView animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置
    [self configViewConrollers];
    [self.view addSubview:self.itemTabBar];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
}


- (void)configViewConrollers{
    
    NSMutableArray *viewArray = [NSMutableArray arrayWithArray:@[@"EHCourseViewController",@"EHScienceTableViewController",@"EHScreenTableViewController",@"EHConsultTableViewController",@"EHMineTableViewController"]];
    
    for (NSInteger i = 0; i < viewArray.count; i ++) {
        
        NSString *classStr = viewArray[i];
        UIViewController *viewClass = [[NSClassFromString(classStr) alloc] init];

        CustomNavigationController *navigationController = [[CustomNavigationController alloc] initWithRootViewController:viewClass];
        [viewArray replaceObjectAtIndex:i withObject:navigationController];
    }

    
    self.viewControllers = viewArray;
}

- (CustomTabBar *)itemTabBar{
    if (!_itemTabBar) {
        CGRect rect = self.tabBar.frame;
        _itemTabBar = [[CustomTabBar alloc] initWithFrame:rect];
        _itemTabBar.delegate = self;
    }
    return _itemTabBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
