//
//  BPChoiceMainView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/17.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//
#define dayMacro 30
#import "BPChoiceMainView.h"
#import "BPChoiceEDCell.h"
#import "MainModel.h"
#import "BPMainNoCView.h"

@implementation BPChoiceMainView{
 
    NSInteger count;
    NSString *_dayss;
    NSString *_dayBir;
    UIImageView *_allowImage;
    NSDate *_destDate;
    NSInteger countTime;
    int countT;
    NSString *stage;
}
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}
-(void)setDataDic:(NSDictionary *)dataDic{
//    NSLog(@"主页数据是%@",dataDic);
    
    self.sectionArray = [NSMutableArray new];
    _bkClassArr = [NSMutableArray new];
  //json解析
  NSString *babyTips  = [dataDic[@"babyTip"] isKindOfClass:[NSNull class]] ? @"" : dataDic[@"babyTip"];
    NSString *requestTmp = [NSString stringWithString: babyTips ];
    NSData *resData = [[NSData alloc]initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];

    for(NSInteger i =0;i<resultDic.count;i++){
        MainModel *model = [[MainModel alloc] init];
        model.open = NO;
        model.title =resultDic[i][0];
         model.tArr = resultDic[i][1];

      model.introLabel  = [resultDic[i][1] firstObject];
        model.open = NO;

        [self.sectionArray addObject:model];
    
    }
 
    NSString *tian =  [NSString stringWithFormat:@"%@", [[dataDic objectForKey:@"day"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"day"]];
   stage = [NSString stringWithFormat:@"%@", [[dataDic objectForKey:@"stage"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"stage"]];
 
     _dayBir = tian;
    int  day  = [tian intValue] ;
    NSLog(@"当天是%d",day);
    _dayss = [NSString stringWithFormat:@"%d",280 - day];
       _timeLable1.text = [NSString stringWithFormat:@"距离我出生还有%@天",_dayss ];
         _timeLabel.text = [NSString stringWithFormat:@"%d周%d天",day/7,day%7];
//    int dayV = [_dayss intValue];
//    if(dayV <= 0){
//        _timeLable1.text = [NSString stringWithFormat:@"啊偶，宝宝留级%d天",- dayV ];
//    }
#pragma mark 宝妈页面
    if([stage isEqualToString:@"3"]){
        _dayss = [NSString stringWithFormat:@"%d", day/dayMacro];
        _timeLabel.text = [NSString stringWithFormat:@"宝宝有%d个月%d天",day/dayMacro,day%dayMacro ];
        _timeLabel.y = 35;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.font = FONTFZLTHK15;
        _timeLable1.hidden = YES;
        _today.hidden = YES;
    }

    
    NSString *weighMin = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"weight_min"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"weight_min"]];
        NSString *weighMax =[NSString stringWithFormat:@"%@", [[dataDic objectForKey:@"weight_max"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"weight_max"]];
    int weigh = [weighMin intValue];
    float weighM = [weighMax floatValue];
    if(weigh == 0){
     _weightLabel.text = [NSString stringWithFormat:@"宝宝体重   %dkg~ %.2fkg",(weigh/1000),(weighM/1000)];
    }
   
//
    NSString *heighMin =[NSString stringWithFormat:@"%@", [[dataDic objectForKey:@"height_min"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"height_min"]];
    NSString *heighMax = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"height_max"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"height_max"]];
    _heightLabel.text = [NSString stringWithFormat:@"宝宝身长   %@~%@cm",heighMin,heighMax];

    _notiLabel .text =[NSString stringWithFormat:@"%@", [[dataDic objectForKey:@"word"] isKindOfClass:[NSNull class]] ? @"" : [dataDic objectForKey:@"word"]];

//    NSLog(@"宝宝的话%@",word);
//    CGFloat heigh = [Unit heightWithString:word
//                                      font:FONTFZLTHK11
//                        constrainedToWidth:_notiLabel.width];
    CGSize textSize = [Unit getLabelSizeFortextFont:[UIFont fontWithName:@"Arial" size:13] textLabel:_notiLabel.text];
    _notiLabel.height = textSize.height;
    _notiView.height = _notiLabel.BottomY+10;
    _headview.height = _notiView.BottomY+10;

//    _myTableView.height = self.height+heigh+20;
//    NSLog(@"%f", _myTableView.height);
#pragma mark  今天时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    _destDate = [dateFormatter dateFromString:dateTime];
//     countTime = 1;
    [_myTableView reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        _sectionArray = [NSMutableArray array];
        _flagArray  = [NSMutableArray array];
       

        [self creatView];
    
        
    }
    return self;
}

