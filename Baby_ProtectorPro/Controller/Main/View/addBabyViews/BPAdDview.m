//
//  BPAdDview.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/18.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPAdDview.h"
#import "BPAddCell.h"

@implementation BPAdDview

-(instancetype)initWithFrame:(CGRect)frame{
    if(self){
        self = [super initWithFrame:frame];
        _imageArr = [NSMutableArray array];
        //headview
//        [self creatView];
        
        //midview
        [self midViews];
        
        //bottomView
//        [self bottomviews];
    }
    return self;
}
#pragma mark - midview
#define MaxItemCount 10
#define ItemWidth 94
#define ItemHeight 94
#define BTNWITH SCREENWIDTH/4
#define BTNHEIGHT 120/2
-(void)midViews{
    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH, self.height)];
    
    _midView.backgroundColor =[UIColor yellowColor];
    [self addSubview:_midView];
    
    NSArray *picArr=  @[@"TX2",@"TX2",@"jia"];
    [_imageArr setArray:picArr];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, _midView.height) collectionViewLayout:layout];
    
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_mainCollectionView registerClass:[BPAddCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [_midView addSubview:_mainCollectionView];
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BPAddCell *cell = (BPAddCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    //        cell.titles.text = @"火爆进口马来西亚特产大金龙芒果包邮500g";
    cell.headImage .image = [UIImage imageNamed:_imageArr[indexPath.row]];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(DEVICEHEIGHT5) {
        return CGSizeMake(186/2/1.17, 90/1.17);
    }else{
        return CGSizeMake(186/2, 90);
    }
    
    
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *firstIndexPath = [[self.mainCollectionView indexPathsForVisibleItems] lastObject];
    if(indexPath.row == _imageArr.count-1){
        if(_block){
            _block(indexPath.row);
        }
        
    }
}

@end
