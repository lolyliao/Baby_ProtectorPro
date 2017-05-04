//
//  BPClassListViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPClassListViewController.h"
#import "BPArticleViewController.h"

@interface BPClassListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BPNavView *navBarView;
    NSString *_grtoken;
    SurePlaceholderView *placeholderView;
}
@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation BPClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = COLOR_BACKGRUNDE;
    _dataArr = [NSMutableArray array];
    
    [self requestData];
    
    //自定义导航栏
    [self CreateNav];
    
    [self creatTab];
}
#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    navBarView.titleLab.text = _titleName;
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
-(void)creatTab{
    if(![SCCatWaitingHUD sharedInstance].isAnimating){
        [[SCCatWaitingHUD sharedInstance] animateWithInteractionEnabled:YES];
    }else{
        [[SCCatWaitingHUD sharedInstance] stop];
    }
    
    CGRect rect = CGRectMake(0 ,NH(navBarView), SCREENWIDTH, SCREENHEIGHT);
    placeholderView = [[SurePlaceholderView alloc]initWithFrame:rect];
    placeholderView.hidden  = YES;
    [self.view addSubview:placeholderView];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(navBarView), SCREENWIDTH, SCREENHEIGHT)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.hidden =YES;
    _myTableView.tableFooterView = [[UIView alloc]init];
    _myTableView.backgroundColor =COLOR_BACKGRUNDE;
    [self.view addSubview:_myTableView];
    
}

-(void)requestData{

    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",_titleName,@"obj",_grtoken,@"gr_token",nil];
    //    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPCLASSURL parameters:dicParam success:^(id responseObject) {
        [_dataArr removeAllObjects];
        if(![responseObject isKindOfClass:[NSNull class]]){
            NSInteger errcode = [responseObject[@"errcode"]integerValue];
            if(errcode == 1){
                placeholderView.hidden = YES;
                _myTableView.hidden = NO;
                
                [_dataArr addObjectsFromArray:responseObject[@"data"]];
            }else{
                _myTableView.hidden = YES;
                 placeholderView.hidden = NO;
                [self makeDefaultPlaceholderView];//重新加载数据
            }
            [[SCCatWaitingHUD sharedInstance] stop];
            [_myTableView reloadData];
        }

    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
    [_myTableView reloadData];
}

- (void)makeDefaultPlaceholderView {
    __weak typeof(self) weakSelf = self;
    [placeholderView setReloadClickBlock:^{
        [weakSelf requestData];
    }];
}
#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataArr.count){
        return _dataArr.count;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(_dataArr.count){
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.textLabel.font = FONTFZLTHK12;
        cell.textLabel.textColor = COLOR_3333;
        cell.textLabel.text = [dic[@"title"] isKindOfClass:[NSNull class]] ? @"" : dic[@"title"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    BPArticleViewController *RPvc = [[BPArticleViewController alloc]init];
    RPvc.hidesBottomBarWhenPushed = YES;
    RPvc.article = dic[@"id"];
    RPvc.titleName = dic[@"title"];
    [self.navigationController pushViewController:RPvc animated:YES];
}
@end
