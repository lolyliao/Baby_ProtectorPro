//
//  BPMomEXView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/26.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMomEXView.h"

@implementation BPMomEXView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titles];
         [self addSubview:self.showImage];
         [self addSubview:self.detaislLabel];
  
         [self.showImage addSubview:self.headImage];
               [self.showImage addSubview:self.nameLabel];
         [self.showImage addSubview:self.timeLabel];
         [self addSubview:self.lineView];
         [self addSubview:self.zanImage];
         [self addSubview:self.notiLabel];
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    NSString *head = [dic[@"headimgurl"] isKindOfClass:[NSNull class]] ? @"" : dic[@"headimgurl"] ;
    NSString *title = [dic[@"title"] isKindOfClass:[NSNull class]] ? @"" : dic[@"title"] ;
    NSString *word = [dic[@"word"] isKindOfClass:[NSNull class]] ? @"" : dic[@"word"] ;
    NSString *time = [dic[@"time"] isKindOfClass:[NSNull class]] ? @"" : dic[@"time"] ;
    NSString *name = [dic[@"name"] isKindOfClass:[NSNull class]] ? @"" : dic[@"name"] ;
    NSInteger love =[ [dic[@"love"] isKindOfClass:[NSNull class]] ? @"" : dic[@"love"] integerValue];
     NSInteger stage =[ [dic[@"stage"] isKindOfClass:[NSNull class]] ? @"" : dic[@"stage"] integerValue];
    NSString *currens = [Unit timeWithTimeIntervalString:time];
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@""]];
    
    _titles.text = title;
    if(stage == 1){
    _nameLabel.text = [NSString stringWithFormat:@"%@   (待产中)",name];
    }else if (stage == 2){
       _nameLabel.text = [NSString stringWithFormat:@"%@   (怀孕中)",name];
    }else{
     _nameLabel.text = [NSString stringWithFormat:@"%@   (宝妈)",name];
    }
    
    _timeLabel.text = currens;
    _detaislLabel.text = word;
    _detaislLabel.textColor = COLOR_6666;
    //获取内容高度 判断高度的大小 改变其他控件的坐标
      CGSize textSize = [Unit getLabelSizeFortextFont:FONTFZLTHK14 textLabel:_detaislLabel.text];

    _detaislLabel.height = textSize.height;
    _lineView.y = _detaislLabel.BottomY+10;
    _zanImage.y = _lineView.BottomY+10;
    _notiLabel .y= _zanImage.BottomY;
     self.height = _notiLabel.BottomY+10;
    
    
    if(love == 1){
        [_zanImage setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }else{
             [_zanImage setImage:[UIImage imageNamed:@"dianzanNo"] forState:UIControlStateNormal];
    }
    
}

-(UILabel *)titles{
    if(!_titles){
        _titles = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.width, 20)];
        _titles.font =FONTFZLTHK12;
        _titles.textColor = [UIColor colorwithHexString:@"#333333"];
        _titles.text = @"多一些关爱，让小孩感受到你的存在";
        _titles.textAlignment = NSTextAlignmentCenter;
    }
    return _titles;
}
#pragma mark 头像
-(UIImageView *)showImage{
    if(!_showImage){
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-190, 42, 190, 54)];
        _showImage.image = [UIImage imageNamed:@"txbj"];
    }
    return _showImage;
}
#pragma mark 头像
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [Unit createImageView:CGRectMake(8, 5, 44, 44) isRound:YES];
        _headImage.image = [UIImage imageNamed:@"test3"];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, 10, 100, 20)];
        _nameLabel.font =FONTFZLTHK13;
        _nameLabel.textColor = [UIColor colorwithHexString:@"#6699CC"];
        _nameLabel.text = @"jucy";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, NH(_nameLabel), 100, 20)];
        _timeLabel.font =FONTFZLTHK11;
        _timeLabel.textColor = COLOR_9999;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.text = @"2017-4-25";
    }
    return _timeLabel;
}
#pragma mark  title
-(UILabel *)detaislLabel{
    if(!_detaislLabel){
        _detaislLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, NH(_showImage)+10, self.width-20, 20)];
        _detaislLabel.font =FONTFZLTHK12;
        _detaislLabel.textColor = COLOR_6666;
        _detaislLabel.textAlignment = NSTextAlignmentLeft;
        _detaislLabel.backgroundColor = [UIColor whiteColor];
        _detaislLabel.layer.borderColor = [[UIColor clearColor]CGColor];
        _detaislLabel.text = @"我家小孩睡前也经常哭闹，刚开始时我老公叫我别管他 让他自己哭，你说当妈的怎么忍心让自己的小孩哭成这 样，就因为这事我跟我老公还打了一架。 小孩刚出生，一切都是这么陌生，小孩的哭闹就是想寻 求帮助，这是他一生中最无助的时刻，这时候是最需要 有人去关心他的，请不要让小孩伤心(；′⌒`)。 或许小孩睡前会耽误你一些时间，但请在他无助的时候 给他一些关怀，既然选择生下小孩，那么请你也应该学 会如何去适应小孩";
        _detaislLabel.numberOfLines = 0;
    }
    return _detaislLabel;
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView= [[UIView alloc]initWithFrame:CGRectMake(self.width/2-100/2, NH(_detaislLabel)+10,100, 0.5)];
        _lineView.backgroundColor =COLOR_6666;
    }
    return _lineView;
}
-(UIButton *)zanImage{
    if(!_zanImage){
        _zanImage = [Unit creatButton:CGRectMake(NW(_timeLabel)+50, NH(_lineView)+10, 21, 17) withName:@"" normalImg:[UIImage imageNamed:@"dianzanNo"] highlightImg:nil selectImg:nil];
        _zanImage.frame = CGRectMake(70, _lineView.BottomY+10,21, 17);
        _zanImage.center = CGPointMake(self.width/2.0,_lineView.BottomY+20);
        [_zanImage addTarget:self action:@selector(clickZanAndCol:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanImage;
}

-(UILabel *)notiLabel{
    if(!_notiLabel){
        _notiLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, NH(_zanImage)+10, SCREENWIDTH, 20)];
        _notiLabel.font =FONTFZLTHK11;
        _notiLabel.textColor = COLOR_9999;
        _notiLabel.textAlignment = NSTextAlignmentCenter;
        _notiLabel.text = @"点亮爱心，为妈妈鼓掌";
    }
    return _notiLabel;
}
-(void)clickZanAndCol:(UIButton *)sender{
    if(_block){
        _block(sender);
    }
}

@end
