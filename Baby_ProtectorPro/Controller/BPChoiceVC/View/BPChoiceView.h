//
//  BPChoiceView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPChoiceVCViewController.h"
#import "BPReadPreViewController.h"

/**
 *  block
 * param 传值;
 */
typedef void (^ClickBtnTag)(int tag);
//备孕传值
typedef void (^ChoiceWithTx)(NSString *cycle);
//备孕传值
typedef void (^ChoiceWithTx)(NSString *days);
//代理 跳转主页
@protocol ClickMainDelegte <NSObject>
@optional
-(void)ClickMain; //跳转主页选择
-(void)ClickDate:(int)tag;//时间选择


@end
@interface BPChoiceView : UIView<UITextFieldDelegate>



//  备孕 怀孕，宝妈选择
@property ( nonatomic , strong ) UIButton*  choiceBtn;
/**
 *  都不选择
 * param nil;
 */
@property ( nonatomic , strong ) UIButton *skipBtn;
/**
 *  label1  提示
 * param nil;
 */
@property ( nonatomic , strong ) UILabel * notiLabel1;
/**
 *  label2  提示
 * param nil;
 */
@property ( nonatomic , strong ) UILabel * notiLabel2;

@property ( nonatomic , weak ) BPChoiceVCViewController * choiceself;
@property ( nonatomic , weak ) BPReadPreViewController * readSelf;

@property ( nonatomic , copy ) ClickBtnTag block;

- (void)addTapBlock:(ClickBtnTag)block;
//备孕传值
@property ( nonatomic , copy ) ChoiceWithTx blockTX;
//备孕传值
@property ( nonatomic , copy ) ChoiceWithTx blockTXs;

- (void)addTXBlock:(ChoiceWithTx)block;

-(instancetype)initWithFrame:(CGRect)frame;

#pragma mark 备孕
-(instancetype)initWithFrameWithPre:(CGRect)frame;
@property ( nonatomic , strong ) UIButton*  preBtn;
@property ( nonatomic , strong ) UITextField*  preText;
@property ( nonatomic , strong ) UILabel*  preLabel;
@property ( nonatomic , strong ) UIButton *datesbtn;


#pragma mark 怀孕
-(instancetype)initWithFrameWithPrehad:(CGRect)frame;
@property ( nonatomic , strong ) UIButton*  huaiBtn;
@property ( nonatomic , strong ) UIButton*  yuchanBtn;
@property ( nonatomic , strong ) UIButton*  yuBtn;
@property ( nonatomic , strong ) UILabel*  huaiLabel;
@property ( nonatomic , strong ) UIButton*  sexBtn;
@property ( nonatomic , strong ) UIButton*  notkonwBtn;
@property ( nonatomic , strong ) UITextField*  lastText;
@property ( nonatomic , strong ) UILabel*  lastLabel;

#pragma mark 宝妈
-(instancetype)initWithFrameWithMom:(CGRect)frame;
@property ( nonatomic , strong ) UIButton*  momBtn;
@property ( nonatomic , strong ) UITextField*  momText;
@property ( nonatomic , strong ) UILabel*  momLabel;
@property ( nonatomic , strong ) UILabel*  sexLabel;
@property ( nonatomic , strong ) UIButton*  sexmBtn;
@property ( nonatomic , strong ) UILabel*  sexmlabel;
@property ( nonatomic , strong ) UIButton*  ladBtn;
@property ( nonatomic , strong ) UILabel*  laylabel;
@property (nonatomic,weak)UIButton *selectedBtn;
@property ( nonatomic , strong ) UIButton*  monTXBtn;

//代理
@property ( nonatomic , weak ) id <ClickMainDelegte> delegate;
@end
