//
//  ModifyViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/3/1.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phonePassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNewPhoTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneAuthTF;
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;

@property (weak, nonatomic) IBOutlet UIView *nickNameView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

@property (weak, nonatomic) IBOutlet UIView *commonView;
@property (weak, nonatomic) IBOutlet UITextField *commonFirstTF;
@property (weak, nonatomic) IBOutlet UITextField *commonSecondTF;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleNameStr;
    [self setView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (void)setView{
    if (self.type == 1) {
        _nickNameView.hidden = NO;
        _commonView.hidden = YES;
        _phoneView.hidden = YES;
        _nickNameTF.placeholder = @"请输入新的昵称";
    }
    else if(self.type == 2){
        _nickNameView.hidden = YES;
        _commonView.hidden = YES;
        _phoneView.hidden = NO;
        _phonePassWordTF.placeholder = @"请输入登录密码";
        _phoneNewPhoTF.placeholder = @"请输入新的手机号";
        _phoneAuthTF.placeholder = @"请输入验证码";
        _authCodeBtn.layer.cornerRadius = 5.0f;
        _authCodeBtn.layer.masksToBounds = YES;
        [_authCodeBtn addTarget:self action:@selector(authCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        _nickNameView.hidden = YES;
        _commonView.hidden = NO;
        _phoneView.hidden = YES;
        if (self.type == 3) {
            _commonFirstTF.placeholder = @"请输入原密码（8-12字符）";
            _commonSecondTF.placeholder = @"请输入新密码（8-12字符）";
        }
        else{
            _commonFirstTF.placeholder = @"请输入左眼视力";
            _commonSecondTF.placeholder = @"请输入右眼视力";
        }
    }

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
