//
//  Constants.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kTimeSpan 1.5

//color
#define Rgb2UIColor(r, g, b, a)        [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a)/1.0)]

#define THEME_COLOR Rgb2UIColor(25, 192, 160, 1) //主色 青
#define THEME_SECONDARY_COLOR Rgb2UIColor(17, 90, 79, 1) //辅色 深青
#define THEME_THIRDARY_COLOR Rgb2UIColor(255, 201, 40, 1) //辅色 c橙黄
#define BG_COLOR Rgb2UIColor(243, 243, 243, 1) //底色
#define TEXT_COLOR_MAIN Rgb2UIColor(51, 51, 51, 1) //主要文字颜色 黑
#define TEXT_COLOR_SECONDARY Rgb2UIColor(102, 102, 102, 1) //次要文字颜色 深灰
#define TEXT_COLOR_THIRDARY Rgb2UIColor(153, 153, 153, 1) //次要文字颜色 灰
#define LINE_COLOR Rgb2UIColor(221, 221, 221, 1) // 线条颜色


#define ALERT_TITLE @"EyeHelp"
#define ALERT_TIME 1.5

//size
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

//APP INFO
#define APP_DISPLAYNAME     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define ALERT_TITLE APP_DISPLAYNAME
#define VERSION             [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define SystemBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#ifdef DEBUG
#define DBG(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DBG(format, ...)
#endif


#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])

#define g_myself [MySelfInfo sharedMySelfInfo]

#endif /* Constants_h */
