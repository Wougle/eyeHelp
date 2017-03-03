//
//  AlertTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/3/3.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *alertTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *alertContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertTimeLabel;

@end
