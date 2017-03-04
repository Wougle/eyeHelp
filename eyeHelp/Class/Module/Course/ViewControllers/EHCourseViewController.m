//
//  TopMenuSelectViewController.m
//  TopMenuSelect
//
//  Created by ecar on 16/3/15.
//  Copyright © 2016年 zhangqian. All rights reserved.
//

#import "EHCourseViewController.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "EHGraphicTableViewCell.h"
#import "EHCourseCollectionViewCell.h"
#import "EHCourseCollectionViewFlowLayout.h"
#import "EHGraphicTextViewController.h"
#import "EHVideoViewController.h"
#import "QALeadViewController.h"
#define MENU_BUTTON_WIDTH ViewWidth/3
#define ViewWidth [[UIScreen mainScreen] bounds].size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height

static NSString *const kEHGraphicTableViewCell = @"kEHGraphicTableViewCell";
static NSString *const kEHCourseCollectionViewCell = @"kEHCourseCollectionViewCell";

@interface EHCourseViewController () <UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
HomeMenuViewDelegate>

/** 侧滑栏页面 */
@property (nonatomic ,strong)MenuView      *menu;
/** 手把手页面 */
@property (nonatomic ,strong)UIView      *courseView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cards;

/** 当前页面模式 */
@property (nonatomic, assign)EHCoureseType state;
/** 图文的数据 */
@property(nonatomic,strong)NSMutableArray *graphyArr;
/** 视频的数据 */
@property(nonatomic,strong)NSMutableArray *videoArr;
/** 手把手的数据 */
@property(nonatomic,strong)NSMutableArray *courseArr;
@end

@implementation EHCourseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"教程";
    self.view.backgroundColor = BG_COLOR;
    _tableViewArray = [[NSMutableArray alloc]init];
    [self createMenu];
    self.state = EHGraphyState;
    [self refreshTableView:0];
    [self setNavigation];//导航栏设置
    
}

- (void)createMenu {
    _menuArray = @[@"图文",@"视频",@"手把手"];
    for (int i = 0; i < _menuArray.count; i ++) {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        [menu setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, _menuScrollView.frame.size.height)];
        [menu setTitle:_menuArray[i] forState:UIControlStateNormal];
        [menu setTitleColor:THEME_COLOR forState:UIControlStateNormal];
        menu.titleLabel.font = [UIFont systemFontOfSize:14.0];
        menu.tag = i;
        [menu addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScrollView addSubview:menu];
    }
    [_menuScrollView setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * _menuArray.count, _menuScrollView.frame.size.height)];
    _menuScrollView.backgroundColor = [UIColor whiteColor];
    _menuBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _menuScrollView.frame.size.height - 2, MENU_BUTTON_WIDTH, 2)];
    [_menuBgView setBackgroundColor:THEME_COLOR];
    [_menuScrollView addSubview:_menuBgView];
    _scrollView.contentSize = CGSizeMake(ViewWidth * _menuArray.count, _scrollView.frame.size.height);
    _scrollView.tag = 1001;
    [self addTableViewToScrollView:_scrollView count:_menuArray.count frame:CGRectZero];
}

- (void)selectMenu:(UIButton *)sender {
    [_scrollView setContentOffset:CGPointMake(ViewWidth * sender.tag, 0) animated:YES];
    float xx = ViewWidth * (sender.tag - 1) * (MENU_BUTTON_WIDTH / ViewWidth) - MENU_BUTTON_WIDTH;
    [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, ViewWidth, _menuScrollView.frame.size.height) animated:YES];
    self.state = (int)sender.tag;
    [self refreshTableView:(int)sender.tag];
}

