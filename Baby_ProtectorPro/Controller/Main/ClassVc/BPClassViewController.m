//
//  BPClassViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPClassViewController.h"
#import "BPClassCell.h"
#import "BPClassListViewController.h"
#import "UIImage+GIF.h"


@interface BPClassViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BPNavView *navBarView;
    NSString *_grtoken;
    UIView *loadView;

}
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)UIImageView *loadingImageView;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation BPClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = COLOR_BACKGRUNDE;
     _dataArr = [NSMutableArray array];
    [self requestData];
    
    //自定义导航栏
    [self CreateNav];
    
    [self creatTab];
   loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
    loadView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loadView];
    
    NSString  *name = @"loading.gif";
    
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    if (!self.loadingImageView) {
        
        self.loadingImageView = [[UIImageView alloc]init];
        
    }
    self.loadingImageView.backgroundColor = [UIColor clearColor];
    
    self.loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    
    self.loadingImageView.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
    
    [loadView addSubview:self.loadingImageView];
    
//    [self.view bringSubviewToFront:self.loadingImageView];
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
 
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(navBarView), SCREENWIDTH, SCREENHEIGHT)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
//    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor =COLOR_BACKGRUNDE;
    [self.view addSubview:_myTableView];

}
-(void)hiddenload:(id)res{
    [UIView animateWithDuration:2 animations:^{
        loadView.frame = CGRectMake(0, -200, SCREENWIDTH, 200);
        [_dataArr addObjectsFromArray:res[@"data"]];
        [_myTableView reloadData];
    }];
}
-(void)requestData{

         _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",_sort,@"class",_grtoken,@"gr_token",nil];
//    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPCLASSURL parameters:dicParam success:^(id responseObject) {
                [_dataArr removeAllObjects];
        if(![responseObject isKindOfClass:[NSNull class]]){
            NSInteger errcode = [responseObject[@"errcode"]integerValue];
            if(errcode == 1){
                [self performSelector:@selector(hiddenload:) withObject:responseObject afterDelay:0.5f];
            
              
            }else{
//                [self.view makeToast:@"获取失败" duration:1 position:CSToastPositionCenter];

                [self performSelector:@selector(backAction) withObject:nil afterDelay:0.8];
            }
                [_myTableView reloadData];
    }
     
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
                [_myTableView reloadData];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    BPClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[BPClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    }
    if(_dataArr.count){
        [cell refreshWithData:_dataArr[indexPath.row]];
    }
     cell.headImage.image = [UIImage imageNamed:_imagenName];
    return cell;
}
//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CGAffineTransform(0.25,0.25,0.1,0.2);
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    BPClassListViewController *RPvc = [[BPClassListViewController alloc]init];
    RPvc.hidesBottomBarWhenPushed = YES;
    RPvc.titleName = dic[@"title"];
    [self.navigationController pushViewController:RPvc animated:YES];
}
@end
