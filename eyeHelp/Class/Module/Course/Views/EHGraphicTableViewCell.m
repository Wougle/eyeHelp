//
//  EHGraphicTableViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHGraphicTableViewCell.h"

@implementation EHGraphicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _baseView.layer.cornerRadius = 20.0f;
    _baseView.layer.masksToBounds = YES;
    _playBtnImageVIew.hidden = YES;
    
    [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)likeBtnAction{
    if (_likeBtn.isSelected) {
        [self.likeBtn setSelected:NO];
    }
    else{
        [self.likeBtn setSelected:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
