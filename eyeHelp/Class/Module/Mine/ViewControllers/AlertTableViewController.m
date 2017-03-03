//
//  AlertTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/3/3.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "AlertTableViewController.h"
#import "AlertTableViewCell.h"
static NSString *const kAlertTableViewCell = @"kAlertTableViewCell";
@interface AlertTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property(nonatomic,strong)NSMutableArray *alertArr;
@end

@implementation AlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    
    [self setTableView];
    [self setData];//数据
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setTableView{
    self.view.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _alertArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAlertTableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlertTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.iconImageView.image = [UIImage imageNamed:_alertArr[indexPath.row][@"image"]];
    cell.alertTitleLabel.text = _alertArr[indexPath.row][@"title"];
    cell.alertContentLabel.text = _alertArr[indexPath.row][@"comment"];
    cell.alertTimeLabel.text = _alertArr[indexPath.row][@"time"];
    
    return cell;
}


- (void)setData{
    _alertArr = [[NSMutableArray alloc] init];
    
    NSDictionary *tableDic1 = [[NSDictionary alloc] init];
    NSDictionary *tableDic2 = [[NSDictionary alloc] init];
    NSDictionary *tableDic3 = [[NSDictionary alloc] init];
    
    tableDic1 = @{
                  @"image":@"icon_infor_tran",
                  @"title":@"训练提醒",
                  @"comment":@"还有五分钟就要进行“按摩护眼睛”训练了",
                  @"time":@"10:25",
                  };
    tableDic2 = @{
                  @"image":@"icon_infor_break",
                  @"title":@"视疲劳提示",
                  @"comment":@"已经连续玩手机40分钟啦，休息一下吧",
                  @"time":@"昨天 21:18",
                  };
    tableDic3 = @{
                  @"image":@"icon_infor_tran",
                  @"title":@"训练提醒",
                  @"comment":@"还有五分钟就要进行“大空骨的救赎”训练了",
                  @"time":@"昨天 15:55",
                  };

    [_alertArr addObject:tableDic1];
    [_alertArr addObject:tableDic2];
    [_alertArr addObject:tableDic3];
    
}


@end
