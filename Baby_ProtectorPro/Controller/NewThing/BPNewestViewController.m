//
//  BPNewestViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/12.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPNewestViewController.h"

#import "BPNewsCell.h"
#import "MryScrollPageVC.h"



@interface BPNewestViewController ()<UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource>{
            BPNavView *navBarView;
    NSMutableArray *    _knowledges;
      NSMutableArray *    _informations;
      NSMutableArray *    _policys;
    }
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)UIScrollView *scroll ;
@property (nonatomic,strong)UITableView *one;
@property (nonatomic,strong)UITableView *two;
@property (nonatomic,strong)UITableView *three;
@property (nonatomic,strong)UITableView *four;
@property (nonatomic,strong)UITableView *five;
@property (nonatomic,strong)UITableView *seven;
@property (nonatomic,strong)UITableView *eight;
@property (nonatomic,strong)UITableView *six;
@property (nonatomic,strong)UITableView *night;
@end

@implementation BPNewestViewController


- (void)viewDidLoad {

        self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新鲜事";
    
    [self CreateNav];
    [self creatHead];
//    [self creatHeadScroll];
    
 

    [super viewDidLoad];
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    //    [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"新鲜事";
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    navBarView.ToplineView.backgroundColor = [UIColor colorwithHexString:@"979797"];
    navBarView.rightBtn.hidden = YES;
    [self.view addSubview:navBarView];
}
-(void)creatHead{
    //设置数据源
    self.menuArray = [NSMutableArray arrayWithArray: @[@"推荐",@"运动健将",@"母婴健康",@"时尚居家",@"宝宝",@"故事",@"阅读",@"汽车"]];
    //设置控件位置
    self.menuframe = CGRectMake(0, NH(navBarView), SCREENWIDTH, 30);
    
    self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), SCREENWIDTH, SCREENHEIGHT - CGRectGetMaxY(self.menuframe)-navBarView.height);
    
    self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
    for (NSString *title in self.menuArray) {
        MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.menuframe), SCREENWIDTH, SCREENHEIGHT-64-30) style:UITableViewStylePlain];

        table.title = title;
        [self.tableArray addObject:table];
             [table registerNib:[UINib nibWithNibName:@"BPNewsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    

}


@end
