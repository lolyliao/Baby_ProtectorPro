//
//  BPGuaerViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/12.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPGuaerViewController.h"
#import "BPGuaCell.h"
#import "BPDetailsViewController.h"

@interface BPGuaerViewController ()<UITableViewDelegate,UITableViewDataSource>{
        BPNavView *navBarView;
}
@property (nonatomic,strong)UITableView *myTableView;
@end

@implementation BPGuaerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = COLOR_BACKGRUNDE;
    self.title = @"呱儿百科";
    //自定义导航栏
    [self CreateNav];
    
    [self creatTab];
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
-(void)creatTab{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10 ,NH(navBarView), SCREENWIDTH-20, SCREENHEIGHT)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor =COLOR_BACKGRUNDE;
    [self.view addSubview:_myTableView];
    
      [_myTableView registerNib:[UINib nibWithNibName:@"BPGuaCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
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
    return 170;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      BPGuaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     if (!cell){
       cell.backgroundColor = [UIColor yellowColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.layer.cornerRadius = 8;
        cell.layer.masksToBounds = YES;
         cell.title.textColor = [UIColor colorwithHexString:@"#FF9933"];
         cell.name1.textColor = [UIColor colorwithHexString:@"#FF9933"];

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
@end
