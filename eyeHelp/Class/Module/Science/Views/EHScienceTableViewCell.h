//
//  EHScienceTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHScienceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@property (weak, nonatomic) IBOutlet UIView *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@end
