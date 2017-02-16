//
//  CustomTabBar.h
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;


/**
 定义枚举
 */
typedef NS_ENUM(NSUInteger,CustomTabBarType){
    CustomTabBarTypeScreen = 100,   //屏幕
    CustomTabBarTypeCourse = 200,   //训练
    CustomTabBarTypeSceince,        //科普
    CustomTabBarTypeConsult,        //咨询
    CustomTabBarTypeMine,           //我的
};


/**
 代理
 */
@protocol CustomTabBarTypeDelegate <NSObject>

- (void)selectedBarItemWithType:(CustomTabBarType)type;

@end

@interface CustomTabBar : UIView


// 代理属性
@property (nonatomic,assign) id<CustomTabBarTypeDelegate> delegate;

@end
