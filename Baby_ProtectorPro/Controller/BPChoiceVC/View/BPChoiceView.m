//
//  BPChoiceView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPChoiceView.h"

@implementation BPChoiceView

-(instancetype)initWithFrame:(CGRect)frame{

    if(self){
        self = [super initWithFrame:frame];
        
        /**
         *  _notiLabel1实例化
         * param nil;
         */
        _notiLabel1 =  [Unit createLable:CGRectMake(0, 20, self.width, 30*autoSizeScaleY) withName:@"请选择您的阶段" withFont:11 textAlignt:@"center" ];
        _notiLabel1.font = FONTFZLTHK12;
        _notiLabel1.center = CGPointMake(self.width/2, 20);
        [self addSubview:_notiLabel1];
        /**
         *  _notiLabel2实例化
         * param nil;
         */
        _notiLabel2 =  [Unit createLable:CGRectMake(0, _notiLabel1.BottomY+20, self.width, 30) withName:@"让我们为您提供更贴心的百科全书" withFont:13 textAlignt:@"center"];
         _notiLabel2.textAlignment = NSTextAlignmentCenter;
        _notiLabel2.font = FONTFZLTHK13;
        _notiLabel2.center = CGPointMake(self.width/2, _notiLabel1.BottomY+20);
        [self addSubview:_notiLabel2];
        /**
         *  按钮选择
         * param nil;
         */
        NSArray *picArr=  @[@"choose-1",@"choose-2",@"choose-3"];
        for(int i = 0;i<= 2;i++){
            
            _choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _choiceBtn.frame = CGRectMake(70, _notiLabel2.BottomY+20*i+(72/2*i+100), (374/2)*autoSizeScaleX ,(86/2)*autoSizeScaleY);
            _choiceBtn.center = CGPointMake(self.width/2.0,_notiLabel2.BottomY+40*i+((86/2)*autoSizeScaleY*i+60));
            [_choiceBtn setBackgroundImage:[UIImage imageNamed:picArr[i]] forState:UIControlStateNormal];
            _choiceBtn.tag = i;
            [_choiceBtn addTarget:self action:@selector(ClickToanno:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self addSubview:_choiceBtn];
        }
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.frame = CGRectMake(0, _choiceBtn.BottomY+40, self.width ,40);
        //        _skipBtn.frame = CGRectMake(0,200, self.width ,40);
        _skipBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_skipBtn setTitle:@"暂时跳过" forState:UIControlStateNormal];
        _skipBtn.titleLabel.font =FONTFZLTHK16;
        [_skipBtn setTitleColor:COLOR_LIGHTCOLOR forState:UIControlStateNormal];
        [self addSubview:_skipBtn];
//        _skipBtn.backgroundColor = [UIColor redColor];
        [_skipBtn addTarget:self action:@selector(Clickmain) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    return self;
}
-(void)ClickToanno:(UIButton *)btn{
    
    int tags = (int)btn.tag;
    
    if(_block){
        _block(tags);
    }

}
#pragma mark 跳转主页
-(void)Clickmain{
    if(_delegate && [_delegate respondsToSelector:@selector(ClickMain)]){
        [_delegate  ClickMain];
    }
}
#pragma mark  准备怀孕view
-(instancetype)initWithFrameWithPre:(CGRect)frame;
{
    if(self){
        self = [super initWithFrame:frame];
        // 按钮
        _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _preBtn.frame = CGRectMake(70, 35/2, (374/2)*autoSizeScaleX ,(86/2)*autoSizeScaleY);
        _preBtn.center = CGPointMake(self.width/2.0,self.x+35/2);
        [_preBtn setBackgroundImage:[UIImage imageNamed:@"choose-1"] forState:UIControlStateNormal];
        [self addSubview:_preBtn];
        
        [self creatLabel];

    }
    return self;

}
-(void)creatLabel{
    NSArray *picArr=  @[@"上次月经开始的时间",@"平均周期天数",@"经期天数"];
    for(int i = 0;i<= 2;i++){
        _preLabel = [[UILabel alloc]init];;
        _preLabel.frame = CGRectMake(70, _notiLabel2.BottomY+20*i+(72/2*i+100), (374/2)*autoSizeScaleX ,(24/2)*autoSizeScaleY);
        _preLabel.center = CGPointMake(self.width/2.0,_preBtn.BottomY+80*i+((24/2)*autoSizeScaleY*i+50));
        _preLabel.text = picArr[i] ;
        _preLabel.textColor =  [UIColor colorwithHexString:@"#666666"];
        _preLabel.font = FONTFZLTHK14;
        _preLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_preLabel];
        
        _preText = [[UITextField alloc]init];
        _preText.borderStyle = UITextBorderStyleNone;
        [_preText setBackground:[UIImage imageNamed:@"WechatIMG10"]];
        _preText.frame = CGRectMake(0, _notiLabel2.BottomY+20*i+(72/2*i+100), (374/2)*autoSizeScaleX ,(65/2)*autoSizeScaleY);
        _preText.textAlignment = NSTextAlignmentCenter;
        _preText.delegate = self;
        _preText.center = CGPointMake(self.width/2.0,_preLabel.BottomY+30);
        _preText.tag = 200+i;
          _preText.clearsOnBeginEditing = YES;
                [self addSubview:_preText];
        if(i == 0){
//            _preText.hidden = YES;
            _preText.enabled = NO;
            _datesbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _datesbtn.frame = _preText.frame;
            _datesbtn.backgroundColor = [UIColor clearColor];
            [_datesbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _datesbtn.tag = 300;
            [_datesbtn addTarget:self action:@selector(ClickDtes:) forControlEvents:UIControlEventTouchUpInside];
//            [self insertSubview:_datesbtn atIndex:0];
            [self insertSubview:_datesbtn aboveSubview:_preText];
        }else{
          _preText.keyboardType = UIKeyboardTypePhonePad;
        }
    }
}
#pragma mark 时间选择
-(void)ClickDtes:(UIButton *)btn{
    int tag =(int) btn.tag;
    if(_delegate && [_delegate respondsToSelector:@selector(ClickDate:)]){
        [_delegate ClickDate:tag];
    }
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    NSString *cycle;
    NSString *days;
    if(tag == 200){
    }else if (tag == 201){
        NSLog(@"平均周期%@",textField.text);
        cycle = textField.text;
        if(_blockTXs){
            _blockTXs(cycle);
        }
    }else if (tag == 202){
        NSLog(@"经期天数%@",textField.text);
        days = textField.text;
        if(_blockTX){
            _blockTX(days);
        }
    }else if (tag == 203){
        NSLog(@"宝宝小名==%@",textField.text);
        if(_blockTX){
            _blockTX(textField.text);
        }
    }
//    if(_blockTX){
//        _blockTX(cycle);
//    }
    
    
}
/**
 *  怀孕
 * param nil;
 */
-(instancetype)initWithFrameWithPrehad:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];

        
        [self creathuaiLabel];
        
    }
    return self;

}
-(void)creathuaiLabel{

    NSLog(@"适配器高度是%f",SCREENHEIGHT);
        // 按钮
    _huaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _huaiBtn.frame = CGRectMake(70, 35/2, (374/2)*autoSizeScaleX ,(86/2)*autoSizeScaleY);
        NSLog(@"适配器高度是%f", (86/2)*autoSizeScaleY);
    _huaiBtn.center = CGPointMake(self.width/2.0,self.x+35/2);
    [_huaiBtn setBackgroundImage:[UIImage imageNamed:@"choose-2"] forState:UIControlStateNormal];
    [self addSubview:_huaiBtn];
    
    _huaiLabel = [Unit createLable:CGRectMake(0, _huaiBtn.BottomY+88/2, SCREENWIDTH, 86/2) withName:@"你的预产期" withFont:28/2 textAlignt:@"center"];
    _huaiLabel.textColor =  [UIColor colorwithHexString:@"#666666"];
        _huaiLabel.center = CGPointMake(self.width/2,_huaiBtn.BottomY+88/2);
    _huaiLabel.font = FONTFZLTHK14;
        [self addSubview:_huaiLabel];

#pragma mark 预产期
    _yuchanBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _yuchanBtn.frame = CGRectMake(0, 0, (374/2)*autoSizeScaleX ,(65/2)*autoSizeScaleY);
    _yuchanBtn.center = CGPointMake(self.width/2.0,_huaiLabel.BottomY+28/2);
    [_yuchanBtn setBackgroundImage:[UIImage imageNamed:@"WechatIMG10"] forState:UIControlStateNormal];
    _yuchanBtn.layer.cornerRadius = 8;
    _yuchanBtn.layer.masksToBounds = YES;
        _yuchanBtn.tag = 301;
     [_yuchanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_yuchanBtn addTarget:self action:@selector(ClickDtes:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yuchanBtn];
    
    
    _notkonwBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _notkonwBtn.frame = CGRectMake(70, 35/2, (374/2)*autoSizeScaleX ,(65/2)*autoSizeScaleY);
    _notkonwBtn.center = CGPointMake(self.width/2.0,_yuchanBtn.BottomY+136/2);
    _notkonwBtn.backgroundColor = [UIColor colorwithHexString:@"#e6e6e6"];
    [_notkonwBtn setTitle:@"不知道预产期?" forState:UIControlStateNormal];
    _notkonwBtn.titleLabel.textColor = [UIColor colorwithHexString:@"#333333"];
    _notkonwBtn.layer.cornerRadius = 8;
    _notkonwBtn.layer.masksToBounds = YES;
    [_notkonwBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_notkonwBtn];
    //末次
    _lastLabel = [Unit createLable:CGRectMake(0, _notkonwBtn.BottomY+98/2, self.width, 86/2) withName:@"末次月经开始时间" withFont:28/2 textAlignt:@"center"];
        _lastLabel.center = CGPointMake(self.width/2,_notkonwBtn.BottomY+98/2);
    _lastLabel.textColor =  [UIColor colorwithHexString:@"#666666"];
    _lastLabel.font = FONTFZLTHK14;
    _lastLabel.hidden = YES;
    [self addSubview:_lastLabel];

#pragma mark 不知道预产期
    _yuBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _yuBtn.frame = CGRectMake(0, 0, (374/2)*autoSizeScaleX ,(65/2)*autoSizeScaleY);
    _yuBtn.center =CGPointMake(self.width/2.0,_lastLabel.BottomY+28/2);
    [_yuBtn setBackgroundImage:[UIImage imageNamed:@"WechatIMG10"] forState:UIControlStateNormal];
    _yuBtn.layer.cornerRadius = 8;
    _yuBtn.layer.masksToBounds = YES;
     [_yuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _yuBtn.tag = 302;
    [_yuBtn addTarget:self action:@selector(ClickDtes:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_yuBtn];
     _yuBtn.hidden = YES;

}

-(void)clickBtn{
      [UIView animateWithDuration:1 animations:^{
              _yuBtn.hidden = NO;
           _lastLabel.hidden = NO;
          
      }];

}
#pragma mark 宝妈
-(instancetype)initWithFrameWithMom:(CGRect)frame;
{
    if(self){
        self = [super initWithFrame:frame];
        
        
        [self creatMomLabel];
        
    }
    return self;
    
}
-(void)creatMomLabel{
    _momBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _momBtn.frame = CGRectMake(70, 35/2, (374/2)*autoSizeScaleX ,(86/2)*autoSizeScaleY);
    _momBtn.center = CGPointMake(self.width/2.0,self.x+35/2);
    [_momBtn setBackgroundImage:[UIImage imageNamed:@"choose-3"] forState:UIControlStateNormal];
    [self addSubview:_momBtn];
    
    NSArray *picArr=  @[@"宝宝小名",@"宝宝出生日期"];
    for(int i = 0;i< 2;i++){
        _momLabel = [[UILabel alloc]init];;
        _momLabel.frame = CGRectMake(70, _momBtn.BottomY+20*i+(72/2*i+100), (374/2)*autoSizeScaleX ,(24/2)*autoSizeScaleY);
        _momLabel.center = CGPointMake(self.width/2.0,_momBtn.BottomY+80*i+((24/2)*autoSizeScaleY*i+80));
        if(DEVICEHEIGHT5){
          _momLabel.center = CGPointMake(self.width/2.0,_momBtn.BottomY+80*i+((24/2)*i+60));
        }
        _momLabel.text = picArr[i] ;
        
        _momLabel.textColor =  [UIColor colorwithHexString:@"#666666"];
        _momLabel.font =FONTFZLTHK14;
        _momLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_momLabel];
        
        _momText = [[UITextField alloc]init];
        _momText.textAlignment = NSTextAlignmentCenter;
        _momText.borderStyle = UITextBorderStyleNone;
        [_momText setBackground:[UIImage imageNamed:@"WechatIMG10"]];
        _momText.frame = CGRectMake(0, _notiLabel2.BottomY+20*i+(72/2*i+100), (374/2)*autoSizeScaleX ,(65/2)*autoSizeScaleY);
        _momText.delegate = self;
        _momText.center = CGPointMake(self.width/2.0,_momLabel.BottomY+30);
             [self addSubview:_momText];
        if(i == 0){
            _momText.tag = 203;
        }else{
            _momText.enabled = NO;
            _monTXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _monTXBtn.frame = _momText.frame;
            _monTXBtn.backgroundColor = [UIColor clearColor];
            [_monTXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _monTXBtn.tag = 304;
                 [_monTXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_monTXBtn addTarget:self action:@selector(ClickDtes:) forControlEvents:UIControlEventTouchUpInside];
            [self insertSubview:_monTXBtn aboveSubview:_momText];
        }
        
        
   
    }
    _sexLabel = [Unit createLable:CGRectMake(0, _notkonwBtn.BottomY+98/2, self.width, 86/2) withName:@"宝宝性别" withFont:28/2 textAlignt:@"center"];
    _sexLabel.center = CGPointMake(self.width/2,_momText.BottomY+88/2);
    _sexLabel.textColor =  [UIColor colorwithHexString:@"#666666"];
    _sexLabel.font = FONTFZLTHK14;
    [self addSubview:_sexLabel];
    

//boy
    UIView *boyView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_sexLabel), self.width/2, 50)];
//    boyView.backgroundColor= [ UIColor redColor];
    [self addSubview:boyView];
    
    _sexmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sexmBtn.frame = CGRectMake(70,0, 50, 50);
    if(DEVICEHEIGHT5){
       _sexmBtn.frame = CGRectMake(60,0, 50, 50);
    }
    [boyView addSubview:_sexmBtn];
    _sexmBtn.tag = 10000;
    _sexmBtn.selected = YES;;
    [_sexmBtn setShowsTouchWhenHighlighted:YES];
    [_sexmBtn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [_sexmBtn setImage:[UIImage imageNamed:@"yx"] forState:UIControlStateSelected];
    _sexBtn.contentMode = UIViewContentModeCenter;

    self.selectedBtn = _sexmBtn;
    [_sexmBtn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    _sexmlabel = [Unit createLable:CGRectMake(NW(_sexmBtn), 0, 50, 28/2) withName:@"Boy" withFont:28/2 textAlignt:@"center"];
    _sexmlabel.center = CGPointMake(NW(_sexmBtn),(boyView.height/2)-28/2/2/2/2);
    _sexmlabel.textColor =  [UIColor colorwithHexString:@"#666666"];
    _sexmlabel.font = FONTFZLTHK14;
    [boyView addSubview:_sexmlabel];
    
        //girl
    UIView *girlView = [[UIView alloc]initWithFrame:CGRectMake(NW(boyView), NH(_sexLabel), self.width/2, 50)];
//    girlView.backgroundColor= [ UIColor yellowColor];
    [self addSubview:girlView];
    
        _ladBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ladBtn.frame = CGRectMake(8, 0,50, 50);
        [girlView addSubview:_ladBtn];
    
    _ladBtn.tag = 10001;
    [_ladBtn setShowsTouchWhenHighlighted:YES];
    [_ladBtn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [_ladBtn setImage:[UIImage imageNamed:@"yx"] forState:UIControlStateSelected];
    _ladBtn.contentMode = UIViewContentModeCenter;
    [_ladBtn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
        
        _laylabel = [Unit createLable:CGRectMake(_ladBtn.RightX+20, _notkonwBtn.BottomY+98/2, self.width/2, 28/2) withName:@"Girl" withFont:28/2 textAlignt:@"center"];
    _laylabel.center = CGPointMake(NW(_ladBtn),(boyView.height/2)-28/2/2/2/2);
        _laylabel.textColor =  [UIColor colorwithHexString:@"#666666"];
    _laylabel.font = FONTFZLTHK14;
        [girlView addSubview:_laylabel];

}
-(void)clickBtns:(UIButton *)btn{
 btn.selected = !btn.selected;
    NSString *sex;
    if(btn.tag == 10000){
        if (btn != self.selectedBtn){
            self.selectedBtn.selected = NO;
            self.selectedBtn = btn;
        }
        self.selectedBtn.selected = YES;
        NSLog(@"男孩");
        sex = @"1";
    }else{
        if (btn != self.selectedBtn)
        {
       
            self.selectedBtn.selected = NO;
            self.selectedBtn = btn;
        }
        self.selectedBtn.selected = YES;
            NSLog(@"女孩");
        sex = @"2";
    }

    if(_blockTXs){
        _blockTXs(sex);
    }
}
@end
