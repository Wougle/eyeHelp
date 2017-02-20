//
//  EHGraphicTextViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/20.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHGraphicTextViewController.h"

@interface EHGraphicTextViewController ()

@end

@implementation EHGraphicTextViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = NO;
    //    for (UIView *v in self.tabBarController) {
    //
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
