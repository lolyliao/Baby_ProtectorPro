//
//  BPMomExperViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/15.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMomExperViewController.h"
#import "BPMomExperCell.h"
#import "BPMomEXView.h"

@interface BPMomExperViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    BPNavView *navBarView;
    UIView *_bottomView;
    BPMomEXView *_headMomView;
    NSString *_grtoken;
    NSMutableDictionary *pageDictionary;
    JSTextView *_searchTX;
    UIImageView *_zanImage;
}
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *momArr;
@end

@implementation BPMomExperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _momArr = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
       _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    [self requestMomEXData:@"nol"];
    [self CreateNav];
    
    [self creatTab];
    
    [self creatBommtonView];
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    //    [navBarView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text =@"宝妈经验";
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
    _headMomView = [[BPMomEXView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 388)];
    _headMomView.dic = _dic;
    _headMomView.backgroundColor = [UIColor whiteColor];
    __weak typeof(BPMomEXView)*weakself = _headMomView;
    weakself.block = ^(UIButton *sender) {
        
        [self requestZanData:sender :@"6"];
    };
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(navBarView), SCREENWIDTH, SCREENHEIGHT-navBarView.height-60)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = COLOR_BACKGRUNDE;
    _myTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:_myTableView];
    
    _myTableView.tableHeaderView = _headMomView;

}
#pragma mark- 底部导航栏
-(void)creatBommtonView{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-60, SCREENWIDTH, 60)];
    [self.view addSubview:_bottomView];
    
    UIView *live = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    live.backgroundColor = COLOR_BACKGRUNDE;
    [_bottomView addSubview:live];
    
    _searchTX = [[JSTextView alloc]initWithFrame:CGRectMake(10,NH(live)+5, SCREENWIDTH-20-55, 34) ];
    _searchTX.myPlaceholder = @"点我写评论哦";
    _searchTX.myPlaceholderColor = [UIColor colorwithHexString:@"#F1EDED"];
    _searchTX.backgroundColor = [UIColor whiteColor];
    _searchTX.delegate = self;
    _searchTX.layer.cornerRadius = 5;
    _searchTX.layer.masksToBounds = YES;
    _searchTX.layer.borderColor = [COLOR_9999 CGColor];
    _searchTX.layer.borderWidth = 0.2;
    [_bottomView  addSubview:_searchTX];
    
    UIButton *sendBtn = [Unit creatButton:CGRectMake(SCREENWIDTH-55, NH(live)+5, 50, 36) withName:nil normalImg:[UIImage imageNamed:@"send"] highlightImg:nil selectImg:nil];
    [sendBtn addTarget:self action:@selector(ClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:sendBtn];
    
}
-(void)ClickSubmit{
    if(_searchTX.text.length <= 0){
        [self.view makeToast:@"请写评论哦" duration:1 position:CSToastPositionCenter];
        return;
    }
    [self.view endEditing:YES];
    [self requestMomEXData:@"send"];
}
#pragma mark  评论点赞
-(void)clickZan{
    
    [self requestZanData:nil :@"3"];
}
#pragma mark  点赞
-(void)requestZanData:(UIButton *)sender :(NSString *)type{
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSDictionary *dicParam;
    if([type isEqualToString:@"3"]){
        dicParam = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",_dic[@"number"],@"MAid",_grtoken,@"gr_token",nil];
    }else{
        dicParam = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",_dic[@"number"],@"momArticle",_grtoken,@"gr_token",nil];
    }
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPARTICALURL parameters:dicParam success:^(id responseObject) {
        if(![responseObject isKindOfClass:[NSNull class]]){
            NSInteger errcode = [responseObject[@"errcode"] integerValue];
            if(errcode == 1){
   if([type isEqualToString:@"6"]){ // 文字点赞
                    if([responseObject[@"love"]isEqual:@"1"]){
                        [self.view makeToast:@"已点赞" duration:0.5 position:CSToastPositionCenter];
                        [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
                        
                    }else{
                        [self.view makeToast:@"取消点赞" duration:0.5 position:CSToastPositionCenter];
                        [sender setImage:[UIImage imageNamed:@"dianzanNo"] forState:UIControlStateNormal];
                    }
       
   }else{//评论点赞
       if([responseObject[@"love"]isEqual:@"1"]){
           [self.view makeToast:@"已点赞" duration:0.5 position:CSToastPositionCenter];
           _zanImage.image = [UIImage imageNamed:@"dianzan"];
           
       }else{
           [self.view makeToast:@"取消点赞" duration:0.5 position:CSToastPositionCenter];
           _zanImage.image = [UIImage imageNamed:@"dianzanNo"];
       }
   }
            }
        }
        [_myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
}
#pragma mark 宝妈经验
-(void)requestMomEXData:(NSString *)ide{
    NSDictionary *dicParam;
    if([ide isEqualToString:@"send"]){//提交评论
    dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",_dic[@"number"],@"momArticle",_grtoken,@"gr_token",_searchTX.text,@"word",nil];
    }else{
    dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",_dic[@"number"],@"momArticle",_grtoken,@"gr_token",@"0",@"size",nil];
    }
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPCOMMENYURL parameters:dicParam success:^(id responseObject) {

                    NSArray *errcodeA =responseObject;
 
            if([ide isEqualToString:@"send"]){//提交评论
                NSInteger errcode = [responseObject[@"errcode"]integerValue];

                if(errcode == 1){
                    [self.view makeToast:@"提交成功" duration:2 position:CSToastPositionCenter];
                    _searchTX.text = nil;
                               [self requestMomEXData:@"nol"];
                }else{
                    [self.view makeToast:@"数据获取失败" duration:2 position:CSToastPositionCenter];
                }
            }else{
                if(errcodeA.count > 0){
                     NSInteger errcode = [responseObject[@"errcode"]integerValue];
                    if(errcode == 1){
                        pageDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"index", nil];
                        [_momArr setArray:responseObject[@"data"]];
                    }else{
                        [self.view makeToast:@"数据获取失败" duration:2 position:CSToastPositionCenter];
                    }
                }else{
                    
                }
            }
            [_myTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
    [_myTableView reloadData];
}
-(void)loadMore{
    NSInteger  pageIndex = [pageDictionary[@"index"] integerValue];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",_dic[@"number"],@"article",_grtoken,@"gr_token",[NSNumber numberWithInteger:pageIndex],@"size",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPCOMMENYURL parameters:dicParam success:^(id responseObject) {
        
        if(![responseObject isKindOfClass:[NSNull class]]){
            pageDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"index", nil];

            NSInteger errcode = [responseObject[@"errcode"]integerValue];
            if(errcode == 1){
                pageDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2",@"index", nil];
                [_momArr setArray:responseObject[@"data"]];
            }else{
                [self.view makeToast:@"暂无更多数据" duration:2 position:CSToastPositionCenter];
            }
            
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

#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_momArr.count){
        return _momArr.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_momArr.count){
        BPMomExperCell *cell = (BPMomExperCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeigh+10;
    }else{
        return 44;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if(_momArr.count){
        NSString *cellID = @"cell";
        BPMomExperCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell){
            cell = [[BPMomExperCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.backgroundColor =COLOR_WHITE;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _zanImage = cell.zaniamge;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickZan)];
        [cell.zaniamge addGestureRecognizer:tap];
        [cell refreshWithMomData:_momArr[indexPath.row] type:@"mom"];
        if(indexPath.row == _momArr.count-1){
            cell.linewView.hidden = YES;
        }
          return cell;
    }else{
        NSString *cellID1 = @"cells";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            cell.backgroundColor =COLOR_WHITE;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"还没有评论哦，快来评论吧！";
        cell.textLabel.font = FONTFZLTHK12;
        cell.textLabel.textColor = COLOR_9999;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
          return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 5;
    }else{
        return 0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView == _searchTX){
        _searchTX = (JSTextView *)textView;
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView == _searchTX){
        _searchTX = (JSTextView *)textView;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
