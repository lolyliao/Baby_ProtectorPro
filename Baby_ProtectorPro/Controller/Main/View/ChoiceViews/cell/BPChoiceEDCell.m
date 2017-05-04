//
//  BPChoiceEDCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/17.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPChoiceEDCell.h"

@implementation BPChoiceEDCell

- (void)awakeFromNib {
    [super awakeFromNib];
      self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor redColor];
//        [self updataFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){

          [self.contentView addSubview:self.detailsLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updataFrame];

    }
    return self;
}
- (void)updataFrame
{
    self.detailsLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,30)
    .autoHeightRatio(0);

}
-(float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    //MAXFLOAT
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
//    CGFloat realHeight = ceilf(rect.size.height);
    CGFloat realHeight  = rect.size.height;
    return realHeight;
}

-(void)refreshWithCell:(NSString  *)str{

        if([str rangeOfString:@"t_"].location !=NSNotFound )//_roaldSearchText
        {
             _lineview.backgroundColor = [UIColor purpleColor];
           str = [str stringByReplacingOccurrencesOfString:@"t_" withString:@"  "];
            self.detailsLabel.textColor = [UIColor colorwithHexString:@"#663333"];
        }
    
        if([str  rangeOfString:@"w_"].location !=NSNotFound )//_roaldSearchText
        {
            _lineview.backgroundColor = [UIColor clearColor];
            str= [str stringByReplacingOccurrencesOfString:@"w_" withString:@"  "];
            self.detailsLabel.textColor = [UIColor colorwithHexString:@"#666666"];

        }
 self.detailsLabel.text = str;
//        CGFloat heigh  = [self heightForString:str fontSize:12 andWidth:self.width-30];
//    CGFloat heigh = [Unit heightWithString:str
//                                      font:FONTFZLTHK13
//                        constrainedToWidth:self.width-30];
    CGSize textSize = [Unit getLabelSizeFortextFont:[UIFont fontWithName:@"Arial" size:10] textLabel:self.detailsLabel.text ];
    _detailsLabel.height = textSize.height;
    self.height = _detailsLabel.BottomY+10;
    _cellHeigh = _detailsLabel.BottomY+15;
  
}

#pragma mark 详情
-(UILabel *)detailsLabel{
    if(!_detailsLabel){
          _detailsLabel = [UILabel new];
        _detailsLabel.textColor = COLOR_6666;
        _detailsLabel.font = [UIFont fontWithName:FZLTHKGBK size:10];
        _detailsLabel.backgroundColor = [UIColor clearColor];
        _detailsLabel.numberOfLines = 0;
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailsLabel;
}

@end
