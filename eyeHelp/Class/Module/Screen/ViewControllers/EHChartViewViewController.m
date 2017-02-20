//
//  EHChartViewViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/20.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHChartViewViewController.h"
#import "GraphView.h"

@interface EHChartViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *charTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiredTimeLabel;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@end

@implementation EHChartViewViewController

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
    
    self.title = @"一周记录";
    
    [self setGraphView];
    
    UIImageView *buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 207, SCREEN_WIDTH-20, 8)];
    buttonImageView.image = [UIImage imageNamed:@"bottom"];
    [self.graphView addSubview:buttonImageView];
}

- (void)setGraphView{
    NSArray *xTitles = @[@"星期一",@"星期二",@"星期三", @"星期四",@"星期五",@"星期六", @"星期日"];
    CGFloat xScaleLength = SCREEN_WIDTH/7;
    NSArray *targetArray = @[@"2",@"1.2",@"3.2",@"6",@"4.5",@"1",@"3.2",@"1.2"];
    NSArray *yTitles = @[@"6",@"5",@"4",@"3",@"2",@"1",@"0"];
    
    CGFloat maxValue = 6;
    
    
    self.graphView.xTitleArray = xTitles;
    self.graphView.yTitleArray = yTitles;
    self.graphView.xScaleLength = xScaleLength;
    self.graphView.targetValues = targetArray;
    self.graphView.yMaxValue = maxValue;
    self.graphView.needBar = NO;
    [self.graphView drawGraph];
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
