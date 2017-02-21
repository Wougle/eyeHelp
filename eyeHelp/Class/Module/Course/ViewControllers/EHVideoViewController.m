//
//  EHVideoViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/21.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface EHVideoViewController (){
    HcdCacheVideoPlayer *play;//视频播放
    UIButton *playBtn;
}
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;


@end

@implementation EHVideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = NO;
    
    [play pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频详情";
    [self setVideoPlay];
    [self setButtonAction];
    [self setText];
    // Do any additional setup after loading the view from its nib.
}

- (void)setText{
    self.titleNameLabel.text = @"按摩强眼肌";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"       1. 按揉时要用力，感觉力量有穿透性，不可\n过快；2. 按揉时要闭目眼神，体会按揉的感觉。\n感觉按揉时穴位发胀，按后眼睛看东西清楚多\n了，有眼前一亮的感觉，眼睛也湿润了。适用于\n久看屏幕，阅读姿势不好，熬夜，眼痒以及屈光\n不正。";
    self.fromLabel.text = @"       方法出处：《自我调养巧治病》";
}

#pragma mark  视频加载
- (void)setVideoPlay{
    play = [HcdCacheVideoPlayer sharedInstance];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.videoView addSubview:view];
    
    [play playWithUrl:[NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"] showView:view andSuperView:self.videoView withCache:YES];
    
    [play toolViewHidden];//隐藏工具栏
    
    
}

- (void)setButtonAction{
    //添加控制按钮
    playBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, self.baseView.frame.size.height - 30 - 50, 50, 50)];
    [playBtn setImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(playControl) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:playBtn];
    
    [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)playControl{
    
    if (!playBtn.isSelected) {
        playBtn.selected = YES;
        [play pause];
    }
    else{
        playBtn.selected = NO;
        [play resume];
    }
}

- (void)likeBtnAction{
    if (_likeBtn.isSelected) {
        [self.likeBtn setSelected:NO];
    }
    else{
        [self.likeBtn setSelected:YES];
    }
}

@end
