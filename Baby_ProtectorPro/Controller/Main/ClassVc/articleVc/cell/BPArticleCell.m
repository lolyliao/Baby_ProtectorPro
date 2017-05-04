//
//  BPArticleCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPArticleCell.h"

@implementation BPArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self creatTile];
    }
    return self;
}

-(void)creatTile{
//    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,10, self.width-10, 20)];
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font =FONTFZLTHK12;
    _titleLabel.textColor = COLOR_6666;
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
}

-(void)refreshWithData:(NSString *)str{


    NSString *titles =  [str isKindOfClass:[NSNull class]] ? @"" : str;
    if([titles rangeOfString:@"t_"].location !=NSNotFound )//_roaldSearchText
    {
                titles = [titles stringByReplacingOccurrencesOfString:@"t_" withString:@""];
        _titleLabel.font =FONTFZLTHK13;
        _titleLabel.textColor = [UIColor colorwithHexString:@"#663333"];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if([titles  rangeOfString:@"w_"].location !=NSNotFound )//_roaldSearchText
    {
          titles= [titles stringByReplacingOccurrencesOfString:@"w_" withString:@"   "];
        _titleLabel.font =FONTFZLTHK11;
        _titleLabel.textColor = COLOR_6666;
  _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    _titleLabel.text = titles;
    //获取内容高度 判断高度的大小 改变其他控件的坐标
//    CGFloat heigh = [Unit heightWithString:str
//                                      font:FONTFZLTHK13
//                        constrainedToWidth:SCREENWIDTH];
    CGSize textSize = [Unit getLabelSizeFortextFont:FONTFZLTHK13 textLabel:_titleLabel.text];
    self.titleLabel.height = textSize.height;
    _cellHeigh = self.titleLabel.BottomY;
}
- (void)setModel:(BPModel *)model
{
    _model = model;
    
    NSString *currens = [Unit timeWithTimeIntervalString:model.timeLabel];
    NSString *curren = [Unit compareCurrentTime:currens];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@""]];
    _titles.text = model.titles;
    _detaislLabel.text =model.detaislLabel;
    _zanLabel.text =  [NSString stringWithFormat:@"%ld",model.zanLabel];
    _pinLabel.text = [NSString stringWithFormat:@"%ld",model.pinLabel];
    _timeLabel.text = curren;
    
    [self setupAutoHeightWithBottomView: _timeLabel bottomMargin:10];
    
}
-(void)refreshWithMomData:(NSDictionary *)dic type:(NSString*)type{
    NSString *head = [dic[@"headimgurl"] isKindOfClass:[NSNull class]] ? @"" : dic[@"headimgurl"] ;
    NSString *title = [dic[@"title"] isKindOfClass:[NSNull class]] ? @"" : dic[@"title"] ;
    NSString *word = [dic[@"word"] isKindOfClass:[NSNull class]] ? @"" : dic[@"word"] ;
    NSInteger sum =[ [dic[@"sum"] isKindOfClass:[NSNull class]] ? @"" : dic[@"sum"] integerValue];
    NSString *time = [dic[@"time"] isKindOfClass:[NSNull class]] ? @"" : dic[@"time"] ;
        NSString *name = [dic[@"name"] isKindOfClass:[NSNull class]] ? @"" : dic[@"name"] ;
        NSInteger love =[ [dic[@"love"] isKindOfClass:[NSNull class]] ? @"" : dic[@"love"] integerValue];
      NSInteger loveN = [[dic[@"loveN"] isKindOfClass:[NSNull class]] ? @"" : dic[@"loveN"] integerValue];
  
     NSString *currens = [Unit timeWithTimeIntervalString:time];
    NSString *curren = [Unit compareCurrentTime:currens];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@""]];
    _titles.text = title;
    _nameLabel.text = name;
    _detaislLabel.text =word;
    _zanLabel.text =  [NSString stringWithFormat:@"%ld",loveN];
    _pinLabel.text = [NSString stringWithFormat:@"%ld",sum];
    _timeLabel.text = curren;
     _detaislLabel.textColor = COLOR_6666;
    //获取内容高度 判断高度的大小 改变其他控件的坐标
