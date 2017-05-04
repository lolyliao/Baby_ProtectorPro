//
//  BPMainViewCell.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMainViewCell.h"

@implementation BPMainViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,186/2 , 90)];
        _showImage.image = [UIImage imageNamed:@"pic_fruit"];
        [self.contentView addSubview:_showImage];
        if(DEVICEHEIGHT5) {
            _showImage.frame = CGRectMake(0, 0,186/2/1.17,  90/1.17);
    
        }
        
        _titles = [[UILabel alloc]initWithFrame:CGRectMake(7, NH(_showImage) ,self.width, 20)];
        _titles.numberOfLines = 0;
        _titles.font = [UIFont systemFontOfSize:13];
        _titles.textColor = [UIColor grayColor];
//        [self.contentView addSubview:_titles];
    }
    return self;
}
@end
