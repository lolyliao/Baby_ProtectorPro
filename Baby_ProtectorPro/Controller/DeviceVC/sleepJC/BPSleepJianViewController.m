//
//  BPSleepJianViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/22.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPSleepJianViewController.h"

@interface BPSleepJianViewController (){
    
    BPNavView *navBarView;
}


@end

@implementation BPSleepJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR_BACKGRUNDE;
    
    
    [self CreateNav];

    
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    [navBarView.backBtn addTarget:self action:@selector(showBack) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"贝贝";
    navBarView.backBtn.hidden = NO;
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    [navBarView.rightBtn setImage:[UIImage imageNamed:@"cutover"] forState:UIControlStateNormal];
    navBarView.backgroundColor= [UIColor colorwithHexString:@"#7ECEF4"];
    [self.view addSubview:navBarView];
}
-(void)showBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
