//
//  BPArticleCell.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPModel.h"

@interface BPArticleCell : UITableViewCell

@property ( nonatomic , strong ) UILabel *titleLabel;

@property (nonatomic, assign, readonly) CGFloat cellHeigh; //cell的高度

-(void)refreshWithData:(NSString *)str;

/**
 *  回复页面
 * param nikl
 */
-(instancetype)initWithStyleCon:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property ( nonatomic , strong ) UIImageView *headImage;
@property ( nonatomic , strong ) UILabel *nameLabel;
@property ( nonatomic , strong ) UILabel *titles;

@property ( nonatomic , strong ) UILabel *detaislLabel;

@property ( nonatomic , strong ) UILabel *timeLabel;

@property ( nonatomic , strong ) UIImageView *zaniamge;

@property ( nonatomic , strong ) UILabel *zanLabel;
@property ( nonatomic , strong ) UIImageView *pinglnImage;

@property ( nonatomic , strong ) UILabel *pinLabel;

@property ( nonatomic , strong ) UIView *linewView;

@property (nonatomic, assign, readonly) CGFloat cellHeighS; //cell的高度

@property (nonatomic, strong) BPModel *model;
-(void)refreshWithMomData:(NSDictionary *)dic type:(NSString*)type;
@end
