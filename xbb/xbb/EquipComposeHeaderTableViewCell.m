//
//  EquipComposeHeaderTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/10.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeHeaderTableViewCell.h"
#import "EquipComposeHeaderItemCollectionViewCell.h"
#import "MyUtility.h"
#import "DbHandler.h"
#import "EquipInfo.h"
#import "RankDesc.h"

#define kEquipComposeHeaderItemCVCellId @"equip_compose_header_item_cv_cell_id"

@interface EquipComposeHeaderTableViewCell ()
@property (nonatomic,strong) NSDictionary *rankDescDict;
@end

@implementation EquipComposeHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cvHeader.dataSource=self;
    self.cvHeader.delegate=self;
    
    self.rankDescDict=[MyUtility getAllRankDescDict];
    
    [self.cvHeader registerNib:[UINib nibWithNibName:@"EquipComposeHeaderItemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kEquipComposeHeaderItemCVCellId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.equipShowingArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipComposeHeaderItemCollectionViewCell *headerComposeItemCell=[collectionView dequeueReusableCellWithReuseIdentifier:kEquipComposeHeaderItemCVCellId forIndexPath:indexPath];
    
    NSString *equipId=self.equipShowingArr[indexPath.row];
    EquipInfo *curEquip=[MyUtility getEquipInfoForEquipId:equipId];
    
    headerComposeItemCell.ivEquip.image=[UIImage imageNamed:curEquip.thumbFile];
    if (indexPath.row == self.equipShowingArr.count-1) {
        headerComposeItemCell.ivEquipSelected.hidden=false;
        headerComposeItemCell.ivRightArrow.hidden=true;
    } else {
        headerComposeItemCell.ivEquipSelected.hidden=true;
        headerComposeItemCell.ivRightArrow.hidden=false;
    }
    
    headerComposeItemCell.ivEquipMask.hidden=!headerComposeItemCell.ivEquipSelected.hidden;
    
    if (!headerComposeItemCell.ivEquipMask.hidden) {
        RankDesc *rankDesc2use=self.rankDescDict[curEquip.equipRank];
        UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
        headerComposeItemCell.ivEquipMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    }
    
    return headerComposeItemCell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(57+16+5+37,68+16);
}
@end
