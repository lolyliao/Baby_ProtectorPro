//
//  BPMainViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/12.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMainViewController.h"
#import "BPMainNoCView.h"
#import "BPChoiceVCViewController.h"
#import "BPAddBabyViewController.h"
#import "BPMomExperViewController.h"
#import "BPChoiceMainView.h"
#import "BPAdDview.h"
#import "BPTabbarViewController.h"
#import "BPClassViewController.h"
#import "BPClassViewController.h"
#import "BPSearchViewController.h"
#import <UShareUI/UShareUI.h>

@interface BPMainViewController ()<ClickChoiceDelegte,RefreshDataDelegate,SLSlideMenuProtocol>{
    BPMainNoCView *_noChoiceView;
    BPChoiceMainView*_ChoiceView;
    NSString *_time;
    NSString *_grtoken;
    UIView *_showView;
    UIView *_backView;
    BPAdDview *_addView;
}

@end

@implementation BPMainViewController
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    _addView.hidden = NO;
    _showView.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    _addView.hidden = YES;
    _showView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Unit saveUserDefaultsInt:1 forKey:@"countTime"];
    self.view.backgroundColor = COLOR_BACKGRUNDE;
    self.edgesForExtendedLayout = NO;
     _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:_backView];
    

    NSDictionary *dic = [Unit getUserDefaultsObjForKey:@"guoer"];
    NSInteger active = [dic[@"active"]integerValue];
    if(active == 0){
        [self creatNoChoiceView:dic];
    }else{
        [self creatChoiceView:dic];
    }
     [self getToday];
//   [self showHeadView];
}

-(void)getToday{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [self requestData:DateTime];
}
#pragma mark  没有定制的首页
-(void)creatNoChoiceView:(NSDictionary *)dic{
    _noChoiceView = [[BPMainNoCView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _noChoiceView.delegate = self;
    _noChoiceView.dataDic = dic;
    [self.view addSubview:_noChoiceView];
}
#pragma mark  定制的首页
-(void)creatChoiceView:(NSDictionary *)responseObject{
    _ChoiceView = [[BPChoiceMainView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-44)];
    _ChoiceView.delegage = self;
    _ChoiceView.dataDic = responseObject;
    _ChoiceView.footView.dataDic = responseObject;
    _ChoiceView.footView.delegate = self;
    [_backView addSubview:_ChoiceView];
    __weak __typeof(BPChoiceMainView) *add= _ChoiceView;
    add.block = ^(int tag) {
        if(tag == 402){ 
            [self   showHeadView];
        }
    };
}
-(void)showHeadView{
        [SLSlideMenu slideMenuWithFrame:CGRectMake(0, 0, screenW, 126) delegate:self direction:SLSlideMenuDirectionTop slideOffset:126 allowSwipeCloseMenu:YES aboveNav:YES identifier:@"top"];
    _addView = [[BPAdDview alloc]initWithFrame:CGRectMake(0, -126, SCREENWIDTH , 126)];
    _addView.backgroundColor = [UIColor whiteColor];
    __weak __typeof(BPAdDview) *adds= _addView;
    adds.block = ^(int tag) {
        
        BPAddBabyViewController *RPvc = [[BPAddBabyViewController alloc]init];
        RPvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:RPvc animated:YES];
    };
}
-(void)ClicjHidden{
    [UIView animateWithDuration:0.5 animations:^{
        _showView.hidden= YES;
        _addView.hidden= YES;
    }];
}
-(void)ClickChoiceVC{

    BPChoiceVCViewController *RPvc = [[BPChoiceVCViewController alloc]init];
    RPvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:RPvc animated:YES];
    
    //返回选择页面
//    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}
-(void)RefreshData:(NSString *)time{
    NSLog(@"当前时间 === %@",time);
    [self requestData:time];
    [_ChoiceView.myTableView reloadData];
}
#pragma mark 调用数据
-(void)requestData:(NSString *)DateTime{

    NSDictionary *dicParam;
            dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",DateTime,@"time",_grtoken,@"gr_token",nil];
    [BPHttpRequest postWithURLString:APPMAINURL parameters:dicParam success:^(id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([responseObject[@"errcode"]isEqual:@"1"]){
    
                if([responseObject[@"active"]isEqual:@"0"]){
                           _ChoiceView.hidden = YES;
                    // 没有选择个性化
//                    [self creatNoChoiceView:responseObject];
              _noChoiceView.dataDic = responseObject;
                }else{
//                    [self creatChoiceView:responseObject];
                    _ChoiceView.dataDic = responseObject;
                    _ChoiceView.footView.dataDic = responseObject;

                }
            }else if([responseObject[ERRCODE]isEqual:@"0"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE0);
            }else if([responseObject[ERRCODE]isEqual:@"2"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE2);
            }else if([responseObject[ERRCODE]isEqual:@"3"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE3);
            }else if([responseObject[ERRCODE]isEqual:@"4"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE4);
            }else if([responseObject[ERRCODE]isEqual:@"5"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE5);
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
}

#pragma mark 跳转 分类页面
-(void)ClickClass:(NSString *)sort imageName:(NSString *)imagenName title:(NSString *)title{
    BPClassViewController *RPvc = [[BPClassViewController alloc]init];
    RPvc.hidesBottomBarWhenPushed = YES;
    RPvc.sort = sort;
    RPvc.imagenName = imagenName;
    RPvc.titleName = title;
    if([sort isEqualToString:@"5"]){
        [Unit showHint:@"即将推出，敬请期待"];
        return;
    }
    [self.navigationController pushViewController:RPvc animated:YES];
}
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    if (slideMenu.direction == SLSlideMenuDirectionTop) {
       
        _addView = [[BPAdDview alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 126)];
        [menuView addSubview:_addView];
   
        __weak __typeof(BPAdDview) *adds= _addView;
        adds.block = ^(int tag) {
                   [slideMenu hide];
            BPAddBabyViewController *RPvc = [[BPAddBabyViewController alloc]init];
            RPvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:RPvc animated:YES];
            
        };
        };
}
-(void)ClickChoiceSearch{
    BPSearchViewController *search = [[BPSearchViewController alloc]init];
    search.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:search animated:YES];
}
@end
