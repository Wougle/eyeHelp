//
//  EHCourseCollectionViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHCourseCollectionViewCell.h"

@implementation EHCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 20.f;
    self.layer.masksToBounds = YES;
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

@end
