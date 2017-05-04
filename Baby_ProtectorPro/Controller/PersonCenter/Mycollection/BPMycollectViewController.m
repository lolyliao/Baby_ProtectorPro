//
//  BPMycollectViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/15.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMycollectViewController.h"
#import "BPMyCollectCell.h"

@interface BPMycollectViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BPNavView *navBarView;
}
@property (nonatomic,strong)UITableView *myTableView;
@end

@implementation BPMycollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";
    
    [self CreateNav];
    
    [self creatTab];

}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    //    [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text =@"我的收藏";
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    navBarView.ToplineView.backgroundColor = [UIColor colorwithHexString:@"979797"];
    navBarView.rightBtn.hidden = YES;
    navBarView.backBtn.hidden = NO;
        [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBarView];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  tab
-(void)creatTab{
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(navBarView), SCREENWIDTH, SCREENHEIGHT-navBarView.height)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor =COLOR_BACKGRUNDE;
        [self.view addSubview:_myTableView];
    
        [_myTableView registerNib:[UINib nibWithNibName:@"BPMyCollectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark -- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BPMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell){
        cell.backgroundColor = [UIColor yellowColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.layer.cornerRadius = 8;
        cell.layer.masksToBounds = YES;
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    head.backgroundColor = [UIColor clearColor];
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
@end
