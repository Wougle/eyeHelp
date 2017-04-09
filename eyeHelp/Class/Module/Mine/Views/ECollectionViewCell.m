//
//  ECollectionViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/4/9.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "ECollectionViewCell.h"

@implementation ECollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _baseView.layer.cornerRadius = 10.0f;
    _baseView.layer.masksToBounds = YES;
    // Initialization code
}

@end
