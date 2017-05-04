//
//  BPMomExperCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/15.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMomExperCell.h"

@implementation BPMomExperCell

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
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detaislLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.zaniamge];
        [self.contentView addSubview:self.zanLabel];

        [self.contentView addSubview:self.linewView];
    }
    return self;
}
-(void)refreshWithMomData:(NSDictionary *)dic type:(NSString*)type{
    NSString *head = [dic[@"headimgurl"] isKindOfClass:[NSNull class]] ? @"" : dic[@"headimgurl"] ;
    NSString *word = [dic[@"word"] isKindOfClass:[NSNull class]] ? @"" : dic[@"word"] ;
    NSString *time = [dic[@"time"] isKindOfClass:[NSNull class]] ? @"" : dic[@"time"] ;
    NSString *name = [dic[@"name"] isKindOfClass:[NSNull class]] ? @"" : dic[@"name"] ;
    NSInteger love =[ [dic[@"love"] isKindOfClass:[NSNull class]] ? @"" : dic[@"love"] integerValue];
    NSInteger loveN = [[dic[@"loveN"] isKindOfClass:[NSNull class]] ? @"" : dic[@"loveN"] integerValue];
    
    NSString *currens = [Unit timeWithTimeIntervalString:time];
    NSString *curren = [Unit compareCurrentTime:currens];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = name;
    _detaislLabel.text =word;
    _zanLabel.text =  [NSString stringWithFormat:@"%ld",loveN];
    _timeLabel.text = curren;
    _detaislLabel.textColor = COLOR_6666;
    //获取内容高度 判断高度的大小 改变其他控件的坐标
//    CGSize textSize = [Unit getLabelSizeFortextFont:FONTFZLTHK13 textLabel:_detaislLabel.text];
     CGFloat heght = [Unit heightWithString:_detaislLabel.text font:_detaislLabel.font constrainedToWidth:SCREENWIDTH];
    _detaislLabel.height = heght;
    _timeLabel.y = _detaislLabel.BottomY+10;
        _zanLabel.y = _detaislLabel.BottomY+10;
        _zaniamge.y = _detaislLabel.BottomY+10;
    _linewView.y = _timeLabel.BottomY+10;
    _cellHeigh = _linewView.BottomY;
    
    
    if(love == 1){
        _zaniamge.image = [UIImage imageNamed:@"dianzan"];
    }else{
        _zaniamge.image = [UIImage imageNamed:@"dianzanNo"];
    }
    
}

#pragma mark 头像
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 44, 44)];
        _headImage.image = [UIImage imageNamed:@"test3"];
        
    }
    return _headImage;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, 15, 100, 20)];
        _nameLabel.font =FONTFZLTHK12;
        _nameLabel.textColor = [UIColor colorwithHexString:@"#6699CC"];
        _nameLabel.text = @"jucy";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

#pragma mark  title
-(UILabel *)detaislLabel{
    if(!_detaislLabel){
        _detaislLabel = [[UILabel alloc]initWithFrame:CGRectMake(NH(_headImage)+5, NH(_nameLabel)+5, SCREENWIDTH-100, 20)];
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
        _zaniamge = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH-65, NH(_detaislLabel)+10, 21, 17)];
        _zaniamge.image = [UIImage imageNamed:@"zan"];
    }
    return _zaniamge;
}
-(UILabel *)zanLabel{
    if(!_zanLabel){
        _zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-30, NH(_detaislLabel)+10, 20, 20)];
        _zanLabel.font =FONTFZLTHK11;
        _zanLabel.textColor = COLOR_9999;
        _zanLabel.textAlignment = NSTextAlignmentLeft;
        _zanLabel.text = @"23";
    }
    return _zanLabel;
}

-(UIView *)linewView{
    if(!_linewView){
        _linewView = [[UIView alloc]initWithFrame:CGRectMake(0, NH(_timeLabel)+10, SCREENWIDTH, 0.5)];
        _linewView.backgroundColor = COLOR_BACKGRUNDE;
        
    }
    return _linewView;
}

-(void)refreshWithCell:(NSString  *)datils{
//    self.detailsLabel.text = datils;
//    //获取内容高度 判断高度的大小 改变其他控件的坐标
//    CGFloat heigh = [Unit heightWithString:_detailsLabel.text
//                                      font:_detailsLabel.font
//                        constrainedToWidth:_detailsLabel.width];
//    self.detailsLabel.height = heigh;
//    _backView.height = self.detailsLabel.BottomY+30;
//    _cellHeigh = _backView.BottomY+10 ;
}
@end
