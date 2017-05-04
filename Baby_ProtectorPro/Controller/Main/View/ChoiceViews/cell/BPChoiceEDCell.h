//
//  BPChoiceEDCell.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/17.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface BPChoiceEDCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, strong) MainModel *model;
//头像
@property ( nonatomic , strong ) UIImageView *headImage;
//m名字
@property ( nonatomic , strong ) UILabel *titleLabel;

//详情
@property ( nonatomic , strong ) UILabel *introLabel;
//详情
@property ( nonatomic , strong ) UILabel *detailsLabel;
//头像
@property ( nonatomic , strong ) UIImageView *allowImage;

@property (nonatomic, assign, readonly) CGFloat cellHeigh; //cell的高度

@property ( nonatomic , strong ) UIView *backView;

@property ( nonatomic , strong ) UIView *lineview;

-(void)refreshWithCell:(NSString  *)str;
@end
