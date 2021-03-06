//
//  EHMineTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHMineTableViewController.h"
#import "MineHeaderView.h"
#import "EHMineTableViewCell.h"

#import "EHPersonalDataTableViewController.h"
#import "ExercisePlanTableViewController.h"
#import "EHCollectionViewController.h"
#import "SettingTableViewController.h"
#import "AlertTableViewController.h"
static NSString *const kEHMineTableViewCell = @"kEHMineTableViewCell";

@interface EHMineTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *iconArr;
    NSArray *titleArr;
}

@property (strong, nonatomic) MineHeaderView *mineHeaderViews;

@end

@implementation EHMineTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[UIApplication sharedApplication].statusBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    iconArr = @[@"icon_file",@"icon_plan_my",@"icon_like_my",@"icon_infor",@"icon_setting",@"icon_help"];
    titleArr = @[@"个人资料",@"训练计划",@"我的收藏",@"消息通知",@"设置",@"关于我们"];
    [self prepareView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"我的";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:self options:nil];
    self.mineHeaderViews = [nib objectAtIndex:0];
    self.mineHeaderViews.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    
    self.mineHeaderViews.nickNameLabel.text = [NSString stringWithFormat:@"%@",[UserDefaultsUtils valueWithKey:@"nickName"]];
    self.mineHeaderViews.leftEyeLabel.text = [NSString stringWithFormat:@"左眼：%@",[UserDefaultsUtils valueWithKey:@"leftEye"]];
    self.mineHeaderViews.rightEyeLabel.text = [NSString stringWithFormat:@"右眼：%@",[UserDefaultsUtils valueWithKey:@"rightEye"]];
    
    self.tableView.tableHeaderView = self.mineHeaderViews;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    self.tableView.tableFooterView =view;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EHMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEHMineTableViewCell];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHMineTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellNameLabel.text = titleArr[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:iconArr[indexPath.row]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        EHPersonalDataTableViewController *vc = [[EHPersonalDataTableViewController alloc] init];
        vc.titleName = titleArr[indexPath.row];
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if (indexPath.row == 1){
        ExercisePlanTableViewController *vc = [[ExercisePlanTableViewController alloc] init];
        vc.vcTitle = titleArr[indexPath.row];
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if (indexPath.row == 2){
        EHCollectionViewController *vc = [[EHCollectionViewController alloc] init];
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if (indexPath.row == 3){
        AlertTableViewController *vc = [[AlertTableViewController alloc] init];
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if (indexPath.row == 4){
        SettingTableViewController *vc = [[SettingTableViewController alloc] init];
        vc.titleName = titleArr[indexPath.row];
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else {
            }
}

@end
