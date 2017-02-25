//
//  EHTabBarViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//
#define BACKGROUND_IMAGE                                           (__bridge id)[UIImage imageNamed:@"application_bg"].CGImage

#import "EHTabBarViewController.h"
#import "EHMineTableViewController.h"
#import "EHConsultTableViewController.h"
#import "EHScienceTableViewController.h"
#import "EHScreenViewController.h"
#import "EHCourseViewController.h"
@interface EHTabBarViewController (){
    UIButton *button;
}

@end

@implementation EHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EHCourseViewController *viewController0 = [[EHCourseViewController alloc] init];
    UINavigationController *nvc0 = [[UINavigationController alloc] initWithRootViewController:viewController0];
    
    
    EHScienceTableViewController *viewController1 = [[EHScienceTableViewController alloc] init];
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    
    EHScreenViewController *viewController2= [[EHScreenViewController alloc] init];
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    
    
    EHConsultTableViewController *viewController3 = [[EHConsultTableViewController alloc] init];
    UINavigationController *nvc3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    
    
    EHMineTableViewController *viewController4 = [[EHMineTableViewController alloc] init];
    UINavigationController *nvc4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    
    self.viewControllers = @[nvc0,nvc1,nvc2,nvc3,nvc4];
    
    [self setupTabBar];
    
}

- (void)setupTabBar {
    
    
    //  12092c
    //    [[UITabBar appearance] setBarTintColor:[UIColor purpleColor]];
    //取消tabBar的透明效果。
    [UITabBar appearance].translucent = NO;
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        
        switch (idx) {
            case 0:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"icon_train"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_train_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"教程";
                
            } break;
            case 1:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"icon_scin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_scin_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"科普";
                
                
            } break;
            case 2:{
//                obj.tabBarItem.enabled=NO;
//                obj.tabBarItem.title=@"";
                //obj.tabBarItem.image = [[UIImage imageNamed:@"icon_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                //obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_light_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"调屏";
                
            } break;
            case 3:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"icon_ask"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_ask_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"咨询";
                
            } break;
            case 4:{
                obj.tabBarItem.image = [[UIImage imageNamed:@"icon_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_my_yes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.title=@"我的";
                
            } break;
                
            default:
                break;
        }
    }];
    
    //修改文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[[UIColor blackColor] colorWithAlphaComponent:0.5], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = THEME_COLOR;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    self.customSelectViews  = [[NSMutableArray alloc] init];
    
//    for (UIView *UITabBarButton in self.tabBar.subviews) {
//        
//        if ([@"UITabBarButton" isEqualToString:NSStringFromClass([UITabBarButton class])]) {
//            
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UITabBarButton.frame.origin.x+UITabBarButton.frame.size.width/2-5, UITabBarButton.frame.origin.y+UITabBarButton.frame.size.height-5, 10, 5)];
//            imageView.image = [UIImage imageNamed:@"main_point"];
//            [self.tabBar addSubview:imageView];
//            [self.customSelectViews addObject:imageView];
//            
//        }
//    }
    
    
    button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-35 , -38, 70, 70)];
    
    button.layer.cornerRadius = 35;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundColor:[UIColor whiteColor]];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"icon_light_yes"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_light_yes"] forState:UIControlStateSelected];
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    [button addTarget:self action:@selector(selectImagePicker) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)selectImagePicker{
    self.selectedIndex = 2;
}


@end
