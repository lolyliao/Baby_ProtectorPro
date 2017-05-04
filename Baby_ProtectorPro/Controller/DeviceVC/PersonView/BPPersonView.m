//
//  BPPersonView.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/21.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPPersonView.h"

@implementation BPPersonView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.backView];
            [self addSubview:self.headView];
            [self addSubview:self.myTableview];
        
            [self addSubview:self.btnView];
    
//        [self creatUI];
        _titleArr = @[@"我的音乐",@"我的收藏",@"我的经验",@"添加设备",@"修改宝宝信息",@"功能及帮助",@"反馈意见拿红包",];
        _imageArr = @[@"music",@"collect",@"jingyan",@"shebei",@"xiugai",@"hand",@"yijian",];

        
    }
    return self;
}
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-50)];
        _backView.backgroundColor = COLOR_PINK;
        
    }
    return _backView;
}
-(UIView *)btnView{
    if(!_btnView){
    
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-50, self.backView.width, 50) ];
        _btnView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titkeA = @[@"删除设备",@"退出"];
        for(int i =0;i<2;i++){
            UIButton *bottomBtn= [UIButton buttonWithType:UIButtonTypeCustom];
            bottomBtn.frame = CGRectMake(_btnView.width/2*i, 0, _btnView.width/2, 50) ;
            bottomBtn.backgroundColor = COLOR_MAINGREEN;
            [_btnView addSubview:bottomBtn];
            [bottomBtn setTitle:titkeA[i] forState:UIControlStateNormal];
            bottomBtn.titleLabel.textColor = [UIColor whiteColor];
            bottomBtn.titleLabel.font = FONTFZLTHK12;
            //            [bottomBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *liness = [[UIView alloc]initWithFrame:CGRectMake(_btnView.width/2, 0, 1, 50)];
            liness.backgroundColor = [UIColor whiteColor];
            [_btnView addSubview:liness];
        }
    }
    return _btnView;
}
-(UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.backView.width, 160) ];
        _headView.backgroundColor = COLOR_MAINGREEN;
        
        UIImageView *headImage = [Unit createImageView:CGRectMake(20, 57, 68, 68) isRound:YES];
        headImage.image = [UIImage imageNamed:@"test3"];
        [_headView addSubview:headImage];
        
        UILabel *titls = [[UILabel alloc]initWithFrame:CGRectMake(10, NH(headImage), 200, 13)];
        titls.font =FONTFZLTHK12;
        titls.textColor = COLOR_6666;
        titls.textAlignment = NSTextAlignmentLeft;
        //    titls.backgroundColor = [UIColor whiteColor];
        titls.text = @"贝贝";
        [_headView addSubview:titls];

    }
    return _headView;
}
-(UITableView *)myTableview{
    if(!_myTableview){
    _myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0 ,NH(_headView),_backView.width, self.height-_headView.height)];
    _myTableview.delegate = self;
    _myTableview.dataSource = self;
    _myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableview.backgroundColor =[UIColor whiteColor];
    }
    return _myTableview;
}
#pragma mark -- UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_imageArr.count){
        return _imageArr.count;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.textLabel.font = FONTFZLTHK12;
    cell.imageView.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_block){
        _block(indexPath.row);
    }
}

@end
