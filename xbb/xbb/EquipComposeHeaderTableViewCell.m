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

#define kEquipComposeHeaderItemCVCellId @"equip_compose_header_item_cv_cell_id"

@implementation EquipComposeHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cvHeader.dataSource=self;
    self.cvHeader.delegate=self;
    
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
    EquipInfo *curEquip=[DbHandler getEquipInfoForEquipId:equipId];
    
    headerComposeItemCell.ivEquip.image=[UIImage imageNamed:curEquip.thumbFile];
    if (indexPath.row == self.equipShowingArr.count-1) {
        headerComposeItemCell.ivEquipMask.hidden=false;
        headerComposeItemCell.ivRightArrow.hidden=true;
    } else {
        headerComposeItemCell.ivEquipMask.hidden=true;
        headerComposeItemCell.ivRightArrow.hidden=false;
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
