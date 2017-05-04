//
//  BPMainNoCView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/13.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理 跳转主页
@protocol ClickChoiceDelegte <NSObject>

@optional
-(void)ClickChoiceVC;
-(void)ClickChoiceSearch;
-(void)ClickClass:(NSString *)sort imageName:(NSString *)imagenName title:(NSString *)title;

@end
@interface BPMainNoCView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithFrame:(CGRect)frame;

@property ( nonatomic , strong ) UIView *headView;
//图片
@property ( nonatomic , strong ) UIImageView *headImage;
//搜索
//图片
@property ( nonatomic , strong ) UIImageView *searchImage;

@property ( nonatomic , strong ) UITextField *searchTX;
//进入护肤
@property ( nonatomic , strong ) UIButton *hufuBtn;
//工具
@property ( nonatomic , strong ) UIView *midView;
//按钮
@property ( nonatomic , strong ) UIButton *catoBtn;

//下面的view
@property ( nonatomic , strong ) UIView *bottomView;
//下面那个按钮
@property ( nonatomic , strong ) UIButton *startBtn;

//代理
@property ( nonatomic , weak ) id <ClickChoiceDelegte> delegate;

@property ( nonatomic , strong ) UICollectionView *mainCollectionView;
@property ( nonatomic , strong ) NSMutableArray    *imageArr;;

@property ( nonatomic , strong ) NSString *tagStr;

@property ( nonatomic , strong ) NSDictionary *dataDic;
@property (nonatomic,strong)NSMutableArray *sectionArray;

@property ( nonatomic , strong ) UIButton *searchBtn;

-(instancetype)initWithFrameH:(CGRect)frame;
@end
