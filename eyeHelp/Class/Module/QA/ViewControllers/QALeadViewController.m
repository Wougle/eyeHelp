//
//  QALeadViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "QALeadViewController.h"
#import "QAViewController.h"
@interface QALeadViewController ()
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet HyperlinksButton *passBtn;

@end

@implementation QALeadViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[UIApplication sharedApplication].statusBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beginBtn.layer.cornerRadius = 5.0f;
    self.beginBtn.layer.masksToBounds = YES;
    
    [self.passBtn setColor:TEXT_COLOR_MAIN];
    
    [self.beginBtn addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.passBtn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)begin{
    QAViewController *vc = [[QAViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)pass{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
