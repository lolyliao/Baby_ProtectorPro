//
//  BPArticleViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPArticleViewController.h"
#import "BPArticleCell.h"
#import "BPShareExViewController.h"
#import "BPModel.h"
#import "BPMomExperViewController.h"

@interface BPArticleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BPNavView *navBarView;
    NSString *_grtoken;
    UIButton *_colBtn;
    UIButton *_zanBtn;
    NSMutableDictionary *pageDictionary;
    CGFloat beginContentY;          //开始滑动的位置
    CGFloat endContentY;            //结束滑动的位置
    CGFloat sectionHeaderHeight;
    SurePlaceholderView *placeholderView;
}
@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *momArr;

@property (nonatomic,strong)UITableView *myTableViewCon;
@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation BPArticleViewController
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
     sectionHeaderHeight = 40;
    self.view.backgroundColor = COLOR_BACKGRUNDE;
    _dataArr = [NSMutableArray new];
    _momArr = [NSMutableArray new];
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];

    [self requestData];
    
    [self requestMomEXData];
    
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
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,navBarView.BottomY, SCREENWIDTH, SCREENHEIGHT-50-navBarView.height)style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor =COLOR_WHITE;
    //宝妈经验加载数据
    _myTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view  addSubview:_myTableView];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 50) ];
    [self.view addSubview:btnView];
    
    NSArray *titkeA = @[@"分享经验",@"收藏"];
    for(int i =0;i<2;i++){
        UIButton *bottomBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.frame = CGRectMake(btnView.width/2*i, 0, btnView.width/2, 50) ;
        bottomBtn.backgroundColor = COLOR_PINK;
        [btnView addSubview:bottomBtn];
           [bottomBtn setTitle:titkeA[i] forState:UIControlStateNormal];
         bottomBtn.titleLabel.textColor = [UIColor whiteColor];
        if(i == 1){
            _colBtn = bottomBtn;
           
        }
        bottomBtn.tag = 90+i;
        [bottomBtn addTarget:self action:@selector(clickZanAndCol:) forControlEvents:UIControlEventTouchUpInside];

            UIView *liness = [[UIView alloc]initWithFrame:CGRectMake(btnView.width/2, 0, 1, 50)];
            liness.backgroundColor = [UIColor whiteColor];
            [btnView addSubview:liness];
    }

}
#pragma mark 点赞收藏  跳转分享经验页面
-(void)clickZanAndCol:(UIButton *)sender{
    NSString *type;
    if(sender.tag == 90){
        BPShareExViewController *share = [[BPShareExViewController alloc]init];
        share.hidesBottomBarWhenPushed= YES;
        share.article = _article;
        [self.navigationController pushViewController:share animated:YES];
     
    }else if(sender.tag == 91){
        type = @"5";
        [self requestZanData:type];
    }else if(sender.tag == 92){
        type = @"2";
        [self requestZanData:type];
    }
}
#pragma mark  文章信息
-(void)requestData{

    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",_article,@"article",_grtoken,@"gr_token",nil];
        NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {

        if(![responseObject isKindOfClass:[NSNull class]]){
            [_dataArr removeAllObjects];
            NSString *content  = [responseObject[@"content"] isKindOfClass:[NSNull class]] ? @"" : responseObject[@"content"];
            NSString *requestTmp = [NSString stringWithString: content ];
            NSData *resData = [[NSData alloc]initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            NSArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            NSInteger col = [responseObject[@"col"]integerValue];
 
            if(col == 1){
                    [_colBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                }else{
                    [_colBtn setTitle:@"收藏" forState:UIControlStateNormal];
                }
            _dataDic = responseObject;
            [_dataArr addObjectsFromArray:resultDic];
            [_myTableView reloadData];
    
        }
   
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
    [_myTableView reloadData];
}

#pragma mark 宝妈经验
-(void)requestMomEXData{

    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"type",_article,@"article",_grtoken,@"gr_token",@"0",@"size",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {

        if(![responseObject isKindOfClass:[NSNull class]]){
            pageDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"index", nil];
            [_momArr setArray:responseObject];
            [_myTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
    [_myTableView reloadData];
}
-(void)loadMore{
    NSInteger  pageIndex = [pageDictionary[@"index"] integerValue];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"type",_article,@"article",_grtoken,@"gr_token",[NSNumber numberWithInteger:pageIndex],@"size",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {
        
        if(![responseObject isKindOfClass:[NSNull class]]){
            pageDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"index", nil];
            [_momArr addObjectsFromArray:responseObject];
             NSInteger  pageIndex = [pageDictionary[@"index"] integerValue];
            if(pageIndex > 8) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [_myTableView.footer noticeNoMoreData];
            }else{
                pageIndex ++;
                [_myTableView.footer endRefreshing];
                [pageDictionary setObject:[NSNumber numberWithInteger:pageIndex] forKey:@"index"];

            }
            [_myTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
    [_myTableView reloadData];}
#pragma Mark 收藏 和点赞
-(void)requestZanData:(NSString *)type{
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",_article,@"article",_grtoken,@"gr_token",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {
        if(![responseObject isKindOfClass:[NSNull class]]){
            NSInteger errcode = [responseObject[@"errcode"] integerValue];
            if(errcode == 1){
                if([type isEqualToString:@"2"]){
                    if([responseObject[@"love"]isEqual:@"1"]){
                        [self.view makeToast:@"已点赞" duration:0.5 position:CSToastPositionCenter];
                        [_zanBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
 
                    }else{
                        [self.view makeToast:@"取消点赞" duration:0.5 position:CSToastPositionCenter];
                        [_zanBtn setImage:[UIImage imageNamed:@"dianzanNo"] forState:UIControlStateNormal];
                    }
                }else if([type isEqualToString:@"5"]){
                    if([responseObject[@"collection"]isEqual:@"1"]){
                        [self.view makeToast:@"已收藏" duration:0.5 position:CSToastPositionCenter];
                        [_colBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                    }else{
                        [self.view makeToast:@"已取消收藏" duration:0.5 position:CSToastPositionCenter];
                        [_colBtn setTitle:@"收藏" forState:UIControlStateNormal];
                    }
                }
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];

}
#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_momArr.count > 0){
          return 2;
    }else{
            return 1;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      if(section == 0){
        if(_dataArr.count){
            return _dataArr.count;
        }else{
            return 0;
        }
    }else{
        if(_momArr.count){
            return _momArr.count;
        }else{
            return 0;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        BPArticleCell *cell = (BPArticleCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeigh+10;
    }else{
        BPArticleCell *cell = (BPArticleCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeighS+10;

    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    NSString *cellIDs = @"cellw";
   
    if(indexPath.section == 0){
        BPArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell){
            cell = [[BPArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.backgroundColor = COLOR_WHITE;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(_dataArr.count){
            [cell refreshWithData:_dataArr[indexPath.row]];
        }
        return cell;
    }else{
        BPArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDs];
        if (!cell){
            cell = [[BPArticleCell alloc]initWithStyleCon:UITableViewCellStyleDefault reuseIdentifier:cellIDs];
            cell.backgroundColor =COLOR_WHITE;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(_momArr.count){
            [cell refreshWithMomData:_momArr[indexPath.row] type:@"art"];
//            cell.model = _momArr[indexPath.row];
        }
        return cell;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH, 300)];
    headview.backgroundColor = [UIColor whiteColor];
     if(section == 0){
#pragma mark 头部
    UILabel* titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(5,5, headview.width-10, 20)];
    [headview addSubview:titlelabel];
    titlelabel.font =FONTFZLTHK12;
    titlelabel.textColor = COLOR_3333;
    titlelabel.text = _dataDic[@"title"];
    
    UILabel* timelabel = [[UILabel alloc]initWithFrame:CGRectMake(5,titlelabel.BottomY+5, headview.width-10, 20)];
    [headview addSubview:timelabel];
    timelabel.font =FONTFZLTHK12;
    timelabel.textColor = COLOR_6666;
    timelabel.text = _dataDic[@"time"];
    
    UIImageView *showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, timelabel.BottomY+5, headview.width, 250)];
    [showImage  sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"image"]] placeholderImage:[UIImage imageNamed:@"loading"]];
         showImage.contentMode =  UIViewContentModeScaleAspectFill;
    [headview addSubview:showImage];
    }else{
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH, 10)];
        lineview.backgroundColor = COLOR_BACKGRUNDE;
                [headview addSubview:lineview];
        
        UILabel* momLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,lineview.BottomY+10, headview.width-10, 20)];
        [headview addSubview:momLabel];
        momLabel.font =FONTFZLTHK12;
        momLabel.textColor = COLOR_3333;
          momLabel.text = [NSString stringWithFormat:@"宝妈经验（%ld）",_momArr.count];
        UIView *liness = [[UIView alloc]initWithFrame:CGRectMake(0, momLabel.BottomY+5,SCREENWIDTH, 0.5)];
        liness.backgroundColor =COLOR_BACKGRUNDE;
        [headview addSubview:liness];
    }

    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if(section == 0){
    return 300;
    }else{
        return 40;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH, 50)];
    footview.backgroundColor = [UIColor whiteColor];
    if(section == 0){
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(footview.width/2-100/2, 10,100, 0.5)];
        line.backgroundColor =COLOR_6666;
        [footview addSubview:line];
        
        UIButton *zanBTn= [UIButton buttonWithType:UIButtonTypeCustom];
        zanBTn.frame = CGRectMake(70, line.BottomY+10,42 ,34);
        zanBTn.center = CGPointMake(footview.width/2.0,line.BottomY+20);
        if([_dataDic[@"love"]isEqual:@"1"]){
               [zanBTn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        
        }else{
         [zanBTn setImage:[UIImage imageNamed:@"dianzanNo"] forState:UIControlStateNormal];
        }
        _zanBtn = zanBTn;
        zanBTn.tag = 92;
        [zanBTn addTarget:self action:@selector(clickZanAndCol:) forControlEvents:UIControlEventTouchUpInside];
        [footview addSubview:zanBTn];

        return footview;
    }else{
        return nil;
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
         if(section == 0){
        return 50;
    }else{
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        BPMomExperViewController *shar = [[BPMomExperViewController alloc]init];
        shar.hidesBottomBarWhenPushed = YES;
        shar.dic = _momArr[indexPath.row];
        shar.article = _article;
        [self.navigationController pushViewController:shar animated:YES];
    }
}
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if(velocity.y>0){
//        navBarView.hidden = YES;
//       
//    }
//    else {
//       navBarView.hidden = NO;
//    }
//}
#pragma mark 下拉导航栏隐藏
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //获取开始位置
    beginContentY = scrollView.contentOffset.y;
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //获取结束位置
    endContentY = scrollView.contentOffset.y;
    if(endContentY-beginContentY > 100)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = navBarView.frame;
            rect.origin.y = -64;
            navBarView.frame = rect;
            _myTableView.y = navBarView.BottomY;
             _myTableView.height = SCREENHEIGHT-50;
        }];
        sectionHeaderHeight = 0;
        [_myTableView reloadData];
    } else if(endContentY-beginContentY < -100)  {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = navBarView.frame;
            rect.origin.y = 0;
           navBarView.frame = rect;
         _myTableView.y = navBarView.BottomY;
            _myTableView.height = SCREENHEIGHT-navBarView.height-50;
        } completion:^(BOOL finished) {
            sectionHeaderHeight = 40;
            [_myTableView reloadData];
        }];
    }
}
@end
