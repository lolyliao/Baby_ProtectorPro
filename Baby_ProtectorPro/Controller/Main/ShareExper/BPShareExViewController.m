//
//  BPShareExViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPShareExViewController.h"

@interface BPShareExViewController ()<UITextFieldDelegate,UITextViewDelegate>{
       BPNavView *navBarView;
    UITextField *_biaotiTX;
    JSTextView *_textview;
    NSString *_grtoken;
    
}

@end

@implementation BPShareExViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor =  [UIColor colorwithHexString:@"#ffcccc"];;

    [self CreateNav];
    
    [self creatView];
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
        [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"分享经验";
    navBarView.titleLab.textColor = [UIColor blackColor];
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    navBarView.ToplineView.backgroundColor = [UIColor colorwithHexString:@"979797"];
    navBarView.rightBtn.hidden = NO;
   navBarView.backBtn.hidden = NO;
    [navBarView.rightBtn setTitle:@"发表" forState:UIControlStateNormal];
    navBarView.backgroundColor = [UIColor whiteColor];
      [navBarView.rightBtn addTarget:self action:@selector(clickFabia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBarView];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(navBarView)+20, SCREENWIDTH, 200)];
       backView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:backView];
    
    _biaotiTX = [Unit createTextField:CGRectMake(10, 10, SCREENWIDTH-10, 30) withPlaceholder:@"取个好标题，让更多人浏览"];
    _biaotiTX.delegate = self;
    [backView addSubview:_biaotiTX];
    [_biaotiTX setValue:[UIColor colorwithHexString:@"#999999"]  forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_biaotiTX)+10, SCREENWIDTH, 0.5)];
    lineView.backgroundColor =[UIColor colorwithHexString:@"#666666"];
    lineView.alpha = 0.5;
    [backView addSubview:lineView];
    
    
    _textview = [[JSTextView alloc]initWithFrame:CGRectMake(10, NH(lineView)+10, SCREENWIDTH-10, 150)];
    _textview.font = [UIFont fontWithName:@"Arial" size:13];
    _textview.myPlaceholder  =@"说点什么呗，不少于10个字";
    _textview.myPlaceholderColor = [UIColor colorwithHexString:@"#999999"] ;
    _textview.delegate = self;
    [_textview setTextColor:[UIColor colorwithHexString:@"#333333"]];
    _textview.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [backView addSubview:_textview];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == _biaotiTX){
        _biaotiTX = textField;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _biaotiTX){
        _biaotiTX = textField;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView == _textview){
        textView =(JSTextView *) _textview;
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView == _textview){
        textView =(JSTextView *) _textview;
    }
}
-(void)clickFabia{
    [self.view endEditing:YES];
    if(_biaotiTX.text <= 0 && _textview.text <= 0){
        [self.view makeToast:@"请输入完整哦" duration:1 position:CSToastPositionCenter];
        return;
    }else{
        [self requestData];
    }
}
-(void)requestData{
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];

    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"type",_article,@"article",_grtoken,@"gr_token",_biaotiTX.text,@"title",_textview.text,@"word",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {
        
        if(![responseObject isKindOfClass:[NSNull class]]){
            NSInteger errcode = [responseObject[@"errcode"] integerValue];
            if(errcode == 1){
                [self.view makeToast:@"发表成功" duration:1 position:CSToastPositionCenter];
                   [self performSelector:@selector(backAction) withObject:nil afterDelay:2.0f];
            }else{
              [self.view makeToast:@"发表失败" duration:1 position:CSToastPositionCenter];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
 
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
       [self.view endEditing:YES];
}
@end
