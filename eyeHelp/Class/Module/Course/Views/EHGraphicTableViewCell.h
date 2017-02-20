//
//  EHGraphicTableViewCell.h
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/17.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphicBtnCellDelegate <NSObject>
-(BOOL)LikeBtnCellDelegate:(NSIndexPath *)index;
@end

@interface EHGraphicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detailImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *playBtnImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *affectLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (nonatomic, strong)id<GraphicBtnCellDelegate> delegate;

@property (nonatomic, copy)NSIndexPath *index;

@end
