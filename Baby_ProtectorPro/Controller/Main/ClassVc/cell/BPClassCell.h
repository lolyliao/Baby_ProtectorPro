//
//  BPClassCell.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/20.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPClassCell : UITableViewCell

@property ( nonatomic , strong ) UIImageView *headImage;

@property ( nonatomic , strong ) UILabel *titleLabel;

@property ( nonatomic , strong ) UILabel *detaislLabel;

-(void)refreshWithData:(NSDictionary *)dic;

@end
