//
//  BPAddCell.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/18.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAddCell : UICollectionViewCell
//头像
@property ( nonatomic , strong ) UIImageView *headImage;
//m名字
@property ( nonatomic , strong ) UILabel *titleLabel;

//详情
@property ( nonatomic , strong ) UILabel *introLabel;
@end
