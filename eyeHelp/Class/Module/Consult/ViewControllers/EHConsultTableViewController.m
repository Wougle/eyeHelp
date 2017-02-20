//
//  EHConsultTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHConsultTableViewController.h"
#import "EHConsultHeaderView.h"
#import "EHConsultTableViewCell.h"
#import "LeftMenuViewDemo.h"
#import "MenuView.h"
#import "MyCollectionViewCell.h"
#import "EHGraphicTextViewController.h"

static NSString *const kEHConsultHeaderView = @"kEHConsultHeaderView";
static NSString *const kEHConsultTableViewCell = @"kEHConsultTableViewCell";

@interface EHConsultTableViewController ()<UITableViewDelegate, UITableViewDataSource,HomeMenuViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 侧滑栏页面 */
@property (nonatomic ,strong)MenuView      *menu;
/** cell的数据 */
@property(nonatomic,strong)NSMutableArray *cellArr;
@property (strong, nonatomic) EHConsultHeaderView *consultHeaderView;

@property (nonatomic,strong) UIView *headerView;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation EHConsultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咨询";
    
    self.view.backgroundColor = BG_COLOR;
    
    [self setNavigation];//导航栏设置
    
    [self leftMenu];//侧滑
    
    [self prepareHomeTableViewHeader];
    
    [self setCollection];
    
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)prepareHomeTableViewHeader{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EHConsultHeaderView" owner:self options:nil];
    
    self.consultHeaderView = [nib objectAtIndex:0];
    
    self.consultHeaderView.frame = CGRectMake(0,0, SCREEN_WIDTH,225);
    
    [self.headerView addSubview:self.consultHeaderView];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EHConsultTableViewCell" bundle:nil] forCellReuseIdentifier:kEHConsultTableViewCell];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = NO;
}

- (void)setCollection{
    _collectionView = ({
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(75, 95);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width,95) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellID];
        [self.consultHeaderView addSubview:collectionView];
        collectionView;
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EHConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEHConsultTableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHConsultTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.headImageView.image = [UIImage imageNamed:_cellArr[indexPath.row][@"headImage"]];
    cell.doctorNameLabel.text = _cellArr[indexPath.row][@"name"];
    cell.doctorAddressLabel.text = _cellArr[indexPath.row][@"address"];
    cell.doctorMainLabel.text = _cellArr[indexPath.row][@"main"];
    cell.doctorTimeLabel.text = _cellArr[indexPath.row][@"time"];

    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionViewCellID forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    NSArray *arr = [NSArray arrayWithObjects:@"视疲劳",@"眼睛干涩",@"流泪",@"酸胀",@"屈光不正",@"",@"",@"",@"", nil];
    EHGraphicTextViewController *vc = [[EHGraphicTextViewController alloc] init];
    vc.type = EHConsult;
    vc.titleName = arr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(MyCollectionViewCell *)cell configureCellWithPostURL:[NSString stringWithFormat:@"consultCell%li",indexPath.row+1]];
}


- (void)setData{
    _cellArr = [[NSMutableArray alloc] init];
    
    NSDictionary *tableDic1 = [[NSDictionary alloc] init];
    NSDictionary *tableDic2 = [[NSDictionary alloc] init];
    NSDictionary *tableDic3 = [[NSDictionary alloc] init];
    NSDictionary *tableDic4 = [[NSDictionary alloc] init];
    NSDictionary *tableDic5 = [[NSDictionary alloc] init];
    NSDictionary *tableDic6 = [[NSDictionary alloc] init];
    
    tableDic1 = @{
                  @"headImage":@"pic_ask6",
                  @"name":@"张白二",
                  @"address":@"杭州第一眼科医院主任",
                  @"main":@"屈光不正 视疲劳",
                  @"time":@"33",
                  };
    tableDic2 = @{
                  @"headImage":@"pic_ask7",
                  @"name":@"李潇潇",
                  @"address":@"杭州第二眼科医院副主任",
                  @"main":@"屈光不正 视疲劳 假性近视",
                  @"time":@"29",
                  };
    tableDic3 = @{
                  @"headImage":@"pic_ask8",
                  @"name":@"百丽",
                  @"address":@"杭州第三眼科医院主任",
                  @"main":@"假性近视",
                  @"time":@"28",
                  };
    tableDic4 = @{
                  @"headImage":@"pic_ask6",
                  @"name":@"张白二",
                  @"address":@"杭州第一眼科医院主任",
                  @"main":@"屈光不正 视疲劳",
                  @"time":@"33",
                  };
    tableDic5 = @{
                  @"headImage":@"pic_ask7",
                  @"name":@"李潇潇",
                  @"address":@"杭州第二眼科医院副主任",
                  @"main":@"屈光不正 视疲劳 假性近视",
                  @"time":@"29",
                  };
    tableDic6 = @{
                  @"headImage":@"pic_ask8",
                  @"name":@"百丽",
                  @"address":@"杭州第三眼科医院主任",
                  @"main":@"假性近视",
                  @"time":@"28",
                  };

    
    [_cellArr addObject:tableDic1];
    [_cellArr addObject:tableDic2];
    [_cellArr addObject:tableDic3];
    [_cellArr addObject:tableDic4];
    [_cellArr addObject:tableDic5];
    [_cellArr addObject:tableDic6];
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
