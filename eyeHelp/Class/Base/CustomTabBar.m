//
//  CustomTabBar.m
//  CustomTabBar
//
//  Created by xuehaodong on 2016/12/16.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar ()

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *lastButton; //记录上次被点击的button

@end

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *viewArray = [NSMutableArray arrayWithArray:@[@"教程",@"科普",@"        调屏",@"咨询",@"我的"]];
        
        //背景图
        [self addSubview:self.bgView];
        
        //加载tabBar
        for (int  i = 0; i < self.dataArray.count; i++) {
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemButton setImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
            [itemButton setImage:[UIImage imageNamed:[self.dataArray[i] stringByAppendingString:@"_yes"]] forState:UIControlStateSelected];
            [itemButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = CustomTabBarTypeCourse + i;
            
            [itemButton setTitle:viewArray[i] forState:UIControlStateNormal];
            [itemButton setTitleColor:TEXT_COLOR_THIRDARY forState:UIControlStateNormal];
            [itemButton setTitleColor:THEME_COLOR forState:UIControlStateSelected];
            itemButton.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
            itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
            CGSize imageSize = itemButton.imageView.frame.size;
            CGSize titleSize = itemButton.titleLabel.frame.size;
            
            itemButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width-26, -imageSize.height-5-28, 0);
            itemButton.imageEdgeInsets = UIEdgeInsetsMake( -titleSize.height-5, -4, 0, -titleSize.width);
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            if (i==0) {
                itemButton.selected = YES;
                self.lastButton = itemButton;
            }
            
            [self addSubview:itemButton];
        }
        
        [self addSubview:self.cameraBtn];
        
    }
    return self;
}
//子视图布局
- (void)layoutSubviews{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/self.dataArray.count;
    for (UIView *btn in self.subviews) {
        
        if (btn.tag >= CustomTabBarTypeCourse) {
            btn.frame = CGRectMake((btn.tag - CustomTabBarTypeCourse) * width, 0, width, self.frame.size.height);
        }
        
    }
    self.cameraBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 22);
    
    self.bgView.frame = self.bounds;
}

#pragma mark - button click event -
- (void)clickAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(selectedBarItemWithType:)]) {
        
        [self.delegate selectedBarItemWithType:button.tag];
    }
    

    
    //取消上次点击选中状态
    self.lastButton.selected = NO;
    
    //标记选中
    button.selected = YES;
    
    //赋值新的被点击按钮
    self.lastButton = button;
    
    //点击中间按钮跳过下面
    if (button.tag==CustomTabBarTypeScreen) {
        
        UIButton *myButton1 = (UIButton *)[self viewWithTag:202];
        myButton1.selected = YES;
        self.lastButton.selected = NO;
        self.lastButton = myButton1;
        _cameraBtn.selected = YES;
    }
    else{
        UIButton *myButton1 = (UIButton *)[self viewWithTag:202];
        myButton1.selected = NO;
        _cameraBtn.selected = NO;
    }
}



/**
 子视图超出父视图范围 需要重写该方法 来响应点击时间
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [self.cameraBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(self.cameraBtn.bounds, newPoint)) {
            view = self.cameraBtn;
        }
    }
    return view;
}

#pragma mark - getter and setter -
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"icon_train",@"icon_scin",@"",@"icon_ask",@"icon_my"];
    }
    return _dataArray;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
        _bgView.backgroundColor = [UIColor whiteColor]; // 设置背景颜色
        _bgView.frame = self.bounds;
        
    }
    return _bgView;
}

- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"icon_light"] forState:UIControlStateNormal];
        [_cameraBtn setImage:[UIImage imageNamed:@"icon_light_yes"] forState:UIControlStateSelected];
        [_cameraBtn sizeToFit];
        [_cameraBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.tag = CustomTabBarTypeScreen;
    }
    return _cameraBtn;
}

@end
