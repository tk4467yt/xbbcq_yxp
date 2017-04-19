//
//  HeroDetailAllNonComposeEquipsTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailAllNonComposeEquipsTableViewCell.h"
#import "MyUtility.h"
#import "EquipBriefInfoCollectionViewCell.h"
#import "RankDesc.h"
#import "EquipComposeViewController.h"

@implementation HeroDetailAllNonComposeEquipsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.cvNonComposeEquips.delegate=self;
    self.cvNonComposeEquips.dataSource=self;
    [self.cvNonComposeEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblDesc.text=[NSString stringWithFormat:@"%@:",NSLocalizedString(@"title_for_non_compose_equips", @"")];
    
    [self.cvNonComposeEquips reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipComposeViewController *composeVC=[EquipComposeViewController new];
    
    composeVC.equipInfo=self.nonComposeEquipsArr[indexPath.row];
    composeVC.composeActionDelegate=self.parentVC;
    
    [MyUtility pushViewControllerFromNav:self.parentVC.navigationController withTargetVC:composeVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
    //    equipBriefCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
//    equipBriefCell.noNameShown=true;
//    
    EquipInfo *equipInfo2use=self.nonComposeEquipsArr[indexPath.row];
//    equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
//    
//    RankDesc *rankDesc2use=self.rankDescDict[equipInfo2use.equipRank];
//    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
//    equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
//    
//    equipBriefCell.lblCount.hidden=false;
//    NSNumber *countNumber=[self.equipCountDict objectForKey:equipInfo2use.equipId];
//    equipBriefCell.lblCount.text=[NSString stringWithFormat:@"%d",countNumber.intValue];
    equipBriefCell.lblName.text=equipInfo2use.equipName;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nonComposeEquipsArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo] forIndexPath:indexPath];
    
    [equipBriefCell setNeedsLayout];
    return equipBriefCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo equipBriefCVItemSize];
}

@end
