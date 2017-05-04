//
//  BPMomEXView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/26.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPMomEXView : UIView

typedef void (^ClickBtnTag)(UIButton *sender);

@property ( nonatomic , strong ) UILabel *titles;

@property ( nonatomic , strong ) UIImageView* showImage;
@property ( nonatomic , strong ) UIImageView *headImage;
@property ( nonatomic , strong ) UILabel *nameLabel;
@property ( nonatomic , strong ) UILabel *timeLabel;

@property ( nonatomic , strong ) UILabel *detaislLabel;
@property ( nonatomic , strong ) UIView *lineView;
@property ( nonatomic , strong ) UIButton *zanImage;
@property ( nonatomic , strong ) UILabel *notiLabel;
@property ( nonatomic , strong ) NSDictionary *dic;

@property ( nonatomic , copy ) ClickBtnTag block;
@end
