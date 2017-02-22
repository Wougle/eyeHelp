//
//  CustomTableViewCell.h
//  QQ自动回复
//
//  Created by 吴戈 on 2017/2/19.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>
@class modelFrame;
@interface CustomTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)modelFrame *frameModel;
@end