-(void)creatView{
#pragma mark  加载tableview
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_myTableView];
    
#pragma mark  创建头部
    _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 304)];
    _headview.backgroundColor = COLOR_PINK;
    [_myTableView addSubview:_headview];
    
    [self creatHeadview:_headview];
    
    _myTableView.tableHeaderView = _headview;
#pragma mark  创建尾部
    _footView = [[BPMainNoCView alloc]initWithFrameH:CGRectMake(0, 0, self.width, 230)];
    
    _myTableView.tableFooterView = _footView;

}
#pragma mark 创建头部
-(void)creatHeadview:(UIView *)headView{
    //今
    _today= [UIButton buttonWithType:UIButtonTypeCustom];
    _today.frame = CGRectMake(12, 30, (46/2)*autoSizeScaleX ,(46/2)*autoSizeScaleY);
    [_today setBackgroundImage:[UIImage imageNamed:@"jin"] forState:UIControlStateNormal];
    _today.layer.cornerRadius = 8;
    _today.layer.masksToBounds = YES;
    [_today addTarget:self action:@selector(ClickToday) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_today];
    
    //宝宝
    _addBbay= [UIButton buttonWithType:UIButtonTypeCustom];
    _addBbay.frame = CGRectMake(self.width - 12-46/2, 30, (46/2)*autoSizeScaleX ,(46/2)*autoSizeScaleY);
    [_addBbay setBackgroundImage:[UIImage imageNamed:@"bao"] forState:UIControlStateNormal];
    _addBbay.tag = 402;
    [_addBbay addTarget:self action:@selector(clickBtnsCount:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_addBbay];
    
    //右箭头
    _rightAllow = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightAllow.frame = CGRectMake(80,36, 15/2, 28/2);
    _rightAllow.tag = 400;
    //        if(DEVICEHEIGHT5){
    //            _rightAllow.frame = CGRectMake(115,36, 50, 50);
    //        }
    
    //        _sexmBtn.tag = 10000;
    _rightAllow.selected = YES;;
    [_rightAllow setShowsTouchWhenHighlighted:YES];
    [_rightAllow setImage:[UIImage imageNamed:@"q"] forState:UIControlStateNormal];
    _rightAllow.contentMode = UIViewContentModeCenter;
    [_rightAllow addTarget:self action:@selector(clickBtnsCount:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:_rightAllow];
    
    //右箭头
    _leftAllow = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftAllow.frame = CGRectMake(_headview.width-80-28/2,36,  15/2, 28/2);
    _leftAllow.tag = 401;
    //        if(DEVICEHEIGHT5){
    //            _leftAllow.frame = CGRectMake(60,0, 50, 50);
    //        }
    
    //        _sexmBtn.tag = 10000;
    _leftAllow.selected = YES;;
    [_leftAllow setShowsTouchWhenHighlighted:YES];
    [_leftAllow setImage:[UIImage imageNamed:@"h"] forState:UIControlStateNormal];
    _leftAllow.contentMode = UIViewContentModeCenter;
    [_leftAllow addTarget:self action:@selector(clickBtnsCount:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:_leftAllow];
    
    //时间
    _timeLabel = [Unit createLable:CGRectMake(0, 30, 100, 13) withName:@"38周20天" withFont:26/2 textAlignt:@"center"];
    _timeLabel.center = CGPointMake(self.width/2,35);
    _timeLabel.textColor =  [UIColor whiteColor];
    [headView addSubview:_timeLabel];
    
    //时间1
    _timeLable1 = [Unit createLable:CGRectMake(0, 30, 150, 12) withName:@"距离我出生还有200天" withFont:24/2 textAlignt:@"center"];
      _timeLable1.font = [UIFont fontWithName:@"Arial" size:10];
    _timeLable1.center = CGPointMake(self.width/2,NH(_timeLabel)+10);
    _timeLable1.textColor =  [UIColor whiteColor];
    [headView addSubview:_timeLable1];
    
    _weightLabel = [Unit createLable:CGRectMake(30, 124, 70, 30) withName:@"男宝体重 3.2~4.6kg" withFont:22/2 textAlignt:@"center"];
    if(DEVICEHEIGHT5) {
        _weightLabel.frame = CGRectMake(30, 124, 70, 30);
//               _weightLabel.frame = CGRectMake(0, 124, self.width/2-114, 30);
        _weightLabel.font = [UIFont fontWithName:@"Arial" size:12/1.17];
    }
//    _weightLabel.backgroundColor = [UIColor redColor];
    _weightLabel.numberOfLines = 0;
//    _weightLabel.adjustsFontSizeToFitWidth = YES;
    _weightLabel.textColor =  [UIColor whiteColor];
    [headView addSubview:_weightLabel];
  //身高
    _heightLabel = [Unit createLable:CGRectMake(_headview.width-39-70, 124, 80, 30) withName:@"男宝身长  41.1~61.1kg" withFont:24/2 textAlignt:@"center"];
    if(DEVICEHEIGHT5) {
        _heightLabel.frame = CGRectMake(_headview.width-30-70, 124, 70, 30);
         _heightLabel.font = [UIFont fontWithName:@"Arial" size:12/1.17];
    }
    _heightLabel.numberOfLines = 0;
    _heightLabel.textColor =  [UIColor whiteColor];
    
    [headView addSubview:_heightLabel];
    
    //中间图
    _centerImage = [Unit createImageView:CGRectMake(self.width/2-114/2, _timeLable1.BottomY+25, 114, 114) isRound:YES];
    _centerImage.image = [UIImage imageNamed:@"nanbao"];
    if(DEVICEHEIGHT5){
        _centerImage.frame = CGRectMake(self.width/2-114/2/1.17, _timeLable1.BottomY+25, 114/1.17, 114/1.17);
        _centerImage.layer.cornerRadius = 48;
        _centerImage.layer.masksToBounds = YES;
        
    }
    [headView addSubview:_centerImage];
    
    _notiView = [[UIView alloc]initWithFrame:CGRectMake(26, _centerImage.BottomY+20, self.width - 26*2, 30)];
    _notiView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    _notiView.layer.masksToBounds = YES;
    _notiView.layer.cornerRadius = 8.0f;
       [headView addSubview:_notiView];
    //提示语
    _notiLabel = [Unit createLable:CGRectMake(10, 10, self.width - 26*2-20, 30) withName:@"妈妈，我满月啦！现在我会用最可爱的表情看着你，向你 卖萌啦！但是我现在一天的大部分时间都是在睡眠中度过 的，睡得更香更甜的话，我会长得更快哦!" withFont:24/2 textAlignt:@"left"];
      _notiLabel.font = [UIFont fontWithName:@"Arial" size:12];
   
  
    _notiLabel.numberOfLines = 0;
    _notiLabel.textColor =  [UIColor colorwithHexString:@"#8A7E7E"];
       [_notiView addSubview:_notiLabel];
//    CGFloat heigh = [Unit heightWithString:_notiLabel.text
//                                      font:_notiLabel.font
//                        constrainedToWidth:_notiLabel.width];
    CGSize textSize = [Unit getLabelSizeFortextFont:FONTFZLTHK14 textLabel:_notiLabel.text];
    _notiLabel.height = textSize.height;
    _notiView.height = _notiLabel.BottomY+10;
    _headview.height =     _notiView.BottomY+20;
    if(DEVICEHEIGHT5){
        _notiLabel.font = [UIFont fontWithName:@"Arial" size:12/1.17];
        _notiView.height = _notiLabel.BottomY+5;
        _headview.height =     _notiView.BottomY+5;
    }

    UIImageView *trang = [Unit createImageView:CGRectMake(80, _notiView.y-30/2, 36/2, 30/2) isRound:NO];
    trang.image = [UIImage imageNamed:@"trangk"];
    [headView addSubview:trang];
 
}

/*
 @property ( nonatomic , strong ) UILabel *weightLabel;
 @property ( nonatomic , strong ) UILabel *heightLabel;
 @property ( nonatomic , strong ) UIImageView *centerImage;
 @property ( nonatomic , strong ) UILabel *notiLabel; */
//设置组数


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MainModel* model = _sectionArray[section];
    NSArray *arr = model.tArr;
    if (model.open) {
        return arr.count;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BPChoiceEDCell *cell = (BPChoiceEDCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeigh;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    BPChoiceEDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[BPChoiceEDCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = COLOR_WHITE;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    
    MainModel* model = _sectionArray[indexPath.section];
    NSArray *arr = model.tArr;
    [cell refreshWithCell:arr[indexPath.row]];
    return cell;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    MainModel *model = _sectionArray[section];
//    if(section == _sectionArray.count-1){
//  
//        return 10;
//    }else{
//        return 0.01;
//    }
//}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 10)];
    footer.backgroundColor = [UIColor colorwithHexString:@"#F1EDED"];
    return footer;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MainModel* model = _sectionArray[section];
    UIView* groupTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    UIButton* titlebut = [[UIButton alloc]initWithFrame:groupTitleView.frame];
    
//    [titlebut setImage:[UIImage imageNamed:@"kuohao"] forState:UIControlStateSelected];
//    [titlebut setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    
        titlebut.tag = section;
    titlebut.backgroundColor = [UIColor clearColor];
    groupTitleView.backgroundColor = [UIColor whiteColor];
    
        NSArray *picArr=  @[@"crown",@"duck",@"car",@"horse",@"bottle"];
    UIImageView *headImage;
    headImage = [Unit createImageView:CGRectMake(20, 5,40, 40) isRound:YES];
    [groupTitleView addSubview:headImage];
    int vale = arc4random() % [picArr count];

    headImage.image =[UIImage imageNamed: [NSString stringWithFormat:@"%@",picArr[section]]];
    headImage.layer.cornerRadius = headImage.width/2;
    
     UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(15,headImage.BottomY+10,SCREENWIDTH-15, 0.5)];
    lineView.backgroundColor = COLOR_9999;
    lineView.alpha = 0.5;
    if(section == _sectionArray.count-1){
        lineView.hidden = YES;
    }
       [groupTitleView addSubview:lineView];
    
      UILabel* titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(NW(headImage)+5,5, self.width-40, 20)];
        [groupTitleView addSubview:titlelabel];
    titlelabel.font =FONTFZLTHK12;
    titlelabel.textColor = COLOR_3333;
    titlelabel.text = model.title;
 

    _allowImage = [Unit createImageView:CGRectMake(self.width - 30, 13,50/2, 50/2) isRound:YES];
    _allowImage.image = [UIImage imageNamed:@"left"];
        [groupTitleView addSubview:_allowImage];
    if (model.open) {//如果是0，就把1赋给字典,打开cell
//        model.open = NO;
        _allowImage.image = [UIImage imageNamed:@"kuohao"];
    }else{//反之关闭cell
//        model.open = YES;
        _allowImage.image = [UIImage imageNamed:@"left"];
    }
 
//    titlelabel.center = CGPointMake(titlelabel.center.x, groupTitleView.center.y);
    [titlebut addTarget:self action:@selector(tapsection:) forControlEvents:UIControlEventTouchUpInside];
    [groupTitleView addSubview:titlebut];
    
    UILabel* introl = [[UILabel alloc]initWithFrame:CGRectMake(NW(headImage)+5, NH(titlelabel), 270, 20)];
    if(DEVICEHEIGHT5){
        introl.width = 220;
    }
    introl.font =FONTFZLTHK11;
    introl.text = model.introLabel;
    introl.textColor = COLOR_6666;
    [groupTitleView addSubview:introl];
    if([introl.text rangeOfString:@"t_"].location !=NSNotFound )//_roaldSearchText
    {
        introl.text= [introl.text stringByReplacingOccurrencesOfString:@"t_" withString:@""];
   
    }
    
    if([introl.text  rangeOfString:@"w_"].location !=NSNotFound )//_roaldSearchText
    {
        introl.text= [introl.text stringByReplacingOccurrencesOfString:@"w_" withString:@""];
    }
    
    return groupTitleView;
}
-(void)tapsection:(UIButton*)sender{

    MainModel* model = _sectionArray[sender.tag];
    if (model.open) {//如果是0，就把1赋给字典,打开cell
        model.open = NO;
        _allowImage.image = [UIImage imageNamed:@"left"];
    }else{//反之关闭cell
        model.open = YES;
        _allowImage.image = [UIImage imageNamed:@"kuohao"];
    }
    [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    
}
#pragma mark  按钮
-(void)clickBtnsCount:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSInteger  jianA = [_dayBir integerValue];
   NSInteger  jianB =  [_dayss integerValue];
   
    NSDate *dateT;
    NSString *timeBloc;
//    countTime = 1;
    countTime = [Unit getUserDefaultsIntForKey:@"countTime"];
    
    if(tag == 400){
#pragma mark  当点击历史时间到0 的时候

        if(jianA == 0){
            btn.userInteractionEnabled = NO;
            return;
        }else{
            btn.userInteractionEnabled = YES;
        }
        jianA--;
        jianB++;
        countTime--;
        _timeLabel.text = [NSString stringWithFormat:@"%ld周%ld天",(long)(jianA/7),(long)(jianA%7)];
          _timeLable1.text = [NSString stringWithFormat:@"距离我出生还有%ld天",jianB ];
        if([stage isEqualToString:@"3"]){
            _timeLabel.text = [NSString stringWithFormat:@"宝宝有%ld个月%ld天",jianA/dayMacro,jianA%dayMacro ];
            
        }
        _dayss = [NSString stringWithFormat:@"%ld",(long)jianB];
       _dayBir = [NSString stringWithFormat:@"%ld",(long)jianA];

        dateT = [NSDate dateByAddingDay:(int)countTime toDate:_destDate];
        timeBloc = [NSString stringWithFormat:@"%@",dateT];
        timeBloc = [timeBloc substringToIndex:10];
        _destDate = dateT;
    }else if (tag == 401){
#pragma mark  当怀孕40周的时候停止点击
        if(jianA == 280){
            btn.userInteractionEnabled = NO;
            return;
        }else{
         btn.userInteractionEnabled = YES;
        }
        jianA++;
        jianB--;
        countTime ++;
        _timeLabel.text = [NSString stringWithFormat:@"%ld周%ld天",(long)(jianA/7),(long)(jianA%7)];
           _timeLable1.text = [NSString stringWithFormat:@"距离我出生还有%ld天",jianB ];
        if([stage isEqualToString:@"3"]){
            _timeLabel.text = [NSString stringWithFormat:@"宝宝有%ld个月%ld天",jianA/dayMacro,jianA%dayMacro ];
        }
        
        _dayss = [NSString stringWithFormat:@"%ld",(long)jianB];
         _dayBir = [NSString stringWithFormat:@"%ld",(long)jianA];
        dateT = [NSDate dateByAddingDay:(int)countTime toDate:_destDate];
          timeBloc = [NSString stringWithFormat:@"%@",dateT];
        timeBloc = [timeBloc substringToIndex:10];
       _destDate = dateT;
  
    }else if (tag == 402){
      
        if(_block){
            _block((int)tag);
        }
    }

    [Unit saveUserDefaultsInt:countTime forKey:@"countTime"];
    
    if(_delegage && [_delegage respondsToSelector:@selector(RefreshData:)]){
        [_delegage RefreshData:timeBloc];
    }

}
//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
-(void)ClickToday{
    NSString *day = [self getCurrentTime];
    day = [day substringToIndex:10];
       [Unit removeUserDefaultsObjForKey:@"countTime"];
      [Unit saveUserDefaultsInt:1 forKey:@"countTime"];
    if(_delegage && [_delegage respondsToSelector:@selector(RefreshData:)]){
        [_delegage RefreshData:day];
    }
}
  @end
