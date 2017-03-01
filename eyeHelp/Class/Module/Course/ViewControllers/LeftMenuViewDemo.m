//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"
#import "LeftMenuTableViewCell.h"

static NSString *const kLeftMenuTableViewCell = @"kLeftMenuTableViewCell";

@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *imageArr;
    NSArray *amArr;
    NSArray *pmArr;
}

@property (nonatomic ,strong)UITableView    *contentTableView;

@end

@implementation LeftMenuViewDemo

 
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 220)];
    [headerView setBackgroundColor:TEXT_COLOR_MAIN];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.6-90)/2,110,90,90)];

    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"pic_head"]];
    [headerView addSubview:imageview];
    
    [self addSubview:headerView];
    
    self.backgroundColor = TEXT_COLOR_MAIN;
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - 220 - 85/2)
                                                                       style:UITableViewStyleGrouped];
    contentTableView.backgroundView = nil;
    contentTableView.backgroundColor = TEXT_COLOR_MAIN;
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    //添加尾部
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 85/2, Frame_Width, 85/2)];
    [footerView setBackgroundColor:Rgb2UIColor(22.0, 90.0, 79.0, 1.0)];
    
    UIButton *addPlanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Frame_Width, 85/2)];
    [addPlanBtn setTitle:@"重新制定训练计划" forState:UIControlStateNormal];
    [addPlanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addPlanBtn.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
    addPlanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [addPlanBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [addPlanBtn addTarget:self action:@selector(addPlan) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addPlanBtn];

    [self addSubview:footerView];
    
    imageArr = @[@"icon_alarm",@"icon_list",@"icon_alarm",@"icon_list",@"icon_alarm",@"icon_list",@"icon_alarm",@"icon_list"];
//    int x = arc4random()%4;
//    int y = arc4random()%4;
//    if (x == 0) {
//        amArr = @[@"8:00",@"揉刮解眼疾",@"9:30",@"按摩护眼睛",@"11:00",@"魔芋眼贴"];
//    }
//    else if(x == 1){
//        amArr = @[@"8:00",@"大空骨的救赎",@"9:30",@"按摩护眼睛",@"11:00",@"揉刮解眼疾"];
//    }
//    else if(x == 2){
//        amArr = @[@"9:30",@"魔芋眼贴",@"11:00",@"揉刮解眼疾"];
//    }
//    else{
//        amArr = @[@"9:00",@"揉刮解眼疾",@"10:30",@"大空骨的救赎"];
//    }
//    
//    if (y == 0) {
//        pmArr = @[@"13:30",@"按摩护眼睛",@"15:00",@"大空骨的救赎",@"16:30",@"魔芋眼贴",];
//    }
//    else if(y == 1){
//        pmArr = @[@"13:30",@"按摩护眼睛",@"15:00",@"揉刮解眼疾",@"16:30",@"魔芋眼贴",];
//    }
//    else if(y == 2){
//        pmArr = @[@"13:30",@"魔芋眼贴",@"16:00",@"大空骨的救赎"];
//    }
//    else{
//        pmArr = @[@"13:30",@"大空骨的救赎",@"16:00",@"揉刮解眼疾"];
//    }
    if ([UserDefaultsUtils valueWithKey:@"amArr"] == nil) {
        amArr = @[@"9:30",@"魔芋眼贴",@"11:00",@"揉刮解眼疾"];
        pmArr = @[@"13:30",@"魔芋眼贴",@"16:00",@"大空骨的救赎"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"1"]){
        amArr = @[@"9:00",@"揉刮解眼疾",@"10:30",@"大空骨的救赎"];
        pmArr = @[@"13:30",@"大空骨的救赎",@"16:00",@"揉刮解眼疾"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"2"]){
        amArr = @[@"8:00",@"揉刮解眼疾",@"9:30",@"按摩护眼睛",@"11:00",@"魔芋眼贴"];
        pmArr = @[@"13:30",@"魔芋眼贴",@"16:00",@"大空骨的救赎"];
    }
    else if([[UserDefaultsUtils valueWithKey:@"amArr"] isEqual:@"3"]){
        amArr = @[@"8:00",@"大空骨的救赎",@"9:30",@"按摩护眼睛",@"11:00",@"揉刮解眼疾"];
        pmArr = @[@"13:30",@"按摩护眼睛",@"15:00",@"大空骨的救赎",@"16:30",@"魔芋眼贴",];
    }
    else{
        amArr = @[@"8:00",@"揉刮解眼疾",@"9:30",@"按摩护眼睛",@"11:00",@"魔芋眼贴"];
        pmArr = @[@"13:30",@"按摩护眼睛",@"15:00",@"揉刮解眼疾",@"16:30",@"魔芋眼贴",];
    }
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return amArr.count;
    }
    else{
        return pmArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftMenuTableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setBackgroundColor:TEXT_COLOR_MAIN];
    [cell.planNameLabel setTextColor:[UIColor whiteColor]];

    cell.hidden = NO;

    if (indexPath.section == 0) {
        cell.iconImageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
        cell.planNameLabel.text = amArr[indexPath.row];
    }
    else{
        cell.iconImageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
        cell.planNameLabel.text = pmArr[indexPath.row];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Frame_Width*0.6, 50)];
    myView.backgroundColor = TEXT_COLOR_MAIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 16, 50, 20)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor=[UIColor whiteColor];
    [myView addSubview:titleLabel];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(54, 10, 30, 30)];
    [myView addSubview:imageView];
    if (section == 0) {
        titleLabel.text = @"上午";
        imageView.image = [UIImage imageNamed:@"icon_am"];
    }
    else{
        titleLabel.text = @"下午";
        imageView.image = [UIImage imageNamed:@"icon_pm"];
    }
    return myView;
}


#pragma  mark - buttonAction

- (void)addPlan{
    [self.customDelegate LeftMenuViewClick:-1];
}

@end
