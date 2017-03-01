//
//  ExercisePlanTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "ExercisePlanTableViewController.h"
#import "ExercisePlanTableViewCell.h"
#import "QALeadViewController.h"

static NSString *const kExercisePlanTableViewCell = @"kExercisePlanTableViewCell";
@interface ExercisePlanTableViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *iconArr;
    NSArray *titleArr;
    NSArray *timeArr;
}

@end

@implementation ExercisePlanTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;
    
    if ([UserDefaultsUtils valueWithKey:@"amArr"] == nil) {
        iconArr = @[@"9:30",@"11:00",@"13:30",@"16:00"];
        titleArr = @[@"魔芋眼贴",@"揉刮解眼疾",@"魔芋眼贴",@"大空骨的救赎"];
        timeArr = @[@"8"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"1"]){
        iconArr = @[@"9:00",@"10:30",@"13:30",@"16:00"];
        titleArr = @[@"揉刮解眼疾",@"大空骨的救赎",@"大空骨的救赎",@"揉刮解眼疾"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"2"]){
        iconArr = @[@"8:00",@"9:30",@"11:00",@"13:30",@"16:00"];
        titleArr = @[@"揉刮解眼疾",@"按摩护眼睛",@"魔芋眼贴",@"魔芋眼贴",@"大空骨的救赎"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"3"]){
        iconArr = @[@"8:00",@"9:30",@"11:00",@"13:30",@"15:30",@"16:00"];
        titleArr = @[@"大空骨的救赎",@"按摩护眼睛",@"揉刮解眼疾",@"按摩护眼睛",@"大空骨的救赎",@"魔芋眼贴"];
    }
    else{
        iconArr = @[@"8:00",@"9:30",@"11:00",@"13:30",@"15:30",@"16:00"];
        titleArr = @[@"揉刮解眼疾",@"按摩护眼睛",@"魔芋眼贴",@"按摩护眼睛",@"揉刮解眼疾",@"魔芋眼贴"];
    }
    
    [self prepareView];
    [self addNotification];
    [self setNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigation{
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 34.f, 34.f)];
    [testBtn setImage:[UIImage imageNamed:@"重测"] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(testBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)addNotification{
    for (int i = 0; i < iconArr.count; i++) {
        
        //创建一条通知
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"您有一条新的通知";
        content.subtitle = @"Eye Help的训练通知";
        content.body = [NSString stringWithFormat:@"快开始你的%@训练课程吧",titleArr[i]];
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:20 repeats:NO];
        
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        components.hour = 8;
//        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        
        //添加
        NSString *requestIdentifier = [NSString stringWithFormat:@"sampleRequest%lu",(unsigned long)iconArr.count]
        ;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                              content:content
                                                                              trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
        }];
    }
}

-(void)prepareView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    self.tableView.tableHeaderView = view;
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    self.tableView.tableFooterView = view2;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return iconArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExercisePlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kExercisePlanTableViewCell];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExercisePlanTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.courseLabel.text = titleArr[indexPath.row];
    cell.timeLabel.text = iconArr[indexPath.row];
    
    return cell;
}


#pragma  mark - buttonAction

- (void)testBtn{
    QALeadViewController *vc = [[QALeadViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
