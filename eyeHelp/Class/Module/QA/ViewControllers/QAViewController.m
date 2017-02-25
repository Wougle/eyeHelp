//
//  TopMenuSelectViewController.m
//  TopMenuSelect
//
//  Created by ecar on 16/3/15.
//  Copyright © 2016年 zhangqian. All rights reserved.
//

#import "QAViewController.h"
#import "QATableViewCell.h"
#import "QALeadViewController.h"
#define MENU_BUTTON_WIDTH ViewWidth/2
#define ViewWidth [[UIScreen mainScreen] bounds].size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height

static NSString *const kQATableViewCell = @"kQATableViewCell";

@interface QAViewController () <
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate>

/** 图文的数据 */
@property(nonatomic,strong)NSArray *qustArr1;
/** 视频的数据 */
@property(nonatomic,strong)NSArray *qustArr2;

@end

@implementation QAViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"视疲劳测试";
    self.view.backgroundColor = BG_COLOR;
    _tableViewArray = [[NSMutableArray alloc]init];
    [self createMenu];
    [self refreshTableView:0];
}

- (void)createMenu {
    _menuArray = @[@"第一题",@"第二题"];
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
    [self refreshTableView:(int)sender.tag];
}

- (void)addTableViewToScrollView:(UIScrollView *)scrollView count:(NSUInteger)pageCount frame:(CGRect)frame {
    for (int i = 0; i < pageCount; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = NO;
        tableView.tag = 2000+i;
        [_tableViewArray addObject:tableView];
        [scrollView addSubview:tableView];
    }
}

- (void)refreshTableView:(int)index {
    _refreshTableView = _tableViewArray[index];
    CGRect frame = _refreshTableView.frame;
    frame.origin.x = ViewWidth * index;
    [_refreshTableView setFrame:frame];
    _menuTittle = _menuArray[index];

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
    if (tableView.tag == 2000) {
        return _qustArr1.count;
    }
    else if(tableView.tag == 2001){
        return _qustArr2.count;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kQATableViewCell];
    
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QATableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (tableView.tag == 2000) {
        cell.questLabel.text = _qustArr1[indexPath.row];
    }
    else if(tableView.tag == 2001){
        cell.questLabel.text = _qustArr2[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中---%ld", indexPath.row);

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

- (void)setData{
    _qustArr1 = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    _qustArr2 = @[@"1",@"1",@"2",@"1",@"1",@"1",@"1"];
}


@end
