//
//  DPImagePickerVC.h
//  DPImagePicker
//
//  Created by 吴戈 on 2017/2/16.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPImagePickerVC;

@protocol DPImagePickerDelegate <NSObject>

@optional
- (void)getCutImage:(UIImage *)image;
//传出的是NSdata数组
- (void)getImageArray:(NSMutableArray *)arrayImage;

@end

@interface DPImagePickerVC : UIViewController

@property (nonatomic, assign)id<DPImagePickerDelegate>delegate;

//YES多选，NO 单选
@property (nonatomic,assign)BOOL isDouble;




@end
