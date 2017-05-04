//
//  BPAddCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/18.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPAddCell.h"

@implementation BPAddCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.headImage];

        [self.contentView addSubview:self.introLabel];

        
        [self updataFrame];

    }
    return self;
}
- (void)updataFrame
{
    self.headImage.sd_layout
    .topSpaceToView(self.contentView,22)
    .leftSpaceToView(self.contentView,12)
    .widthIs(50)
    .heightIs(50);
    _headImage.layer.cornerRadius = _headImage.width/2;
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.headImage,2)
    .leftSpaceToView(self.contentView,24)
    .autoHeightRatio(0);
    
    self.introLabel.sd_layout
    .topSpaceToView(self.titleLabel,2)
//    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,24)
    .autoHeightRatio(0);
}
#pragma mark 详情
-(UILabel *)introLabel{
    if(!_introLabel){
        _introLabel = [UILabel new];
        _introLabel.textColor = COLOR_9999;
        _introLabel.font = [UIFont fontWithName:FZLTHKGBK size:10];
        _introLabel.backgroundColor = [UIColor clearColor];
        _introLabel.text = @"60天";
        _introLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _introLabel;
}

#pragma mark  头像
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [UIImageView new];
        _headImage.image = [UIImage imageNamed:@"tony"];
    }
    return _headImage;
}
#pragma mark 人名
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR_3333;
        _titleLabel.font = [UIFont fontWithName:FZLTHKGBK size:12];
        _titleLabel.backgroundColor = [UIColor clearColor];
          _titleLabel.text = @"宝宝";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
@end
