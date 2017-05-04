//
//  BPMomViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/12.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMomViewController.h"
#import "BPChoiceView.h"
#import "BPTabbarViewController.h"

@interface BPMomViewController () <ClickMainDelegte>{
    //  背景图
    UIImageView *_bigImageView;
    
    //白色背景
    BPChoiceView *_bigWhiteView;
    
    //返回按钮
    UIButton *_backBtn;
    
    UIButton *_okBtn;
    //宝宝小名
    NSString *_name;
    NSString *_birthday;
    NSString *_sex;
    NSString *_grtoken;
    NSInteger count;
}

@end

@implementation BPMomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //实例化uiimageview
    [self creatImageView];
    
    
    //实例化白色背景
    [self creatWhiteView];
}

#pragma 实例化uiimageview
-(void)creatImageView{
    _bigImageView = [[UIImageView alloc]init];
    _bigImageView.userInteractionEnabled = YES;
    CGRect  rectImageB = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    _bigImageView.frame = rectImageB;
    UIImage *baidiImagB = [UIImage imageNamed:@"choice1.jpg"];
    _bigImageView.image = baidiImagB;
    [self.view addSubview:_bigImageView];
    
    //返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(25/2, 88/2, (33/2)*autoSizeScaleX ,(23/2)*autoSizeScaleY);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    _backBtn.titleLabel.textColor = COLOR_LIGHTCOLOR ;
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(ClicjBack) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 返回
-(void)ClicjBack{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 白色背景
-(void)creatWhiteView{
    _bigWhiteView = [[BPChoiceView alloc]initWithFrameWithMom:CGRectMake(20, 100, SCREENWIDTH-40, (934/2))];
    if(DEVICEHEIGHT5){
        _bigWhiteView.height=  (934/2)*HEIGHT5BILI;
    }else{
        _bigWhiteView.height=  (934/2);
    }
    _bigWhiteView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    _bigWhiteView.layer.cornerRadius = 10;
    _bigWhiteView.layer.masksToBounds = YES;
    _bigWhiteView.delegate = self;
    [_bigImageView addSubview:_bigWhiteView];
        __weak __typeof(BPChoiceView) *add= _bigWhiteView;
    add.blockTX = ^(NSString *days) {
        
        _name = days;
    } ;
    add.blockTXs = ^(NSString *days) {
        _sex = days;
        
    }  ;
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _okBtn.frame = CGRectMake(70, 35/2, (130/2) ,(86/2));
    _okBtn.center = CGPointMake(SCREENWIDTH/2.0,_bigImageView.BottomY-(86/2));
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"OKmom"] forState:UIControlStateNormal];
    [_bigImageView addSubview:_okBtn];
     [_okBtn addTarget:self  action:@selector(SubmitWithData) forControlEvents:UIControlEventTouchUpInside];
    _bigWhiteView.block = ^(int tag) {
        if(tag == 0){
            
            
        }else if (tag == 1){
            
        }else if (tag == 2){
            
        }
    };
    
}-(void)ClickDate:(int)tag{
    CustomDatePickerView *pickView=[[CustomDatePickerView alloc] init];
    [pickView setCommitBlock:^(NSString *result) {
        if(tag == 304){
            [_bigWhiteView.monTXBtn setTitle:result forState:UIControlStateNormal];
            _birthday = result;
        }
        
    }];
    [self.view addSubview:pickView];
    [self.view endEditing:YES];
}
-(void)SubmitWithData{
    if(_sex.length <= 0){
    _sex = @"1";
    }
    if(_name.length <= 0 || _birthday.length <= 0 || _sex.length <= 0 ){
        [self.view makeToast:@"请填写完整" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    [self requestData];
}
-(void)viewWillAppear:(BOOL)animated{
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
}
#pragma mark 调用数据
-(void)requestData{
    
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"type",_name,@"name",_grtoken,@"gr_token",_birthday,@"birthday",_sex,@"sex",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPCHIOSE parameters:dicParam success:^(id responseObject) {
        
        NSLog(@"收到的数据 %@",responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([responseObject[@"errcode"]isEqual:@"1"]){
                [self.view makeToast:@"即将跳转首页" duration:1.0 position:CSToastPositionCenter];
                	[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(insertView) userInfo:nil repeats:NO];
                
            }else if([responseObject[ERRCODE]isEqual:@"0"]){
                NSLog(@"错误信息===%@",CODE0);
            }else if([responseObject[ERRCODE]isEqual:@"2"]){
                NSLog(@"错误信息===%@",CODE2);
            }else if([responseObject[ERRCODE]isEqual:@"3"]){
                NSLog(@"错误信息===%@",CODE3);
            }else if([responseObject[ERRCODE]isEqual:@"4"]){
                NSLog(@"错误信息===%@",CODE4);
            }else if([responseObject[ERRCODE]isEqual:@"5"]){
                NSLog(@"错误信息===%@",CODE5);
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
}
#pragma mark 跳转首页
- (void)insertView {
    BPTabbarViewController *tab = [[BPTabbarViewController alloc]init];
    [self.navigationController pushViewController:tab animated:YES];
}

@end
