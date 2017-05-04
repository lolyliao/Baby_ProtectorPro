//
//  BPDetailsViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPDetailsViewController.h"

@interface BPDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BPNavView *navBarView;
}
@property (nonatomic,strong)UITableView *myTableView;

@end

@implementation BPDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = COLOR_BACKGRUNDE;
//    self.title = @"呱儿百科";
    //自定义导航栏
    [self CreateNav];
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    //    [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"育儿知识";
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    navBarView.ToplineView.backgroundColor = [UIColor colorwithHexString:@"979797"];
    navBarView.rightBtn.hidden = YES;
    [self.view addSubview:navBarView];
}
@end
