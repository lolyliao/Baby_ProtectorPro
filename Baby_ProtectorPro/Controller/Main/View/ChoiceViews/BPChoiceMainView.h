//
//  BPChoiceMainView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/17.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMainNoCView.h"

@protocol RefreshDataDelegate <NSObject>
@optional
-(void)RefreshData:(NSString*)time;//时间选择


@end

@interface BPChoiceMainView : UIView<UITableViewDelegate,UITableViewDataSource>

typedef void (^ClickBtnTag)(int tag);
typedef void (^ClickTimeTag)(NSString *time);

@property ( nonatomic , strong ) UIScrollView *myScrollview;
//hearder
@property ( nonatomic , strong ) UITableView *myTableView;
@property ( nonatomic , strong ) UIView * headview;
@property ( nonatomic , strong ) UIButton *today;
@property ( nonatomic , strong ) UIButton *addBbay;
@property ( nonatomic , strong ) UIButton *rightAllow;
@property ( nonatomic , strong ) UIButton *leftAllow;
@property ( nonatomic , strong ) UILabel *timeLabel;
@property ( nonatomic , strong ) UILabel *timeLable1;
@property ( nonatomic , strong ) UILabel *weightLabel;
@property ( nonatomic , strong ) UILabel *heightLabel;
@property ( nonatomic , strong ) UIImageView *centerImage;
@property ( nonatomic , strong ) UIView * notiView;
@property ( nonatomic , strong ) UILabel *notiLabel;//每日文字

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@property ( nonatomic , strong ) NSMutableArray *bkClassArr;

@property ( nonatomic , strong ) NSDictionary *dataDic;

@property ( nonatomic , strong )    BPMainNoCView*footView;

@property ( nonatomic , strong ) NSString * context;

@property ( nonatomic , copy ) ClickBtnTag block;
@property ( nonatomic , copy ) ClickTimeTag blockTime;

@property ( nonatomic , weak ) id<RefreshDataDelegate> delegage;

@end
