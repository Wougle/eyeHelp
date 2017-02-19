//
//  EHConsultTableViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHConsultTableViewCell.h"

@implementation EHConsultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImageView.layer.cornerRadius = 45.0f;
    _headImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
