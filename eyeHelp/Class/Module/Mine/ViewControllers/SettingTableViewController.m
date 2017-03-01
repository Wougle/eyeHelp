//
//  SettingTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/26.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingTableViewCell.h"

static NSString *const kSettingTabelViewCell = @"kSettingTabelViewCell";
@interface SettingTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    [self prepareView];
    [self setBtn];
    [self addNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    self.tableView.tableFooterView =view;
}

- (void)setBtn{
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 140, SCREEN_WIDTH - 20, 40)];
    nextBtn.backgroundColor = Rgb2UIColor(226, 64, 68, 1.0);
    nextBtn.layer.cornerRadius = 5.0f;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [nextBtn setTintColor:[UIColor whiteColor]];
    [nextBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:nextBtn];
}

- (void)quit{
    
}

- (void)addNotification{
    //如果通知已开启
    if ([[UserDefaultsUtils valueWithKey:@"tired"] isEqual:@1]) {
        //创建一条通知
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"您有一条新的通知";
        content.subtitle = @"Eye Help的疲劳通知";
        content.body = @"您已进入视疲劳状态，请注意休息";
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3600 repeats:NO];
        
        //添加通知
        NSString *requestIdentifier = @"sampleRequest"
        ;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                              content:content
                                                                              trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
        }];
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingTabelViewCell];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.titleTextLabel.text = @"训练定时提醒";
        if ([[UserDefaultsUtils valueWithKey:@"exercise"]  isEqual: @1]) {
            [cell.baseSwitch setOn:YES];
        }
        else{
            [cell.baseSwitch setOn:NO];
        }
        [cell.baseSwitch addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        cell.titleTextLabel.text = @"视疲劳提醒";
        if ([[UserDefaultsUtils valueWithKey:@"tired"]  isEqual: @1]) {
            [cell.baseSwitch setOn:YES];
        }
        else{
            [cell.baseSwitch setOn:NO];
        }
        [cell.baseSwitch addTarget:self action:@selector(switchAction2:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = BG_COLOR;
    return  view;
}

#pragma mark - buttonAction

- (void)switchAction1:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [UserDefaultsUtils saveValue:@1 forKey:@"exercise"];
    }else {
        [UserDefaultsUtils saveValue:@0 forKey:@"exercise"];
    }
    
}

- (void)switchAction2:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [UserDefaultsUtils saveValue:@1 forKey:@"tried"];
    }else {
        [UserDefaultsUtils saveValue:@0 forKey:@"tired"];
    }
    [self addNotification];
}

@end
