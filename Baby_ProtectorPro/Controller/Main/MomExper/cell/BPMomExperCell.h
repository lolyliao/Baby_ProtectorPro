//
//  BPMomExperCell.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/15.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPMomExperCell : UITableViewCell
@property ( nonatomic , strong ) UIImageView *headImage;
@property ( nonatomic , strong ) UILabel *nameLabel;

@property ( nonatomic , strong ) UILabel *detaislLabel;

@property ( nonatomic , strong ) UILabel *timeLabel;

@property ( nonatomic , strong ) UIImageView *zaniamge;

@property ( nonatomic , strong ) UILabel *zanLabel;

@property ( nonatomic , strong ) UIView *linewView;

@property (nonatomic, assign, readonly) CGFloat cellHeigh; //cell的高度

-(void)refreshWithMomData:(NSDictionary *)dic type:(NSString*)type;

-(void)refreshWithCell:(NSString  *)datils;
@end
