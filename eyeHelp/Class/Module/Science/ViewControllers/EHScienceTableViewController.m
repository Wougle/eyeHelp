//
//  EHScienceTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHScienceTableViewController.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "EHScienceTableViewCell.h"
#import "EHGraphicTextViewController.h"
static NSString *const kEHSciencTableViewCell = @"kEHSciencTableViewCell";
@interface EHScienceTableViewController ()<UITableViewDataSource,UITableViewDelegate,HomeMenuViewDelegate>
/** 侧滑栏页面 */
@property (nonatomic ,strong)MenuView      *menu;
/** 科普的数据 */
@property(nonatomic,strong)NSMutableArray *scienceArr;
@end

@implementation EHScienceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"科普";
    [self setTableView];
    [self setNavigation];//导航栏设置
    [self leftMenu];//侧滑
    [self setData];//数据
}

- (void)setTableView{
    self.view.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = NO;
}

- (void)setNavigation{
    UIButton *planBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 34.f, 34.f)];
    [planBtn setImage:[UIImage imageNamed:@"icon_plan"] forState:UIControlStateNormal];
    [planBtn addTarget:self action:@selector(planBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:planBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 34.f, 34.f)];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _scienceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 215;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EHScienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEHSciencTableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHScienceTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailImageView.image = [UIImage imageNamed:_scienceArr[indexPath.row][@"detailImage"]];
    cell.titleNameLabel.text = _scienceArr[indexPath.row][@"titleName"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中---%ld", indexPath.row);
    EHGraphicTextViewController *vc = [[EHGraphicTextViewController alloc] init];
    vc.type = EHScience;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)setData{
    _scienceArr = [[NSMutableArray alloc] init];

    NSDictionary *tableDic1 = [[NSDictionary alloc] init];
    NSDictionary *tableDic2 = [[NSDictionary alloc] init];
    NSDictionary *tableDic3 = [[NSDictionary alloc] init];
    NSDictionary *tableDic4 = [[NSDictionary alloc] init];
    NSDictionary *tableDic5 = [[NSDictionary alloc] init];
    NSDictionary *tableDic6 = [[NSDictionary alloc] init];
    
    tableDic1 = @{
                  @"detailImage":@"pic_sear4",
                  @"titleName":@"究竟吃哪些水果对眼睛好？",
                  @"isLike":@"0",
                  };
    tableDic2 = @{
                  @"detailImage":@"pic_sear5",
                  @"titleName":@"眼药水并非是根治你眼部不适症状的良药",
                  @"isLike":@"0",
                  };
    tableDic3 = @{
                  @"detailImage":@"pic_sear6",
                  @"titleName":@"每天做眼保健操非常有必要",
                  @"isLike":@"0",
                  };
    tableDic4 = @{
                  @"detailImage":@"pic_sear4",
                  @"titleName":@"究竟吃哪些水果对眼睛好？",
                  @"isLike":@"0",
                  };
    tableDic5 = @{
                  @"detailImage":@"pic_sear5",
                  @"titleName":@"眼药水并非是根治你眼部不适症状的良药",
                  @"isLike":@"0",
                  };
    tableDic6 = @{
                  @"detailImage":@"pic_sear6",
                  @"titleName":@"每天做眼保健操非常有必要",
                  @"isLike":@"0",
                  };
    
    [_scienceArr addObject:tableDic1];
    [_scienceArr addObject:tableDic2];
    [_scienceArr addObject:tableDic3];
    [_scienceArr addObject:tableDic4];
    [_scienceArr addObject:tableDic5];
    [_scienceArr addObject:tableDic6];
}

#pragma mark -- 侧滑
- (void)leftMenu{
    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.6, [[UIScreen mainScreen] bounds].size.height)];
    demo.customDelegate = self;
    
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    //    MenuView *menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    self.menu = menu;
}

-(void)LeftMenuViewClick:(NSInteger)tag{
    [self.menu hidenWithAnimation];
}

#pragma mark --ButtonClick
- (void)planBtn{
    [self.menu show];
}

- (void)searchBtn{
    
}

@end
