//
//  ExercisePlanTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "ExercisePlanTableViewController.h"
#import "ExercisePlanTableViewCell.h"

static NSString *const kExercisePlanTableViewCell = @"kExercisePlanTableViewCell";
@interface ExercisePlanTableViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *iconArr;
    NSArray *titleArr;
}

@end

@implementation ExercisePlanTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;
    iconArr = @[@"9:00",@"10:30",@"13:30",@"16:00"];
    titleArr = @[@"大空骨的救赎",@"按摩护眼睛",@"大空骨的救赎",@"按摩护眼睛"];
    [self prepareView];
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
}

@end
