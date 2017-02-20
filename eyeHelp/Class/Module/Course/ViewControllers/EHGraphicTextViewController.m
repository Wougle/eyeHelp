//
//  EHGraphicTextViewController.m
//  eyeHelp
//
//  Created by 吴戈 on 2017/2/20.
//  Copyright © 2017年 吴戈. All rights reserved.
//

#import "EHGraphicTextViewController.h"

@interface EHGraphicTextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EHGraphicTextViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UIView *sinaBar = [self.tabBarController.view viewWithTag:10086];
    sinaBar.hidden = NO;
    //    for (UIView *v in self.tabBarController) {
    //
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == EHCource) {
        self.title = @"图文详情";
        [self courseText];
    }
    else if(self.type == EHScience){
        self.title = @"科普详情";
        [self scienceText];
    }
    else if(self.type == EHConsult){
        self.title = self.titleName;
        [self consultText];
    }
    else{
        self.title = @"NULL";
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)courseText{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"pic_pic1"];
    attach.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [string appendAttributedString:attachString];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [string appendAttributedString:[[NSAttributedString alloc]
                                    initWithString:@"\n\n          大空骨的教程                                          时长：2分钟\n\n\n"]];
    
    // 设置@"大空骨的教程"为绿色
    [string addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(14, 6)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(14, 6)];
    // 设置@"时长：2分钟"为灰色
    [string addAttribute:NSForegroundColorAttributeName value:TEXT_COLOR_SECONDARY range:NSMakeRange(62, 6)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(62, 6)];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n                常常盯着闪烁的电脑屏幕，容易令眼睛疲劳，干涩，疼\n          痛，充血。这种情况下，最有效的方法，就是按压位于大拇\n          指节上的眼点穴一带，眼点穴又叫大骨空，和眼球表面眼膜\n          有着密切的关系。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
    attach2.image = [UIImage imageNamed:@"pic_pic2"];
    attach2.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    NSAttributedString *attachString2 = [NSAttributedString attributedStringWithAttachment:attach2];
    [string appendAttributedString:attachString2];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                   当某一只眼睛疼痛的时候，就重点按摩这一侧手上\n          的眼点穴。适用于用眼过度导致的眼睛胀痛。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach3 = [[NSTextAttachment alloc] init];
    attach3.image = [UIImage imageNamed:@"pic_pic3"];
    attach3.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    NSAttributedString *attachString3 = [NSAttributedString attributedStringWithAttachment:attach3];
    [string appendAttributedString:attachString3];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                  按揉左手的大骨空一带3分钟；以相同方法按揉 左手\n          的大骨空一带3分钟。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach4 = [[NSTextAttachment alloc] init];
    attach4.image = [UIImage imageNamed:@"pic_dv1"];
    attach4.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    NSAttributedString *attachString4 = [NSAttributedString attributedStringWithAttachment:attach4];
    [string appendAttributedString:attachString4];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                  适用于屈光不正，久看屏幕及熬夜。\n\n"]];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                                         方法出处：《缓解眼睛疲劳》——日本\n\n"]];
    [string addAttribute:NSForegroundColorAttributeName value:TEXT_COLOR_SECONDARY range:NSMakeRange(string.length-19, 17)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(string.length-19, 17)];
    
    self.textView.attributedText = string;
}

