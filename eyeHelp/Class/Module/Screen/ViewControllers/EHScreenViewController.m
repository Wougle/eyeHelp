//
//  EHScreenViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHScreenViewController.h"
#import "VWaterView.h"
#import "EHAdjustTableViewCell.h"
#import "EHChartViewViewController.h"
static NSString *const kEHAdjustTableViewCell = @"kEHAdjustTableViewCell";

@interface EHScreenViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;
@property (weak, nonatomic) IBOutlet UILabel *circlePersentLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayUseLabel;
@property (weak, nonatomic) IBOutlet UILabel *wasteLabel;
@property (weak, nonatomic) IBOutlet UIButton *weekUseLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EHScreenViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTableView];
    [self setCircleView];
    [self setData];
    // Do any additional setup after loading the view from its nib.
}

- (void)setData{
    _todayUseLabel.attributedText = [self todayUseSituation:30];
    _wasteLabel.attributedText = [self lastUseSituation:10];
}

- (void)setNavigation{
    [_weekUseLabel addTarget:self action:@selector(turnTo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = BG_COLOR;
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = NO;
}

- (void)setCircleView{
    VWaterView *waterView = [[VWaterView alloc]initWithFrame:self.circleImageView.bounds];
    waterView.sportPersnet = 79/100;
    [self.circleImageView addSubview:waterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EHAdjustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEHAdjustTableViewCell];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"EHAdjustTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - button action
- (void)turnTo{
    EHChartViewViewController *vc = [[EHChartViewViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 设置label的富文本和内容

- (NSMutableAttributedString *)todayUseSituation:(int)time{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"今日已用手机%i分钟", time]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(6, attrStr.length-8)];
    return attrStr;
}

- (NSMutableAttributedString *)lastUseSituation:(int)time{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离眼疲劳还剩%i分钟", time]];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                             NSForegroundColorAttributeName : [UIColor whiteColor]
                             } range:NSMakeRange(7, attrStr.length-9)];
    return attrStr;
}

@end
