//
//  SettingTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/26.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UISwitch *baseSwitch;

@end
