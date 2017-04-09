//
//  TopMenuSelectViewController.m
//  TopMenuSelect
//
//  Created by ecar on 16/3/15.
//  Copyright © 2016年 zhangqian. All rights reserved.
//

#import "EHCollectionViewController.h"

#import "ECollectionViewCell.h"
#import "EHCourseCollectionViewCell.h"
#import "EHCourseCollectionViewFlowLayout.h"
#import "EHGraphicTextViewController.h"
#import "EHVideoViewController.h"
#import "QALeadViewController.h"
#define MENU_BUTTON_WIDTH ViewWidth/2
#define ViewWidth [[UIScreen mainScreen] bounds].size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height

static NSString *const kECollectionViewCell = @"kECollectionViewCell";

@interface EHCollectionViewController () <UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>

/** 手把手页面 */
@property (nonatomic ,strong)UIView      *courseView;
@property (nonatomic ,strong)UIView      *scienceView;
@property (nonatomic, strong) UICollectionView *collection1View;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cards;

/** 当前页面模式 */
@property (nonatomic, assign)EHCollectionType state;
/** 图文的数据 */
@property(nonatomic,strong)NSMutableArray *graphyArr;
/** 视频的数据 */
@property(nonatomic,strong)NSMutableArray *videoArr;
/** 手把手的数据 */
@property(nonatomic,strong)NSMutableArray *courseArr;
@end

@implementation EHCollectionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"我的收藏";
    self.view.backgroundColor = BG_COLOR;
    _tableViewArray = [[NSMutableArray alloc]init];
    [self createMenu];
    self.state = 0;
    //[self refreshTableView:0];
}

- (void)createMenu {
    _menuArray = @[@"教程",@"科普"];
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
    //[self refreshTableView:(int)sender.tag];
}

- (void)addTableViewToScrollView:(UIScrollView *)scrollView count:(NSUInteger)pageCount frame:(CGRect)frame {
    for (int i = 0; i < pageCount; i++) {
        if (i == 0) {
            _courseView= [[UIView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
            _courseView.tag = i;
            self.state = i;
            [_tableViewArray addObject:_courseView];
            [scrollView addSubview:_courseView];
            _courseView.backgroundColor = BG_COLOR;
            [_courseView addSubview:self.collection1View];
            self.collectionView.tag = i;
            [_collectionView reloadData];
        }
        else{
            _scienceView= [[UIView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
            _scienceView.tag = i;
            self.state = i;
            [_tableViewArray addObject:_scienceView];
            [scrollView addSubview:_scienceView];
            _scienceView.backgroundColor = BG_COLOR;
            [_scienceView addSubview:self.collectionView];
            self.collectionView.tag = i;
            [_collectionView reloadData];
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        return _courseArr.count;
    }
    return _graphyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kECollectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[ECollectionViewCell alloc] init];
    }
    
    if (collectionView.tag == 1) {
        cell.iconImaView.hidden = YES;
        cell.imaView.image = [UIImage imageNamed:_courseArr[indexPath.row][@"detailImage"]];
        cell.titLabel.text = _courseArr[indexPath.row][@"titleName"];
    }
    else{
        cell.imaView.image = [UIImage imageNamed:_graphyArr[indexPath.row][@"detailImage"]];
        cell.titLabel.text = _graphyArr[indexPath.row][@"titleName"];
        cell.iconImaView.image = [UIImage imageNamed:_graphyArr[indexPath.row][@"iconIma"]];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2-16, 125);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 12.5, 0, 12.5);
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中---%ld", indexPath.row);
}


#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
            collect.dataSource = self;
            collect.delegate   = self;
            collect.backgroundColor = [UIColor clearColor];
            collect.showsHorizontalScrollIndicator = NO;
            [collect registerNib:[UINib nibWithNibName:@"ECollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kECollectionViewCell];
            collect;
        });
    }
    return _collectionView;
}

- (UICollectionView *)collection1View {
    if (!_collection1View) {
        _collection1View = ({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
            collect.dataSource = self;
            collect.delegate   = self;
            collect.backgroundColor = [UIColor clearColor];
            collect.showsHorizontalScrollIndicator = NO;
            [collect registerNib:[UINib nibWithNibName:@"ECollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kECollectionViewCell];
            collect;
        });
    }
    return _collection1View;
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
            //[self refreshTableView:i];
        }
    }
}

- (void)setData{
    _graphyArr = [[NSMutableArray alloc] init];
    _courseArr = [[NSMutableArray alloc] init];
    NSDictionary *tableDic1 = [[NSDictionary alloc] init];
    NSDictionary *tableDic2 = [[NSDictionary alloc] init];
    NSDictionary *tableDic3 = [[NSDictionary alloc] init];

    
    tableDic1 = @{
                @"detailImage":@"pic_sear1",
                @"titleName":@"大骨空的救赎",
                };
    tableDic2 = @{
                  @"detailImage":@"pic_sear2",
                  @"titleName":@"柔刮眼疾",
                  };
    tableDic3 = @{
                  @"detailImage":@"pic_sear3",
                  @"titleName":@"按摩护眼睛",
                  };
    
    [_graphyArr addObject:tableDic1];
    [_graphyArr addObject:tableDic2];
    [_graphyArr addObject:tableDic3];

    
    tableDic1 = @{
                  @"detailImage":@"pic_sear4",
                  @"titleName":@"究竟吃哪些水果对眼睛好？",
                  @"iconIma":@"icon_txt",
                  };
    tableDic2 = @{
                  @"detailImage":@"pic_sear5",
                  @"titleName":@"眼药水并非是根治你眼部不适症状的良药",
                  @"iconIma":@"icon_dv",
                  };
    tableDic3 = @{
                  @"detailImage":@"pic_sear6",
                  @"titleName":@"每天做眼保健操非常有必要",
                  @"iconIma":@"icon_hand",
                  };

    
    [_courseArr addObject:tableDic1];
    [_courseArr addObject:tableDic2];
    [_courseArr addObject:tableDic3];

}



#pragma mark --ButtonClick

@end
