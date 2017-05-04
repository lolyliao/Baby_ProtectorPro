//
//  BPMainNoCView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/13.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMainNoCView.h"
#import "BPMainViewCell.h"
#import "MainModel.h"

@implementation BPMainNoCView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        _imageArr = [NSMutableArray array];
        //headview
        [self creatView];
        
        //midview
        [self midViews];
        
        //bottomView
        [self bottomviews];
    }
    return self;
}
#pragma mark 没有选择的页面
-(void)creatView{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 284/2)];
    _headView.backgroundColor = [UIColor colorwithHexString:@"ffcccc"];
    [self addSubview:_headView];
    
    _headImage = [Unit createImageView:CGRectMake(0, 0, 82, 36) isRound:NO];
    _headImage.image = [UIImage imageNamed:@"logo"];
    _headImage.center = CGPointMake(self.width/2, 62);
    [_headView addSubview:_headImage];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(20, _headImage.BottomY+10,270, 30);
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    _searchBtn.layer.cornerRadius = 8;
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.center = CGPointMake(SCREENWIDTH/2, _headImage.BottomY+20);
    _searchBtn.backgroundColor = COLOR_WHITE;
    [_searchBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_searchBtn];
    if(DEVICEHEIGHT5){
        _searchBtn.height =35/1.17;
        _searchBtn.width = 316/1.17;
    }
    
    _searchImage = [Unit createImageView:CGRectMake(_searchBtn.width-30, 18/2,14, 14) isRound:NO];
    _searchImage.image = [UIImage imageNamed:@"ss"];
    [_searchBtn addSubview:_searchImage];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, _searchBtn.BottomY+5,270, 30);
//17*16
    [btn setTitle:@"准妈妈都爱的护肤品" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    btn.center = CGPointMake(SCREENWIDTH/2, _searchBtn.BottomY+20);
    btn.backgroundColor = COLOR_PINK;
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:9];
//    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:btn];
    if(DEVICEHEIGHT5){
        _searchBtn.height =35/1.17;
        _searchBtn.width = 316/1.17;
    }
    
    UIImageView *kuohao = [Unit createImageView:CGRectMake(btn.width/2+30, 18/2,17, 16) isRound:NO];
    kuohao.image = [UIImage imageNamed:@"kuohao"];
    [btn addSubview:kuohao];
}
-(void)setDataDic:(NSDictionary *)dataDic{
//    NSLog(@"主页数据是%@",dataDic);
    
    self.sectionArray = [NSMutableArray new];
    //解析按钮数据
    NSString *bkClass  = [dataDic[@"bkClass"] isKindOfClass:[NSNull class]] ? @"" : dataDic[@"bkClass"];
    NSString *requestbkClass = [NSString stringWithString: bkClass ];
    NSData *resDatabkClass = [[NSData alloc]initWithData:[requestbkClass dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *resultDicbkClass = [NSJSONSerialization JSONObjectWithData:resDatabkClass options:NSJSONReadingMutableLeaves error:nil];
    
    for(NSInteger i =0;i<resultDicbkClass.count;i++){
        MainModel *model = [[MainModel alloc] init];
        model.sort = resultDicbkClass[i][@"sort"];
        
        [self.sectionArray addObject:model];
        
    }
    [_mainCollectionView reloadData];
}


#pragma mark - midview
#define MaxItemCount 10
#define ItemWidth 94
#define ItemHeight 94
#define BTNWITH SCREENWIDTH/4
#define BTNHEIGHT 120/2
-(void)midViews{
    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_headView), SCREENWIDTH, 200)];

    _midView.backgroundColor =[UIColor whiteColor];
    [self addSubview:_midView];

   NSArray *picArr=  @[@"zhishi",@"care",@"sick",@"report",@"food",@"peiyan"];
    [_imageArr setArray:picArr];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);
        //该方法也可以设置itemSize
        //    layout.itemSize =CGSizeMake(0, 150);
        
        //2.初始化collectionView
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, _midView.height) collectionViewLayout:layout];
 
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_mainCollectionView registerClass:[BPMainViewCell class] forCellWithReuseIdentifier:@"cellId"];
        //4.设置代理
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
               [_midView addSubview:_mainCollectionView];

