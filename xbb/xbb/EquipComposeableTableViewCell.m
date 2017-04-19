//
//  EquipComposeableTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeableTableViewCell.h"
#import "MyUtility.h"
#import "EquipBriefInfoCollectionViewCell.h"

@implementation EquipComposeableTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.cvComposeableEquips.delegate=self;
    self.cvComposeableEquips.dataSource=self;
    [self.cvComposeableEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]]
               forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblDesc.text=[NSString stringWithFormat:@"(%@)%@:",self.equipInfoShowing.equipName,NSLocalizedString(@"equip_composeable_title", @"")];
    self.lblNone.text=NSLocalizedString(@"desc_for_none", @"");
    
    if (self.composeableEquipsArr.count <= 0) {
        self.lblNone.hidden=false;
    } else {
        self.lblNone.hidden=true;
    }
    
    [self.cvComposeableEquips reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (nil != self.composeableActionDelegate && [self.composeableActionDelegate respondsToSelector:@selector(didSelectComposeableEquip:)]) {
        EquipInfo *equipInfo2use=self.composeableEquipsArr[indexPath.row];
        [self.composeableActionDelegate didSelectComposeableEquip:equipInfo2use];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
    //    equipBriefCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
//    equipBriefCell.noNameShown=true;
//    
    EquipInfo *equipInfo2use=self.composeableEquipsArr[indexPath.row];
//    equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
//    
//    RankDesc *rankDesc2use=self.rankDescDict[equipInfo2use.equipRank];
//    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
//    equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    equipBriefCell.lblName.text=equipInfo2use.equipName;
    equipBriefCell.contentView.backgroundColor=[MyUtility rankColorForRankId:equipInfo2use.equipRank];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.composeableEquipsArr.count;
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