- (void)scienceText{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"pic_scitxt1"];
    attach.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [string appendAttributedString:attachString];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                        究竟吃哪些水果对眼睛好？\n\n\n"]];
    
    // 设置@"究竟吃哪些水果对眼睛好？"为绿色
    [string addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(28, 12)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(28, 12)];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n                上班族们几乎要天天面对电脑，这样不仅对面部有辐射，\n          而且最大的受害者还是眼睛，时刻看着电脑时间久了不仅眼\n          部疲劳而且还会视力下降，但我们可以选择吃一些果进行适\n          当的调节，尽量减少些但对眼睛的伤害。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
    attach2.image = [UIImage imageNamed:@"pic_scitxt2"];
    attach2.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString2 = [NSAttributedString attributedStringWithAttachment:attach2];
    [string appendAttributedString:attachString2];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       1.火龙果\n              火龙果中含有丰富的维生素E和花青素，具有抗 氧化、抗\n          自由基、抗衰老的作用还能提高对脑细胞变 性的预防。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach3 = [[NSTextAttachment alloc] init];
    attach3.image = [UIImage imageNamed:@"pic_scitxt2"];
    attach3.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString3 = [NSAttributedString attributedStringWithAttachment:attach3];
    [string appendAttributedString:attachString3];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       2.圣女果\n             圣女果所含有维生素A的含量在果蔬中属于佼佼 者，而且\n          圣女果还能增加皮肤的弹性，所以可以把它 当零食吃，\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach4 = [[NSTextAttachment alloc] init];
    attach4.image = [UIImage imageNamed:@"pic_scitxt2"];
    attach4.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString4 = [NSAttributedString attributedStringWithAttachment:attach4];
    [string appendAttributedString:attachString4];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       3.橘子\n             橘子里面所含的营养成分不仅对肝脏有解毒功能、 还能养\n          护眼睛、保护免疫系统。\n\n"]];
    
    
    self.textView.attributedText = string;
}


- (void)consultText{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"pic_asktxt1"];
    attach.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [string appendAttributedString:attachString];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n                        如何有效缓解视疲劳？\n\n\n"]];
    
    // 设置@"究竟吃哪些水果对眼睛好？"为绿色
    [string addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(28, 10)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(28, 10)];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n                视疲劳是目前眼科常见的一种疾病，患者的症状多种\n          多样，常见的有近距离工作不能持久，出现眼及眼眶周围\n          疼痛、视物模糊、眼睛干涩、流泪等，严重者头痛、恶心、\n          眩晕。它不是独立的疾病，而是由于各种原因引起的一组\n          疲劳综合征。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
    attach2.image = [UIImage imageNamed:@"pic_asktxt2"];
    attach2.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString2 = [NSAttributedString attributedStringWithAttachment:attach2];
    [string appendAttributedString:attachString2];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       1.注意光线\n\n                在微暗的灯光下阅读，不会伤害眼睛，但若光线未提供\n          足够的明暗对比，将使眼睛容易疲劳。使用能提供明暗对比\n          的柔和灯光（不刺眼的光线）。不要使用直接将光线反射入\n          眼睛的电灯。\n\n"]];

    // 创建图片图片附件
    NSTextAttachment *attach3 = [[NSTextAttachment alloc] init];
    attach3.image = [UIImage imageNamed:@"pic_asktxt3"];
    attach3.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString3 = [NSAttributedString attributedStringWithAttachment:attach3];
    [string appendAttributedString:attachString3];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       2.中断你的工作\n\n               如果连续使用电脑6到8小时，应每2-3小时休息 一次。\n          喝杯咖啡、上个厕所、或只是让眼睛离开电脑10到15分钟。\n\n"]];
    
    // 创建图片图片附件
    NSTextAttachment *attach4 = [[NSTextAttachment alloc] init];
    attach4.image = [UIImage imageNamed:@"pic_asktxt4"];
    attach4.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    NSAttributedString *attachString4 = [NSAttributedString attributedStringWithAttachment:attach4];
    [string appendAttributedString:attachString4];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n       3.闭眼休息\n\n               缓解眼睛疲劳的最佳方式是让眼睛休息。这比你想像的还\n          简单。你可以一边讲电话，一边闭着眼睛。 你若无需读什么\n          或写什么，那么大可以在聊天时闭上眼睛休息。 在讲电话时\n          练习此方法的人都说，眼睛的确舒服许多，而且有助于消除\n          眼睛疲劳。\n\n"]];
    
    
    self.textView.attributedText = string;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark view转换为image
- (UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

@end
