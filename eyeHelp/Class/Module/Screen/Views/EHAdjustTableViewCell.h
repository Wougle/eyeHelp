//
//  EHAdjustTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHAdjustTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISlider *lightSlider;
@property (weak, nonatomic) IBOutlet UISwitch *adjsutSwitch;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@end
