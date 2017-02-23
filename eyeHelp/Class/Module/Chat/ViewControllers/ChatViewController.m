//
//  ChatViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/22.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "ChatViewController.h"
#import "messModel.h"
#import "modelFrame.h"
#import "CustomTableViewCell.h"
#import "DPImagePickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,DPImagePickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UITextField *inputMess;
@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)sendAction:(UIButton *)sender;
@property (nonatomic,strong)NSMutableArray *arrModelData;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (strong, nonatomic)  DPImagePickerVC * Viewasd;

@end
@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = NO;
}

-(NSMutableArray *)arrModelData{
    if (_arrModelData==nil) {
        _arrModelData=[NSMutableArray array];
    }
    return _arrModelData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.docName;
    [self someSet];
    [self messModelArr];
    // 监听键盘出现的出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 一些UI设置
-(void)someSet{
    self.inputMess.delegate=self;//设置UITextField的代理
    self.inputMess.returnKeyType=UIReturnKeySend;//更改返回键的文字 (或者在sroryBoard中的,选中UITextField,对return key更改)
    self.inputMess.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [self.view setBackgroundColor:BG_COLOR];
    self.customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bgView setBackgroundColor:BG_COLOR];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    [self.customTableView setBackgroundView:bgView];
    [self.customTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.customTableView setShowsVerticalScrollIndicator:NO];
    
    self.sendBtn.layer.cornerRadius = 3.0f;
    self.sendBtn.layer.masksToBounds = YES;
    
    [self.cameraBtn addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 得到Cell上面的Frame的模型
-(void)messModelArr{
    NSString *strPath=[[NSBundle mainBundle]pathForResource:@"dataPlist.plist" ofType:nil];//得到Plist文件里面的数据
    NSArray *arrData=[NSArray arrayWithContentsOfFile:strPath];
    for (NSDictionary *dicData in arrData) {
        messModel *model=[[messModel alloc]initWithModel:dicData]; //将数据转为模型
        
        BOOL isEquel;
        if(self.arrModelData){
            isEquel=[self timeIsEqual:model.time];//判断上一个模型数据里面的时间是否和现在的时间相等
        }
        modelFrame *frameModel=[[modelFrame alloc]initWithFrameModel:model timeIsEqual:isEquel];//将模型里面的数据转为Frame,并且判断时间是否相等
        [self.arrModelData addObject:frameModel];//添加Frame的模型到数组里面
    }
}
#pragma mark  -TableView的DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.arrModelData.count);
    return self.arrModelData.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    modelFrame *frameModel=self.arrModelData[indexPath.row];
    return frameModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId=@"cellId";
    CustomTableViewCell *customCell=[tableView dequeueReusableCellWithIdentifier:strId];
    if (customCell==nil) {
        customCell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    [customCell setBackgroundColor:BG_COLOR];
    customCell.selectionStyle=UITableViewCellSelectionStyleNone;
    customCell.frameModel=self.arrModelData[indexPath.row];
//    if (self.arrModelData[indexPath.row][@"person"] == 0) {
//        customCell.headImageView.image = [UIImage imageNamed:self.docImage];
//    }
    return customCell;
}

#pragma mark 键盘将要出现
-(void)keyboardWillShow:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 键盘消失完毕
-(void)keyboardWillHide:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 处理键盘的位置
-(void)dealKeyboardFrame:(NSNotification *)changeMess{
    NSDictionary *dicMess=changeMess.userInfo;//键盘改变的所有信息
    CGFloat changeTime=[dicMess[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];//通过userInfo 这个字典得到对得到相应的信息//0.25秒后消失键盘
    CGFloat keyboardMoveY=[dicMess[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;//键盘Y值的改变(字典里面的键UIKeyboardFrameEndUserInfoKey对应的值-屏幕自己的高度)
    NSLog(@"%f",keyboardMoveY);
    [UIView animateWithDuration:changeTime animations:^{ //0.25秒之后改变tableView和bgView的Y轴
        self.customTableView.transform=CGAffineTransformMakeTranslation(0, 0);
        self.bgView.transform=CGAffineTransformMakeTranslation(0, 0);
        
    }];
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];//将tableView的行滚到最下面的一行
}
#pragma mark 滚动TableView去除键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputMess resignFirstResponder];
}
#pragma mark TextField的Delegate send后的操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField{  //
    [self sendMess:textField.text]; //发送信息
    return YES;
}
- (IBAction)sendAction:(UIButton *)sender {
    [self sendMess:self.inputMess.text]; //发送信息
}
#pragma mark 发送消息,刷新数据
-(void)sendMess:(NSString *)messValues{
    //添加一个数据模型(并且刷新表)
    //获取当前的时间
    NSDate *nowdate=[NSDate date];
    NSDateFormatter *forMatter=[[NSDateFormatter alloc]init];
    forMatter.dateFormat=@"HH:mm"; //小时和分钟
    NSString *nowTime=[forMatter stringFromDate:nowdate];
    
    NSMutableDictionary *dicValues=[NSMutableDictionary dictionary];
    dicValues[@"imageName"]=@"head_user";
    dicValues[@"desc"]=messValues;
    dicValues[@"time"]=nowTime; //当前的时间
    dicValues[@"person"]=[NSNumber numberWithBool:1]; //转为Bool类型
    messModel *mess=[[messModel alloc]initWithModel:dicValues];
    modelFrame *frameModel=[modelFrame modelFrame:mess timeIsEqual:[self timeIsEqual:nowTime]]; //判断前后时候是否一致
    [self.arrModelData addObject:frameModel];
    [self.customTableView reloadData];
    
    self.inputMess.text=nil;
    
    //自动回复就是再次添加一个frame模型
    NSArray *arrayAutoData=@[@"蒸桑拿蒸馒头不争名利，弹吉它弹棉花不谈感情",@"女人因为成熟而沧桑，男人因为沧桑而成熟",@"男人善于花言巧语，女人喜欢花前月下",@"笨男人要结婚，笨女人要减肥",@"爱与恨都是寂寞的空气,哭与笑表达同样的意义",@"男人的痛苦从结婚开始，女人的痛苦从认识男人开始",@"女人喜欢的男人越成熟越好，男人喜欢的女孩越单纯越好。",@"做男人无能会使女人寄希望于未来，做女人失败会使男人寄思念于过去",@"我很优秀的，一个优秀的男人，不需要华丽的外表，不需要有渊博的知识，不需要有沉重的钱袋",@"世间纷繁万般无奈，心头只求片刻安宁"];
    //添加自动回复的
    int num= arc4random() %(arrayAutoData.count); //获取数组中的随机数(数组的下标)
    
    
    //    NSLog(@"得到的时间是:%@",nowdate);
    NSMutableDictionary *dicAuto=[NSMutableDictionary dictionary];
    dicAuto[@"imageName"]=self.docImage;
    dicAuto[@"desc"]=[arrayAutoData objectAtIndex:num];
    dicAuto[@"time"]=nowTime;
    dicAuto[@"person"]=[NSNumber numberWithBool:0]; //转为Bool类型
    messModel *messAuto=[[messModel alloc]initWithModel:dicAuto];
    modelFrame *frameModelAuto=[modelFrame modelFrame:messAuto timeIsEqual:[self timeIsEqual:nowTime]];//判断前后时候是否一致
    [self.arrModelData addObject:frameModelAuto];
    [self.customTableView reloadData];
    
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark 判断前后时间是否一致
-(BOOL)timeIsEqual:(NSString *)comStrTime{
    modelFrame *frame=[self.arrModelData lastObject];
    NSString *strTime=frame.dataModel.time; //frame模型里面的NSString时间
    if ([strTime isEqualToString:comStrTime]) { //比较2个时间是否相等
        return YES;
    }
    return NO;
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
