//
//  ModifyViewController.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/3/1.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyViewController : UIViewController

@property(nonatomic, strong)NSString *titleNameStr;

@property(nonatomic, assign)NSInteger type;//1-修改昵称 2-修改手机号 3-修改密码 4-修改视力

@end
