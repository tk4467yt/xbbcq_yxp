//
//  HeroDetailEquipsTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/8.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailEquipsTableViewCell.h"
#import "EquipBriefInfoCollectionViewCell.h"
#import "MyUtility.h"

@implementation HeroDetailEquipsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    UITapGestureRecognizer *tapGesture0=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip0Tapped:)];
//    [self.ivEquip0 addGestureRecognizer:tapGesture0];
//    
//    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip1Tapped:)];
//    [self.ivEquip1 addGestureRecognizer:tapGesture1];
//    
//    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip2Tapped:)];
//    [self.ivEquip2 addGestureRecognizer:tapGesture2];
//    
//    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip3Tapped:)];
//    [self.ivEquip3 addGestureRecognizer:tapGesture3];
//    
//    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip4Tapped:)];
//    [self.ivEquip4 addGestureRecognizer:tapGesture4];
//    
//    UITapGestureRecognizer *tapGesture5=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip5Tapped:)];
//    [self.ivEquip5 addGestureRecognizer:tapGesture5];
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.cvEquipsForRank.delegate=self;
    self.cvEquipsForRank.dataSource=self;
    
    [self.cvEquipsForRank registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)equip0Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:0];
//    }
//}
//
//- (void)equip1Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:1];
//    }
//}
//
//- (void)equip2Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:2];
//    }
//}
//
//- (void)equip3Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:3];
//    }
//}
//
//- (void)equip4Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:4];
//    }
//}
//
//- (void)equip5Tapped:(UITapGestureRecognizer *)tapGesture
//{
//    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
//        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:5];
//    }
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblEquipDesc.text=NSLocalizedString(@"equip_title", @"");
    
    [self.cvEquipsForRank reloadData];
}

-(void)setEquipImageForIndexPath:(NSIndexPath *)indexPath withEquipCell:(EquipBriefInfoCollectionViewCell *)equipBriefCell
{
    EquipInfo *equipInfo2use=nil;
    
    BOOL shouldSwitch1and6=[MyUtility shouldSwitchEquipsForRankId:self.rankId];
    
    if (shouldSwitch1and6) {
        if (0 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip6];
        } else if (1 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip1];
        } else if (2 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip2];
        } else if (3 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip3];
        } else if (4 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip4];
        } else if (5 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip5];
        }
    } else {
        if (0 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip1];
        } else if (1 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip2];
        } else if (2 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip3];
        } else if (3 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip4];
        } else if (4 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip5];
        } else if (5 == indexPath.row) {
            equipInfo2use=[MyUtility getEquipInfoForEquipIdCache:self.heroEquips.equip6];
        }
    }
    
    if (nil == equipInfo2use) {
        equipBriefCell.ivThumb.image=[UIImage imageNamed:@"hero_icon_unknow"];
        
        equipBriefCell.ivThumb.layer.borderColor=[[UIColor darkGrayColor] CGColor];
        equipBriefCell.ivThumb.layer.borderWidth=1;
        
        equipBriefCell.ivMask.image=nil;
    } else {
        equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
        
        equipBriefCell.ivThumb.layer.borderColor=[[UIColor grayColor] CGColor];
        equipBriefCell.ivThumb.layer.borderWidth=0;
        
        RankDesc *rankDesc2use=self.rankDescDict[equipInfo2use.equipRank];
        UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
        equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    }
    
//    equipBriefCell.lblName.text=equipInfo2use.equipName;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:indexPath.row];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
//    equipBriefCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
    equipBriefCell.noNameShown=true;
    [self setEquipImageForIndexPath:indexPath withEquipCell:equipBriefCell];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo] forIndexPath:indexPath];
    
    return equipBriefCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo equipBriefCVItemSmallSize];
}

@end
