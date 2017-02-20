//
//  EHScienceTableViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHScienceTableViewCell.h"

@implementation EHScienceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _baseView.layer.cornerRadius = 20.0f;
    _baseView.layer.masksToBounds = YES;
    [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
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
