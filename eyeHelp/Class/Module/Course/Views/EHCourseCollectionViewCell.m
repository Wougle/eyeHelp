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
    // Initialization code
}

@end
