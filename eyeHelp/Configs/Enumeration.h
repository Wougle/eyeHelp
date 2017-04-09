//
//  Enumeration.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Enumeration_h
#define Enumeration_h

typedef NS_ENUM(NSInteger, EHCoureseType){
    EHGraphyState = 0,   //图文
    EHVideoState = 1,    //视频
    EHCoureseState,      //手把手
};

typedef NS_ENUM(NSInteger, EHGraphicTextType){
    EHCource = 0,   //图文
    EHScience = 1,  //科普
    EHConsult,      //咨询
};

typedef NS_ENUM(NSInteger, EHCollectionType){
    Cource = 0,   //图文
    Science = 1,  //科普
};

#endif /* Enumeration_h */
