//
//  BPAddBabyView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPAddBabyView.h"

@implementation BPAddBabyView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;
        [self creatView];
    }
    return self;
}
-(void)creatView{
#pragma mark 宝宝昵称
    _nickName = [Unit createLable:CGRectMake(0, 5, 100, 30) withName:@"宝宝昵称:" withFont:16 textAlignt:@"center"];
    _nickName.textColor =  [UIColor colorwithHexString:@"#333333"];
    _nickName.font = [UIFont fontWithName:@"Arial" size:15];
    [self addSubview:_nickName];
    
    
    _biaotiTX = [Unit createTextField:CGRectMake(SCREENWIDTH-150, 10, 150, 30) withPlaceholder:@"请输入宝宝昵称"];
    [self addSubview:_biaotiTX];
    [_biaotiTX setValue:[UIColor colorwithHexString:@"#999999"]  forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_nickName)+5, SCREENWIDTH, 0.5)];
    lineView.backgroundColor =[UIColor colorwithHexString:@"#666666"];
    lineView.alpha = 0.3;
    [self addSubview:lineView];
    
#pragma mark 宝宝性别
    _sexlabel = [Unit createLable:CGRectMake(0, NH(lineView)+5, 100, 30) withName:@"宝宝性别:" withFont:16 textAlignt:@"center"];
    _sexlabel.textColor =  [UIColor colorwithHexString:@"#333333"];
    _sexlabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self addSubview:_sexlabel];
    

    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_sexlabel)+5, SCREENWIDTH, 0.5)];
    lineView1.backgroundColor =[UIColor colorwithHexString:@"#666666"];
    lineView1.alpha = 0.3;
    [self addSubview:lineView1];
#pragma mark 出生日期
    _birLabel = [Unit createLable:CGRectMake(0, NH(lineView1)+5, 100, 30) withName:@"出生日期 :" withFont:16 textAlignt:@"center"];
    _birLabel.textColor =  [UIColor colorwithHexString:@"#333333"];
    _birLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self addSubview:_birLabel];
    

    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_birLabel)+5, SCREENWIDTH, 0.5)];
    lineView2.backgroundColor =[UIColor colorwithHexString:@"#666666"];
    lineView2.alpha = 0.3;
    [self addSubview:lineView2];
    
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _okBtn.frame = CGRectMake(70, self.BottomY - 70, (130/2) ,(86/2));
    _okBtn.center = CGPointMake(self.width/2.0,NH(lineView2)+40);
    [_okBtn setBackgroundImage:[UIImage imageNamed:@"OKmom"] forState:UIControlStateNormal];
    [self addSubview:_okBtn];
    
    _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dateBtn.frame = CGRectMake(0, NH(lineView1),self.width-40 ,(86/2));
    _dateBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [_dateBtn setTitleColor:[UIColor colorwithHexString:@"#333333"] forState:UIControlStateNormal];
    if(DEVICEHEIGHT5){
//        [_dateBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 200, 10, -10)];
    }
//    _dateBtn.backgroundColor = [UIColor yellowColor];
    [self addSubview:_dateBtn];
    [_dateBtn addTarget:self action:@selector(Clickdate) forControlEvents:UIControlEventTouchUpInside];
    
    _allowImage = [Unit createImageView:CGRectMake(NW(_dateBtn)+10, NH(lineView1)+15, 28/2, 24/2) isRound:NO];
    _allowImage.image = [UIImage imageNamed:@"allowxia"];
    [self addSubview:_allowImage];
}
-(void)Clickdate{
    if(_block){
        _block();
    }
}
@end
