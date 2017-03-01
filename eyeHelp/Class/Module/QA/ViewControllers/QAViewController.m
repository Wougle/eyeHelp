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

@interface QAViewController ()<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate>{
    int count;
}

/** 图文的数据 */
@property(nonatomic,strong)NSArray *qustArr1;
/** 视频的数据 */
@property(nonatomic,strong)NSArray *qustArr2;

@end

@implementation QAViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton =YES;
    [self setData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton =NO;
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
        _menuScrollView.hidden = YES;
    }
    [_menuScrollView setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * _menuArray.count, _menuScrollView.frame.size.height)];
    _menuScrollView.backgroundColor = BG_COLOR;
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
        tableView.backgroundColor = BG_COLOR;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

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
    count ++;
    if (tableView.tag == 2000 || tableView.tag == 2001) {
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        QATableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.checkBtn.isSelected) {
            [cell.checkBtn setSelected:NO];
        }
        else{
            [cell.checkBtn setSelected:YES];
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 2000 || tableView.tag == 2001) {
        return 60.0f;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (tableView.tag == 2000 || tableView.tag == 2001) {
        return 200.0f;
    }
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        view.backgroundColor = BG_COLOR;
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 60)];
        subView.backgroundColor = [UIColor whiteColor];
        [view addSubview:subView];
        
        //设置圆角
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
        
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
        
        maskLayer.frame = subView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        subView.layer.mask = maskLayer;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, SCREEN_WIDTH-30, 20)];
        nameLabel.font = [UIFont systemFontOfSize:16.0f];
        nameLabel.textColor = THEME_COLOR;
        if (tableView.tag == 2000) {
            nameLabel.text = @"你是否有以下生活习惯";
        }
        else{
            nameLabel.text = @"你是否有如下现象";
        }
        [subView addSubview:nameLabel];
        
        return view;
    }
    return nil;
}

- (nullable UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        view.backgroundColor = BG_COLOR;
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 10)];
        subView.backgroundColor = [UIColor whiteColor];
        [view addSubview:subView];
        
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
        
        maskLayer.frame = subView.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        subView.layer.mask = maskLayer;
        
        if (tableView.tag == 2000) {
            UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 40)];
            nextBtn.backgroundColor = THEME_COLOR;
            nextBtn.layer.cornerRadius = 5.0f;
            nextBtn.layer.masksToBounds = YES;
            [nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
            [nextBtn setTintColor:[UIColor whiteColor]];
            [nextBtn addTarget:self action:@selector(next1) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:nextBtn];
        }
        else{
            UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 40)];
            nextBtn.backgroundColor = THEME_COLOR;
            nextBtn.layer.cornerRadius = 5.0f;
            nextBtn.layer.masksToBounds = YES;
            [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
            [nextBtn setTintColor:[UIColor whiteColor]];
            [nextBtn addTarget:self action:@selector(next2) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:nextBtn];

        }
        return view;
    }
    return nil;
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

- (void)next1{
    [_scrollView setContentOffset:CGPointMake(ViewWidth * 1, 0) animated:YES];
    float xx = ViewWidth * (1 - 1) * (MENU_BUTTON_WIDTH / ViewWidth) - MENU_BUTTON_WIDTH;
    [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, ViewWidth, _menuScrollView.frame.size.height) animated:YES];
    [self refreshTableView:(int)1];
}

- (void)next2{
    
    if (count == 0) {
        
    }
    else if(count <= 5 && count >= 1) {
        [UserDefaultsUtils saveValue:@"1" forKey:@"amArr"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(count >= 6 && count < 9){
        [UserDefaultsUtils saveValue:@"2" forKey:@"amArr"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(count >= 9 && count <= 12){
        [UserDefaultsUtils saveValue:@"3" forKey:@"amArr"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        [UserDefaultsUtils saveValue:@"4" forKey:@"amArr"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)setData{
    count = 0;
    _qustArr1 = @[@"每天面对屏幕超过4小时",@"阅读姿势不对（床上，车上）",@"经常熬夜",@"经常揉眼睛",@"每周超过5天戴隐形眼镜",@"常用眼药水",@"经常发生颈肩不适",@"屈光不正（近视，远视，花眼）",@"思虑过度或压力大"];
    _qustArr2 = @[@"过度用眼会流泪",@"看东西久了不想睁眼",@"常常觉得眼睛干涩",@"眼睛容易发痒",@"眼睛容易有血丝，而且难消除",@"经常眼球肿胀",@"最近视力有些下降",@"经常眼屎多",@"常常觉得眼睛有灼热感",@"比别人怕光",@"眼睛不舒服时伴有眉骨痛",@"经常觉得视野有漂浮物",@"经常迎风流泪",@"用眼后感觉事物模糊",@"常常觉得眼中有异物"];
}


@end
