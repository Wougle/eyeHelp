//
//  MineHeaderViews.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/25.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *baseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftEyeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightEyeLabel;

@end
