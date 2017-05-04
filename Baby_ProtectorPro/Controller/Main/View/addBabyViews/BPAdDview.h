//
//  BPAdDview.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/18.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBtnTag)(int tag);

@interface BPAdDview : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
//工具
@property ( nonatomic , strong ) UIView *midView;

@property ( nonatomic , strong ) UICollectionView *mainCollectionView;

@property ( nonatomic , strong ) NSMutableArray    *imageArr;;

@property ( nonatomic , copy ) ClickBtnTag block;
@end
