//
//  BPAddBabyView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/14.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^dateClickBlock)();
@interface BPAddBabyView : UIView

@property ( nonatomic , strong ) UILabel *nickName;
@property ( nonatomic , strong ) UILabel *sexlabel;
@property ( nonatomic , strong ) UILabel *birLabel;
@property ( nonatomic , strong ) UITextField *biaotiTX;
@property ( nonatomic , strong ) UIButton *okBtn;

@property ( nonatomic , strong ) UIButton *dateBtn;

@property ( nonatomic , strong ) UIImageView *allowImage;
@property ( nonatomic , copy ) dateClickBlock block;
@end
