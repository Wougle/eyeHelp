//
//  EHCourseCollectionViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHCourseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *affectLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end
