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
    }
    else{
        cell.titleTextLabel.text = @"视疲劳提醒";
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

@end