//    }
}

-(void)bottomviews{
   
    _startBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame = CGRectMake(70, 35/2, (306) ,224/2);
     _startBtn.center = CGPointMake(self.width/2.0,NH(_midView)+100);;
    if(DEVICEHEIGHT5) {
         _startBtn.center = CGPointMake(self.width/2.0,NH(_midView)+80);;
    }
   
         [_startBtn setBackgroundImage:[UIImage imageNamed:@"WechatIMG5"] forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(ClickChoice) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
}

-(void)ClickChoice{
    if(_delegate && [_delegate respondsToSelector:@selector(ClickChoiceVC)]){
        [_delegate ClickChoiceVC];
    }
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_imageArr.count){
    return _imageArr.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BPMainViewCell *cell = (BPMainViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if(_imageArr.count){
    cell.showImage .image = [UIImage imageNamed:_imageArr[indexPath.row]];

    cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(DEVICEHEIGHT5) {
       return CGSizeMake(186/2/1.17, 90/1.17);
    }else{
           return CGSizeMake(186/2, 90);
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sort;
    NSString *titles;
    if(indexPath.row == 0){
        sort = @"1";
        titles = @"孕育知识";
    }else if (indexPath.row == 1){
        sort = @"2";
        titles = @"宝宝护理";
    }else if (indexPath.row == 2){
        sort = @"4";
        titles = @"常见疾病";
    }else if (indexPath.row == 3){
        sort = @"5";
        titles = @"医学报告";
    }else if (indexPath.row == 4){
        sort = @"6";
        titles = @"营养食谱";
    }else if (indexPath.row == 5){
        sort = @"7";
        titles = @"行为早教";
    }

    if(_delegate && [_delegate respondsToSelector:@selector(ClickClass:imageName:title:)]){
        [_delegate ClickClass:sort imageName:_imageArr[indexPath.row] title:titles];
    }
}

-(instancetype)initWithFrameH:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        _imageArr = [NSMutableArray array];

        
        //midview
        [self midViews1];
        
    }
    return self;
}
-(void)midViews1{
    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 230)];
    _midView.backgroundColor =[UIColor whiteColor];
    [self addSubview:_midView];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 10)];
    lineview.backgroundColor = COLOR_BACKGRUNDE ;
        [_midView addSubview:lineview];
    

    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(20, 10, SCREENWIDTH-40, 35);
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    _searchBtn.layer.cornerRadius = 5;
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.center = CGPointMake(SCREENWIDTH/2, 35);
     _searchBtn.backgroundColor = [UIColor colorwithHexString:@"#F1EDED"];
    [_searchBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
     [_midView addSubview:_searchBtn];
    if(DEVICEHEIGHT5){
        _searchBtn.height =35/1.17;
        _searchBtn.width = 316/1.17;
    }
    
    _searchImage = [Unit createImageView:CGRectMake(_searchBtn.width-30, 18/2,14, 14) isRound:NO];
    _searchImage.image = [UIImage imageNamed:@"ss"];
    [_searchBtn addSubview:_searchImage];
    

    NSArray *picArr=  @[@"zhishi",@"care",@"sick",@"report",@"food",@"peiyan"];
    
    [_imageArr setArray:picArr];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,NH(_searchBtn)+10, self.width, 180) collectionViewLayout:layout];
    
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_mainCollectionView registerClass:[BPMainViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [_midView addSubview:_mainCollectionView];
    
    //    }
}
-(void)clickBtn{
    if(_delegate && [_delegate respondsToSelector:@selector(ClickChoiceSearch)]){
        [_delegate ClickChoiceSearch];
    }
    
}
@end
