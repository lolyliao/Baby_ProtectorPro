//
//  BPClassCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPClassCell.h"

@implementation BPClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detaislLabel];
        
        [self updataFrame];
    }
    return self;
}
- (void)updataFrame
{

    self.headImage.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .widthIs(186/2)
    .heightIs(90);
    _headImage.layer.cornerRadius = _headImage.width/2;

    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.headImage,0)
     .heightIs(20);
    
    self.detaislLabel.sd_layout
    .topSpaceToView(self.titleLabel,10)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.headImage,0)
       .heightIs(20)
    .autoHeightRatio(0);
    
}
#pragma mark 头像
-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [UIImageView new];
        _headImage.image = [UIImage imageNamed:@"zhishi"];
    }
    return _headImage;
}
#pragma mark  title
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.font =FONTFZLTHK13;
        _titleLabel.textColor = COLOR_3333;
        _titleLabel.text = @"备孕知识";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
#pragma mark  title
-(UILabel *)detaislLabel{
    if(!_detaislLabel){
        _detaislLabel = [UILabel new];
        _detaislLabel.font =FONTFZLTHK11;
        _detaislLabel.textColor = COLOR_9999;
        _detaislLabel.textAlignment = NSTextAlignmentLeft;
         _detaislLabel.text = @"孕前准备，受孕注意，孕前保健";
    }
    return _detaislLabel;
}

-(void)refreshWithData:(NSDictionary *)dic{
    _titleLabel.text = [dic[@"title"] isKindOfClass:[NSNull class] ] ? @"" : dic[@"title"];
    _detaislLabel.text= [dic[@"des"] isKindOfClass:[NSNull class] ] ? @"" : dic[@"des"];
}
@end
