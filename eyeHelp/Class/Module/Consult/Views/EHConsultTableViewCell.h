//
//  EHConsultTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHConsultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorMainLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorTimeLabel;

@end
