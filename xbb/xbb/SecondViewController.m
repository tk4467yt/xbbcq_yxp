//
//  SecondViewController.m
//  xbb
//
//  Created by  qin on 2017/2/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "SecondViewController.h"
#import "DbHandler.h"
#import "MyUtility.h"
#import "EquipInfo.h"
#import "RankDesc.h"
#import "EquipBriefInfoCollectionViewCell.h"

#define equipBriefReusableCellId @"equip_brief_info_cell_id"

@interface SecondViewController ()
@property (nonatomic,strong) NSArray *allEquipsArr;
@property (nonatomic,strong) NSMutableDictionary *equipRankDict;

@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSArray *equipRank2showArr;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=NSLocalizedString(@"title_equip", @"");
    
    [self.cvEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:equipBriefReusableCellId];
    
    [self initEquipInfo];
}

-(void)initEquipInfo
{
    self.allEquipsArr=[DbHandler getAllEquipInfo];
    self.rankDescDict=[DbHandler getAllRankDescDict];
    
    self.equipRank2showArr=[NSMutableArray arrayWithObjects:[MyUtility rankIdForBai],
                            [MyUtility rankIdForLv],
                            [MyUtility rankIdForLan],
                            [MyUtility rankIdForZi],
                            [MyUtility rankIdForCheng],
                            [MyUtility rankIdForHong],nil];
    
    self.equipRankDict=[NSMutableDictionary new];
    
    for (NSString *aRankId in self.equipRank2showArr) {
        [self.equipRankDict setObject:[NSMutableArray new] forKey:aRankId];
    }
    
    for (EquipInfo *aEquipInfo in self.allEquipsArr) {
        NSMutableArray *equipArr=self.equipRankDict[aEquipInfo.equipRank];
        [equipArr addObject:aEquipInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
    
    NSString *rankId=self.equipRank2showArr[indexPath.section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    EquipInfo *equipInfo2use=equipsArr[indexPath.row];
    
    equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
    
    RankDesc *rankDesc2use=self.rankDescDict[rankId];
    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
    equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    equipBriefCell.lblName.text=equipInfo2use.equipName;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *rankId=self.equipRank2showArr[section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    return equipsArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:equipBriefReusableCellId forIndexPath:indexPath];
    
    return equipBriefCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.equipRank2showArr.count;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80,100);
}

@end
