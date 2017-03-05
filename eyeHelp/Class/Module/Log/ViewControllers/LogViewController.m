//
//  LogViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/3/4.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController (){
    BOOL isSecure;
}

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
//log view
@property (weak, nonatomic) IBOutlet UIView *logView;
@property (weak, nonatomic) IBOutlet UITextField *logPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *logPsdTF;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *regNowBtn;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
//register view
@property (weak, nonatomic) IBOutlet UIView *regView;
@property (weak, nonatomic) IBOutlet UITextField *regPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *regCheckTF;
@property (weak, nonatomic) IBOutlet UITextField *regPsdTF;
@property (weak, nonatomic) IBOutlet UIButton *getCheckCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
@end

@implementation LogViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButton];
    [self setView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setButton{
    self.logBtn.layer.cornerRadius = 5.0f;
    self.logBtn.layer.masksToBounds = YES;
    
    self.regBtn.layer.cornerRadius = 5.0f;
    self.regBtn.layer.masksToBounds = YES;
    
    //返回
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码
    [self.forgetBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    //注册
    [self.regNowBtn addTarget:self action:@selector(registerNow) forControlEvents:UIControlEventTouchUpInside];
    //登录
    [self.logBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    //获取验证码
    [self.getCheckCodeBtn addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchUpInside];
    //眼睛
    [self.eyeBtn addTarget:self action:@selector(eyeOn) forControlEvents:UIControlEventTouchUpInside];
    //现在注册
    [self.regBtn addTarget:self action:@selector(registerIn) forControlEvents:UIControlEventTouchUpInside];

    isSecure = 0;
}

- (void)setView{
    if (self.viewType == 1) {
        _topImageView.image = [UIImage imageNamed:@"bg_login"];
        self.logView.hidden = NO;
        self.regView.hidden = YES;
        self.backBtn.hidden = YES;
    }
    else{
         _topImageView.image = [UIImage imageNamed:@"bg_signup"];
        self.logView.hidden = YES;
        self.regView.hidden = NO;
        self.backBtn.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
//返回
- (void)back{
    if (self.viewType == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//忘记密码
- (void)forgetPassword{
    
}

//注册
- (void)registerNow{
    LogViewController *vc = [[LogViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    vc.viewType = 2;
    [self.navigationController pushViewController:vc animated:YES];
}
//登录
- (void)logIn{
    if (self.logPhoneTF.text.length != 0) {
        if (self.logPsdTF.text.length != 0) {
            [UserDefaultsUtils saveValue:@"1" forKey:@"ReLog"];
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
            [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];

            }]];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
        else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC setDismissInterval:ALERT_TIME];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
    else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }

}
//获取验证码
- (void)getCheckCode{
    
}
//眼睛
- (void)eyeOn{
    if (isSecure == 0) {
        self.regPsdTF.secureTextEntry = YES;
        isSecure = 1;
    }
    else{
        self.regPsdTF.secureTextEntry = NO;
        isSecure = 0;
    }
}
//现在注册
- (void)registerIn{
    if (self.regPhoneTF.text.length != 0) {
        if (self.regCheckTF.text.length != 0) {
            if (self.regPsdTF.text.length != 0) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:alertVc animated:YES completion:nil];
            }
            else{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                [alertVC setDismissInterval:ALERT_TIME];
                [self presentViewController:alertVC animated:YES completion:nil];
            }
        }
        else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入验证码" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC setDismissInterval:ALERT_TIME];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
    else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"请输入手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC setDismissInterval:ALERT_TIME];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
@end
