//
//  BPHealthJViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/22.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPHealthJViewController.h"
#import "CBChartView.h"


@interface BPHealthJViewController (){

        BPNavView *navBarView;
}
@property (nonatomic,strong)CBChartView *chatView;
@end

@implementation BPHealthJViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =COLOR_BACKGRUNDE;

    
    [self CreateNav];
    
    
    [self creatUi];
    
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
-(void)creatUi{
    CBChartView *chartView = [CBChartView charView];
    chartView.frame = CGRectMake(0, NH(navBarView), SCREENWIDTH, 250);
  [self.view addSubview:chartView];
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableArray *arr1 =[NSMutableArray new];
    

    chartView.xValues = @[@"2",@"4",@"6",@"8",@"10",@"12",@"14",@"16",@"18",@"20",@"22",@"24"];
    chartView.yValues = @[@"35",@"8",@"10",@"41",@"5",@"10"];
    chartView.chartColor = [UIColor greenColor];
    self.chatView = chartView;
}

@end
