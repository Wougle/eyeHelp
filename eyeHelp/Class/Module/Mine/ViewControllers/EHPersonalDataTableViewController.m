//
//  EHPersonalDataTableViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/26.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHPersonalDataTableViewController.h"
#import "PersonalDataTableViewCell.h"
#import "DPImagePickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ModifyViewController.h"

static NSString *const kPersonalDataTableViewCell = @"kPersonalDataTableViewCell";
@interface EHPersonalDataTableViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,DPImagePickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSArray *iconArr;
    NSArray *titleArr;
}
@property (strong, nonatomic)  DPImagePickerVC * Viewasd;
@end

@implementation EHPersonalDataTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    iconArr = @[@"头像",@"昵称",@"手机号",@"修改密码",@"视力情况"];
    titleArr = @[@"head_small",@"飞翔的小飞侠",@"13911102333",@"",@"左眼：4.4  右眼：4.7"];
    
    [self prepareView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
}

-(void)prepareView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor = Rgb2UIColor(243, 243, 243, 1.0);
    self.tableView.tableFooterView =view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonalDataTableViewCell];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonalDataTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.headImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.headImageView.hidden = NO;
        cell.detailLabel.hidden = YES;
        cell.headImageView.image = [UIImage imageNamed:titleArr[indexPath.row]];
    }
    else{
        cell.detailLabel.text = titleArr[indexPath.row];
    }
    cell.titleTextLabel.text = iconArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self camera];
    }
    else if (indexPath.row == 1){
        ModifyViewController *vc = [[ModifyViewController alloc] init];
        vc.titleNameStr = @"修改昵称";
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2){
        ModifyViewController *vc = [[ModifyViewController alloc] init];
        vc.titleNameStr = @"修改手机号";
        vc.type = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3){
        ModifyViewController *vc = [[ModifyViewController alloc] init];
        vc.titleNameStr = @"修改密码";
        vc.type = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4){
        ModifyViewController *vc = [[ModifyViewController alloc] init];
        vc.titleNameStr = @"修改视力";
        vc.type = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = BG_COLOR;
    return  view;
}

#pragma mark ButtonActiob

- (void)camera{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
#if TARGET_IPHONE_SIMULATOR
        //模拟器
        UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请真机测试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerView show];
#elif TARGET_OS_IPHONE
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:([UIColor colorWithRed:231.0/255.0 green:56.0/255.0 blue:32.0/255.0 alpha:1.0]),NSForegroundColorAttributeName, nil];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
#endif
        
        
    }];
    UIAlertAction *confirm2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DPImagePickerVC *vc = [[DPImagePickerVC alloc]init];
        vc.delegate = self;
        vc.isDouble = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:confirm];
    [alertVc addAction:confirm2];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获得编辑过的图片
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    
    CGSize size = CGSizeMake(200, 200);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    //[_iconImageView setImage: scaledImage];
    
    //
    //    NSData *data = UIImageJPEGRepresentation(scaledImage, 1.0f);
    //    NSString *headImageBase64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //isImageChange = 1;
}

#pragma mark -- DPImagePickerDelegate
- (void)getCutImage:(UIImage *)image{
    [self.navigationController popViewControllerAnimated:YES];
    //self.imageV.image = image;
    
}

- (void)getImageArray:(NSMutableArray *)arrayImage{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"------------------%ld",arrayImage.count);
    if (arrayImage.count !=0) {
        //self.imageV.image = arrayImage[0];
    }
    
}


@end