//      CGSize textSize = [Unit getLabelSizeFortextFont:FONTFZLTHK13 textLabel:_detaislLabel.text];
    CGFloat heght = [Unit heightWithString:_detaislLabel.text font:_detaislLabel.font constrainedToWidth:_detaislLabel.width];
    
    _detaislLabel.height = heght;
    _timeLabel.y = _detaislLabel.BottomY+10;
    _zaniamge.y = _detaislLabel.BottomY+10;
    _zanLabel.y = _detaislLabel.BottomY+10;
    _pinLabel.y = _detaislLabel.BottomY+10;
    _pinglnImage.y = _detaislLabel.BottomY+10;
    _linewView.y = _timeLabel.BottomY+10;
    _cellHeighS = _linewView.BottomY;
    
    
    if(love == 1){
        _zaniamge.image = [UIImage imageNamed:@"dianzan"];
    }else{
       _zaniamge.image = [UIImage imageNamed:@"dianzanNo"];
    }
    
}

#pragma mark 回复
-(instancetype)initWithStyleCon:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:self.headImage];
          [self.contentView addSubview:self.nameLabel];
         [self.contentView addSubview:self.titles];
         [self.contentView addSubview:self.detaislLabel];
         [self.contentView addSubview:self.timeLabel];
         [self.contentView addSubview:self.zaniamge];
            [self.contentView addSubview:self.zanLabel];
            [self.contentView addSubview:self.pinglnImage];
            [self.contentView addSubview:self.pinLabel];
          [self.contentView addSubview:self.linewView];
        

    }
    return self;
}


-(UILabel *)titles{
    if(!_titles){
        _titles = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, NH(_nameLabel), SCREENWIDTH-100, 20)];
        _titles.font =FONTFZLTHK12;
        _titles.textColor =COLOR_6666;
        _titles.text = @"jucy";
        _titles.textAlignment = NSTextAlignmentLeft;
    }
    return _titles;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, 15, SCREENWIDTH-100, 20)];
        _nameLabel.font =FONTFZLTHK12;
        _nameLabel.textColor = [UIColor colorwithHexString:@"#6699CC"];
        _nameLabel.text = @"jucy";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
#pragma mark 头像
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 44, 44)];
        _headImage.image = [UIImage imageNamed:@"test3"];
      
    }
    return _headImage;
}
#pragma mark  title
-(UILabel *)detaislLabel{
    if(!_detaislLabel){
        _detaislLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, NH(_titles)+5, SCREENWIDTH-100, 20)];
        _detaislLabel.font =FONTFZLTHK12;
        _detaislLabel.textColor = COLOR_6666;
        _detaislLabel.textAlignment = NSTextAlignmentLeft;
        _detaislLabel.backgroundColor = [UIColor whiteColor];
        _detaislLabel.layer.borderColor = [[UIColor clearColor]CGColor];
        _detaislLabel.text = @"2222";
        _detaislLabel.numberOfLines = 0;
    }
    return _detaislLabel;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, NH(_detaislLabel)+10, 100, 20)];
        _timeLabel.font =FONTFZLTHK12;
        _timeLabel.textColor = COLOR_9999;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"5分钟前";
    }
    return _timeLabel;
}
-(UIImageView *)zaniamge{
    if(!_zaniamge){
        _zaniamge = [[UIImageView alloc]initWithFrame:CGRectMake(NW(_timeLabel)+50, NH(_detaislLabel)+10, 21, 17)];
        _zaniamge.image = [UIImage imageNamed:@"zan"];
    }
    return _zaniamge;
}
-(UILabel *)zanLabel{
    if(!_zanLabel){
        _zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(NW(_zaniamge)+5, NH(_detaislLabel)+10, 20, 20)];
        _zanLabel.font =FONTFZLTHK11;
        _zanLabel.textColor = COLOR_9999;
        _zanLabel.textAlignment = NSTextAlignmentLeft;
        _zanLabel.text = @"23";
    }
    return _zanLabel;
}
-(UIImageView *)pinglnImage{
    if(!_pinglnImage){
        _pinglnImage =  [[UIImageView alloc]initWithFrame:CGRectMake(NW(_zanLabel)+5, NH(_detaislLabel)+10, 21, 17)];
        _pinglnImage.image = [UIImage imageNamed:@"pl"];
    }
    return _pinglnImage;
}

-(UILabel *)pinLabel{
    if(!_pinLabel){
        _pinLabel =  [[UILabel alloc]initWithFrame:CGRectMake(NW(_pinglnImage)+5, NH(_detaislLabel)+10, 30, 20)];
        _pinLabel.font =FONTFZLTHK11;
        _pinLabel.textColor = COLOR_9999;
        _pinLabel.textAlignment = NSTextAlignmentLeft;
        _pinLabel.text = @"66";
    }
    return _pinLabel;
}
-(UIView *)linewView{
    if(!_linewView){
        _linewView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_timeLabel)+10, self.width, 0.5)];
        _linewView.backgroundColor = COLOR_BACKGRUNDE;

    }
    return _linewView;
}
@end
