//
//  BPAddBabyViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPAddBabyViewController.h"
#import "BPAddBabyView.h"

@interface BPAddBabyViewController ()<UITextFieldDelegate>{
    BPNavView *navBarView;
    BPAddBabyView *_addbaby;

    
}


@end

@implementation BPAddBabyViewController

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
    navBarView.rightBtn.hidden = YES;
    navBarView.backBtn.hidden = NO;
    navBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBarView];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView{
    
    _addbaby = [[BPAddBabyView alloc]initWithFrame:CGRectMake(20, NH(navBarView)+20, SCREENWIDTH-40, 200)];
    _addbaby.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:_addbaby];
    
    
             __weak __typeof(BPAddBabyView) *add= _addbaby;
    __weak typeof (self) weakself = self;
    _addbaby.block = ^{
        
        CustomDatePickerView *pickView=[[CustomDatePickerView alloc] init];
   
        [pickView setCommitBlock:^(NSString *result) {
        
            [add.dateBtn setTitle:result forState:UIControlStateNormal];

            
        }];
        [weakself.view addSubview:pickView];
        [weakself.view endEditing:YES];
    };

}
-(void)haha{
 
}
@end
