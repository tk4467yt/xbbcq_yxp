//
//  EquipComposeHerosTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeHerosTableViewCell.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"
#import "HeroInfo.h"
#import "HeroTypeDesc.h"

@implementation EquipComposeHerosTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    
    self.cvEquipableHeros.delegate=self;
    self.cvEquipableHeros.dataSource=self;
    [self.cvEquipableHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]]
               forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    //equip_equipable_title
    self.lblDesc.text=[NSString stringWithFormat:@"(%@)%@:",self.equipInfoShowing.equipName,NSLocalizedString(@"equip_equipable_title", @"")];
    self.lblNone.text=NSLocalizedString(@"desc_for_none", @"");
    
    if (self.heroEquipsArr.count <= 0) {
        self.lblNone.hidden=false;
    } else {
        self.lblNone.hidden=true;
    }
    
    [self.cvEquipableHeros reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.composeActionDelegate respondsToSelector:@selector(didSelectEquipableHero:)]) {
        [self.composeActionDelegate.navigationController popViewControllerAnimated:YES];
        
        HeroEquips *heroEquip=self.heroEquipsArr[indexPath.row];
        [self.composeActionDelegate didSelectEquipableHero:heroEquip.heroId];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=(HeroCollectionViewCell *)cell;
    
    HeroEquips *heroEquip=self.heroEquipsArr[indexPath.row];
    HeroInfo *heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:heroEquip.heroId];
//
//    heroCell.ivThumb.image=[UIImage imageNamed:heroInfo2use.thumbFile];
//    
//    RankDesc *rankDesc=[self.rankDescDict objectForKey:heroEquip.heroRank];
//    UIImage *maskImg=[UIImage imageNamed:rankDesc.heroIconFrameThumb];
//    heroCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:heroEquip.heroRank];
    heroCell.lblName.text=heroInfo2use.heroName;
    
//    HeroTypeDesc *typeDesc=self.heroTypeDescDict[heroInfo2use.heroType];
//    heroCell.ivType.image=[UIImage imageNamed:typeDesc.typeThumb];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.heroEquipsArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    [heroCell layoutSubviews];
    return heroCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}
@end