- (void)addTableViewToScrollView:(UIScrollView *)scrollView count:(NSUInteger)pageCount frame:(CGRect)frame {
    for (int i = 0; i < pageCount; i++) {
        if (i == 2) {
            _courseView= [[UIView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
            _courseView.tag = i;
            self.state = i;
            [_tableViewArray addObject:_courseView];
            [scrollView addSubview:_courseView];
            _courseView.backgroundColor = BG_COLOR;
            [_courseView addSubview:self.collectionView];
            self.collectionView.tag = 1002;
            [_collectionView reloadData];

        }
        else{
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = NO;
            tableView.tag = i;
            self.state = i;
            [_tableViewArray addObject:tableView];
            [scrollView addSubview:tableView];
        
        }
    }
}

- (void)refreshTableView:(int)index {
    _refreshTableView = _tableViewArray[index];
    CGRect frame = _refreshTableView.frame;
    frame.origin.x = ViewWidth * index;
    [_refreshTableView setFrame:frame];
    _menuTittle = _menuArray[index];
    self.state = index;
    //self.title = _menuTittle;
    if(index != 2){
        [_refreshTableView reloadData];
    }
    
}

- (void)changeView:(float)x {
    float xx = x * (MENU_BUTTON_WIDTH / ViewWidth);
    [_menuBgView setFrame:CGRectMake(xx, _menuBgView.frame.origin.y, _menuBgView.frame.size.width, _menuBgView.frame.size.height)];
}

#pragma mark - UITableViewDataSource和UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        return _graphyArr.count;
    }
    else if(tableView.tag == 1){
        return _videoArr.count;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EHGraphicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEHGraphicTableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHGraphicTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.playBtnImageVIew.hidden = YES;
    if (self.state == EHGraphyState) {
        cell.detailImageVIew.image = [UIImage imageNamed:_graphyArr[indexPath.row][@"detailImage"]];
        cell.titleNameLabel.text = _graphyArr[indexPath.row][@"titleName"];
        cell.timeLabel.text = _graphyArr[indexPath.row][@"time"];
        cell.affectLabel.text = _graphyArr[indexPath.row][@"affect"];
    }
    else{
        cell.playBtnImageVIew.hidden = NO;
        cell.detailImageVIew.image = [UIImage imageNamed:_videoArr[indexPath.row][@"detailImage"]];
        cell.titleNameLabel.text = _videoArr[indexPath.row][@"titleName"];
        cell.timeLabel.text = _videoArr[indexPath.row][@"time"];
        cell.affectLabel.text = _videoArr[indexPath.row][@"affect"];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中---%ld", indexPath.row);
    if (self.state == EHGraphyState) {
        EHGraphicTextViewController *vc = [[EHGraphicTextViewController alloc] init];
        vc.type = EHCource;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (self.state == EHVideoState) {
        EHVideoViewController *vc = [[EHVideoViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _courseArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EHCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEHCourseCollectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[EHCourseCollectionViewCell alloc] init];
    }
    cell.detailImageView.image = [UIImage imageNamed:_courseArr[indexPath.row][@"detailImage"]];
    cell.detailLabel.text = _courseArr[indexPath.row][@"content"];
    cell.titleNameLabel.text = _courseArr[indexPath.row][@"titleName"];
    cell.timeLabel.text = _courseArr[indexPath.row][@"time"];
    cell.affectLabel.text = _courseArr[indexPath.row][@"affect"];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中---%ld", indexPath.row);
}


#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:[[EHCourseCollectionViewFlowLayout alloc] init]];
            collect.dataSource = self;
            collect.delegate   = self;
            collect.backgroundColor = [UIColor clearColor];
            collect.showsHorizontalScrollIndicator = NO;
            [collect registerNib:[UINib nibWithNibName:@"EHCourseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kEHCourseCollectionViewCell];
            collect;
        });
    }
    return _collectionView;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 1001) {
        //只要滚动了就会触发
        if ([scrollView isKindOfClass:[UITableView class]]) {
            
        }
        else
        {
            [self changeView:scrollView.contentOffset.x];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 1001) {
        //减速停止了时执行，手触摸时执行执行
        if ([scrollView isKindOfClass:[UITableView class]]) {
            
        }
        else
        {
            float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / ViewWidth) - MENU_BUTTON_WIDTH;
            [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, ViewWidth, _menuScrollView.frame.size.height) animated:YES];
            int i = (scrollView.contentOffset.x / ViewWidth);
            [self refreshTableView:i];
        }
    }
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

- (void)setData{
    _graphyArr = [[NSMutableArray alloc] init];
    _videoArr = [[NSMutableArray alloc] init];
    _courseArr = [[NSMutableArray alloc] init];
    NSDictionary *tableDic1 = [[NSDictionary alloc] init];
    NSDictionary *tableDic2 = [[NSDictionary alloc] init];
    NSDictionary *tableDic3 = [[NSDictionary alloc] init];
    NSDictionary *tableDic4 = [[NSDictionary alloc] init];
    NSDictionary *tableDic5 = [[NSDictionary alloc] init];
    NSDictionary *tableDic6 = [[NSDictionary alloc] init];
    
    tableDic1 = @{
                @"detailImage":@"pic_sear1",
                @"titleName":@"大骨空的救赎",
                @"time":@"2分钟",
                @"affect":@"屈光不正",
                @"isLike":@"0",
                @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                };
    tableDic2 = @{
                  @"detailImage":@"pic_sear2",
                  @"titleName":@"按摩护眼睛",
                  @"time":@"3分钟",
                  @"affect":@"眼睛干涩",
                  @"isLike":@"0",
                  @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                  };
    tableDic3 = @{
                  @"detailImage":@"pic_sear3",
                  @"titleName":@"的",
                  @"time":@"4分钟",
                  @"affect":@"眼睛疲劳",
                  @"isLike":@"0",
                  @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                  };
    tableDic4 = @{
                  @"detailImage":@"pic_sear1",
                  @"titleName":@"大骨空的救赎",
                  @"time":@"2分钟",
                  @"affect":@"屈光不正",
                  @"isLike":@"0",
                  @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                  };
    tableDic5 = @{
                  @"detailImage":@"pic_sear2",
                  @"titleName":@"按摩护眼睛",
                  @"time":@"3分钟",
                  @"affect":@"眼睛干涩",
                  @"isLike":@"0",
                  @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                  };
    tableDic6 = @{
                  @"detailImage":@"pic_sear3",
                  @"titleName":@"的",
                  @"time":@"4分钟",
                  @"affect":@"眼睛疲劳",
                  @"isLike":@"0",
                  @"content":@"      通过对眼睛几个关键点的按摩，缓解眼睛 疲劳，增加泪液分泌，消除眼睛干涩，缓解眼 睛充血和胀痛。",
                  };
    
    [_graphyArr addObject:tableDic1];
    [_graphyArr addObject:tableDic2];
    [_graphyArr addObject:tableDic3];
    [_graphyArr addObject:tableDic4];
    [_graphyArr addObject:tableDic5];
    [_graphyArr addObject:tableDic6];
    
    [_videoArr addObject:tableDic1];
    [_videoArr addObject:tableDic2];
    [_videoArr addObject:tableDic3];
    [_videoArr addObject:tableDic4];
    [_videoArr addObject:tableDic5];
    [_videoArr addObject:tableDic6];
    
    [_courseArr addObject:tableDic1];
    [_courseArr addObject:tableDic2];
    [_courseArr addObject:tableDic3];
    [_courseArr addObject:tableDic4];
    [_courseArr addObject:tableDic5];
    [_courseArr addObject:tableDic6];
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
    QALeadViewController *vc = [[QALeadViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark --ButtonClick
- (void)planBtn{
    [self leftMenu];//侧滑
    [self.menu show];
}

- (void)searchBtn{
    LogViewController *vc = [[LogViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    vc.viewType = 1;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
