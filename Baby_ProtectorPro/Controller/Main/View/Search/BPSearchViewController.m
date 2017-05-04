//
//  BPSearchViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/26.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPSearchViewController.h"
#import "BPSearchCell.h"
#import "BPArticleViewController.h"

@interface BPSearchViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    UIView *_backView;
    UIView *_hisView;
    UIView *headView ;
    UIView *_hotView ;
    NSArray *_hotArr;
    NSString *_grtoken;
    UIButton *deletBtn;
}
@property ( nonatomic , strong ) UITextField *searchTX;
@property ( nonatomic , strong ) NSMutableArray *dataArr;
@property ( nonatomic , strong ) NSMutableArray *searchArr;
@property ( nonatomic , strong ) NSMutableArray *listAry;
@property ( nonatomic , strong ) NSArray *datas;
@property ( nonatomic , strong ) UICollectionView *mainCollectionView;
@property ( nonatomic , strong ) UICollectionView *hotCollectionView;
@property ( nonatomic , strong ) UITableView *myTableView;
@end

@implementation BPSearchViewController
-(void)viewWillAppear:(BOOL)animated{

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =  COLOR_BACKGRUNDE;

    _searchArr = [NSMutableArray array];
     _listAry = [NSMutableArray array];
    _dataArr = [NSMutableArray array];

//    if ((arr.count != 0) && (![arr isKindOfClass:[NSNull class]])) {
//        _dataArr = [arr mutableCopy];
//        [_listAry removeAllObjects];
//        for (NSString *str in _dataArr) {
//            if (![_listAry containsObject:str]) {
//                [_listAry addObject:str];
//            }
//        }
//        [_dataArr removeAllObjects];
//        [_dataArr setArray:_listAry];
//    }
    _datas = [SearchTool getAllSearchHistory];
    [_dataArr setArray:_datas];
    
    [self creatUI];
    
    [self creatHisView];
    
    [self creathotView];
    
    [self creatTable];
}
-(void)creatTable{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(headView)+10, SCREENWIDTH, SCREENHEIGHT-100)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.hidden = YES;
    _myTableView.backgroundColor = COLOR_WHITE;
    [self.view addSubview:_myTableView];
}
-(void)creatUI{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    headView.backgroundColor =COLOR_PINK;
    [self.view addSubview:headView];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(headView)+10, SCREENWIDTH, SCREENHEIGHT-100)];
    _backView.backgroundColor = COLOR_BACKGRUNDE;
    [self.view addSubview:_backView];
    
    UIButton *backBtn = [Unit creatButton:CGRectMake(0, 40,  50, 50) withName:nil normalImg:nil highlightImg:nil selectImg:nil];
    [backBtn setImage:[UIImage imageNamed:@"back-b"] forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeCenter;
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    
    _searchTX = [Unit createTextField:CGRectMake(NW(backBtn),50, 270, 30) withPlaceholder:@"搜索"];
    if(DEVICEHEIGHT5){
        _searchTX.height = 30/1.17;
        _searchTX.width = 270/1.17;
    }
    _searchTX.delegate = self;
    _searchTX.clearsOnBeginEditing = YES;
     _searchTX.backgroundColor = [UIColor whiteColor];
    _searchTX.layer.cornerRadius = 5;
    _searchTX.layer.masksToBounds = YES;
    [_searchTX addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
   [ _searchTX becomeFirstResponder ];
    [self  setTextFieldLeftPadding:_searchTX forWidth:10];
    [headView addSubview:_searchTX];
    
    UIImageView *searchImage = [Unit createImageView:CGRectMake(_searchTX.width-30, 18/2,14, 14) isRound:NO];
    searchImage.image = [UIImage imageNamed:@"ss"];
    [_searchTX addSubview:searchImage];
    
    UILabel *noti = [Unit createLable:CGRectMake(10, NH(_backView)+10, 100, 20) withName:@"" withFont:12 textAlignt:@"center"];
    noti.textColor = COLOR_3333;
    noti.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:noti];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatHisView{
    _hisView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    _hisView.backgroundColor = COLOR_WHITE;
    [_backView addSubview:_hisView];
    
    UILabel *hisLabel = [Unit createLable:CGRectMake(10, 5, 100, 20) withName:@"搜索历史" withFont:13 textAlignt:@"left"];
    hisLabel.textColor = COLOR_9999;
    [_hisView addSubview:hisLabel];
    
    deletBtn = [Unit creatButton:CGRectMake(SCREENWIDTH-90, 5,  80, 20) withName:nil normalImg:nil highlightImg:nil selectImg:nil];
    deletBtn.layer.cornerRadius = 3.0f;
    deletBtn.layer.masksToBounds = YES;
    deletBtn.layer.borderColor = [COLOR_9999 CGColor];
    deletBtn.layer.borderWidth = 0.2;
    deletBtn.titleLabel.font = FONTFZLTHK11;
    [deletBtn setTitle:@"清除历史数据" forState:UIControlStateNormal];
    [deletBtn setTitleColor:COLOR_9999 forState:UIControlStateNormal];
    [deletBtn addTarget:self action:@selector(clickDele) forControlEvents:UIControlEventTouchUpInside];
    if(_dataArr.count <= 0){
        deletBtn.hidden = YES;
    }
    [_hisView addSubview:deletBtn];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, NH(hisLabel)+10, SCREENWIDTH, 0.5)];
    lineview.backgroundColor = COLOR_BACKGRUNDE;
    [_hisView addSubview:lineview];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,NH(lineview), SCREENWIDTH, _dataArr.count/4*30+30) collectionViewLayout:layout];
    
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_mainCollectionView registerClass:[BPSearchCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [_hisView addSubview:_mainCollectionView];
    
    _hisView.height = _mainCollectionView.BottomY+10;
    
}
-(void)creathotView{
    _hotView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_hisView)+10, SCREENWIDTH, 300)];
    _hotView.backgroundColor = COLOR_WHITE;
    [_backView addSubview:_hotView];
    
    UILabel *hisLabel = [Unit createLable:CGRectMake(10, 5, 100, 20) withName:@"热门搜索" withFont:13 textAlignt:@"left"];
    hisLabel.textColor = COLOR_9999;
    [_hotView addSubview:hisLabel];
    
   
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, NH(hisLabel)+10, SCREENWIDTH, 0.5)];
    lineview.backgroundColor = COLOR_BACKGRUNDE;
    [_hotView addSubview:lineview];
    
    _hotArr = @[@"妊娠巨吐",@"肺炎",@"发烧",@"咳嗽",@"黄疸",@"洗澡",@"吐奶",@"喂养",@"断奶",@"打嗝",@"热痱",@"湿疹",@"过敏",@"睡眠习惯",@"宝宝刷牙",@"剖腹产护理",@"涨奶",@"孕期腰痛",@"孕期水肿",@"脐带护理",@"孕前准备",@"孕期用药",@"孕期腿抽筋",@"产后饮食",@"产后保养",@"宫外孕"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    _hotCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,NH(lineview), SCREENWIDTH, 210) collectionViewLayout:layout];
    
    _hotCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_hotCollectionView registerClass:[BPSearchCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    _hotCollectionView.delegate = self;
    _hotCollectionView.dataSource = self;
    [_hotView addSubview:_hotCollectionView];
  
}
#pragma mark  清除历史数据
-(void)clickDele{
    [self.view endEditing:YES];
    if(_dataArr.count > 0){
        [SearchTool clearAllSearchHistory];
        [self performSelector:@selector(deleHis) withObject:nil afterDelay:1.0f];
        [self deleHis];
    }

}
-(void)deleHis{

    [_dataArr removeAllObjects];

    [self.view makeToast:@"清除成功" duration:1 position:CSToastPositionCenter];
    
    _hisView.height = 60;
    _mainCollectionView.y= 30.5;
    _mainCollectionView.height = 30;
    _hotView.y = _hisView.height+10;
    
    [_mainCollectionView reloadData];
       [_hotCollectionView reloadData];
}
#pragma mark  设置uitextfiled前面空格
-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    deletBtn.hidden = NO;
    if(textField.text.length <= 0){
        _backView.hidden = NO;
        _myTableView.hidden = YES;
    }
    _mainCollectionView.frame =CGRectMake(0,30.5, SCREENWIDTH, _dataArr.count/4*30+30) ;
    _hisView.height = _mainCollectionView.BottomY;
    _hotView.y = _hisView.height+10;
    
    [_mainCollectionView reloadData];
    [_hotCollectionView reloadData];
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if(theTextField.text.length <= 0){
        _backView.hidden = NO;
        _myTableView.hidden = YES;
    }
    //设置textfield的字体长度
    if (theTextField == _searchTX) {
        if (theTextField.text.length > 20) {
            theTextField.text = [_searchTX.text substringToIndex:20];
        }
    }
    [_mainCollectionView reloadData];
    [_hotCollectionView reloadData];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"xie d %@",textField.text);
    if(textField.text.length <= 0){
        return;
    }
    if(textField == _searchTX){
        _searchTX = textField;
    }

       [SearchTool addSearchRecord:textField.text];
    _datas = [SearchTool getAllSearchHistory];
        [_dataArr setArray:_datas];
    
    [_mainCollectionView reloadData];
    [_hotCollectionView reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.text.length <= 0){
        return nil;
    }
    if(textField == _searchTX){
        _searchTX = textField;
    }
      [SearchTool addSearchRecord:textField.text];
    _datas = [SearchTool getAllSearchHistory];
      [_dataArr setArray:_datas];
    [_mainCollectionView reloadData];
    [_hotCollectionView reloadData];
    [self requestSearchData];
    return YES;
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == _mainCollectionView){
        if(_dataArr.count){
            return _dataArr.count;
        }else{
            return 1;
        }
    }else{
        if(_hotArr.count){
            return _hotArr.count;
        }else{
            return 1;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BPSearchCell *cell = (BPSearchCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if(collectionView == _mainCollectionView){
        if(_dataArr.count){
            cell.titleLabel.textColor = COLOR_3333;
            cell.titleLabel.text = _dataArr[indexPath.row];
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.titleLabel.text = @"暂无历史数据";
            cell.titleLabel.textColor = COLOR_9999;
        }
    }else{
        cell.titleLabel.text = _hotArr[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == _mainCollectionView){
        if(_dataArr.count > 0){
                return CGSizeMake(SCREENWIDTH/4,30);
        }else{
            return CGSizeMake(SCREENWIDTH/4, 30);
        }
    }else{
        return CGSizeMake(SCREENWIDTH/4,30);
    }
    
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == _mainCollectionView){
         _datas = [SearchTool getAllSearchHistory];
          [_dataArr setArray:_datas];
        _searchTX.text = _dataArr[indexPath.row];
 
    }else{
        _searchTX.text = _hotArr[indexPath.row];
    }
           [self requestSearchData];
    [SearchTool addSearchRecord:_searchTX.text];
    _datas = [SearchTool getAllSearchHistory];
  [_dataArr setArray:_datas];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark  搜索 获取数据
-(void)requestSearchData{
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",_searchTX.text,@"key",_grtoken,@"gr_token",nil];
    NSLog(@"提交的数据===%@",dicParam);
    [BPHttpRequest postWithURLString:APPSEARCHURL parameters:dicParam success:^(id responseObject) {
        if(![responseObject isKindOfClass:[NSNull class]]){
            [_searchArr removeAllObjects];
            NSInteger errcode = [responseObject[@"errcode"] integerValue];
            if(errcode == 1){
                _backView.hidden = YES;
                 _myTableView.hidden = NO;
                [_searchArr setArray:responseObject[@"data"]];
            }else{
                [self.view makeToast:@"搜索失败" duration:1.0f position:CSToastPositionCenter];
            }
        }
        [_myTableView reloadData];
//            [_mainCollectionView reloadData];
//            [_hotCollectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
    }];
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_searchArr.count ){
        return _searchArr.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = COLOR_WHITE;
//        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    cell.textLabel.font = FONTFZLTHK12;
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, SCREENWIDTH, 0.5)];
    lineview.backgroundColor = COLOR_BACKGRUNDE;
    [cell addSubview:lineview];
    if(_searchArr.count){
        NSDictionary *dic = _searchArr[indexPath.row];
        cell.textLabel.text = dic[@"title"];
    }else{
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"您搜索的关键字没有结果";
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    
    UILabel *noti = [Unit createLable:CGRectMake(10,0, SCREENWIDTH, 30) withName:@"" withFont:12 textAlignt:@"left"];
    noti.textColor = COLOR_9999;
//    noti.text = [NSString stringWithFormat:@"包含“%@”关键字的搜索结果",_searchTX.text];
        [header addSubview:noti];
    
    NSString *str =[NSString stringWithFormat:@"包含“%@”关键字的搜索结果",_searchTX.text];
    
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSString * strStaus = _searchTX.text;
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
                            value:COLOR_SEARCHGREEN
                            range:[str rangeOfString:strStaus]];
    
    noti.attributedText = attrDescribeStr;
    
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREENWIDTH, 0.5)];
    lineview.backgroundColor = COLOR_BACKGRUNDE;
    [header addSubview:lineview];
    
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _searchArr[indexPath.row];
    BPArticleViewController *RPvc = [[BPArticleViewController alloc]init];
    RPvc.hidesBottomBarWhenPushed = YES;
    RPvc.article = dic[@"id"];
    RPvc.titleName = dic[@"title"];
    [self.navigationController pushViewController:RPvc animated:YES];
}

@end
