//
//  ECollectionViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/4/9.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *imaView;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImaView;

@end
