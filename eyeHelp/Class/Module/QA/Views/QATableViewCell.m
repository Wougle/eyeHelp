//
//  QATableViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "QATableViewCell.h"

@implementation QATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_checkBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)likeBtnAction{
    if (_checkBtn.isSelected) {
        [self.checkBtn setSelected:NO];
    }
    else{
        [self.checkBtn setSelected:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
