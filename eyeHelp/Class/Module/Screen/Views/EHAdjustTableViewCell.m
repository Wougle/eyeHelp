//
//  EHAdjustTableViewCell.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHAdjustTableViewCell.h"

@implementation EHAdjustTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _baseView.layer.cornerRadius = 7.0f;
    _baseView.layer.masksToBounds = YES;
    [_lightSlider trackRectForBounds:CGRectMake(0, 0, 5, 5)];
    _adjsutSwitch.onTintColor= THEME_COLOR;
    
    [_lightSlider addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, SCREEN_WIDTH-100, 15);
}

- (void)sliderChange{
    [[UIScreen mainScreen] setBrightness:_lightSlider.value];
}

@end
