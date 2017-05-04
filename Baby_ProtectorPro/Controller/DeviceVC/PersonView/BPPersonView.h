//
//  BPPersonView.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/21.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickUI)(NSInteger tag);
@interface BPPersonView : UIView<UITableViewDelegate,UITableViewDataSource>

@property ( nonatomic , strong ) UIView *backView;

@property ( nonatomic , strong ) UITableView *myTableview;

@property ( nonatomic , strong ) NSArray *imageArr;
@property ( nonatomic , strong ) NSArray *titleArr;

@property ( nonatomic , strong ) UIView *btnView;

@property ( nonatomic , strong ) UIView *headView;

@property ( nonatomic , copy ) ClickUI block;

@end
