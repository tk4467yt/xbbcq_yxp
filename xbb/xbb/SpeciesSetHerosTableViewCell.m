//
//  SpeciesSetHerosTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "SpeciesSetHerosTableViewCell.h"
#import "HeroCollectionViewCell.h"
#import "HeroInfo.h"
#import "HeroTypeDesc.h"
#import "MyUtility.h"
#import "DbHandler.h"

@interface SpeciesSetHerosTableViewCell ()

@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *rankDescDict;

@end

@implementation SpeciesSetHerosTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.cvHeros.dataSource=self;
    self.cvHeros.delegate=self;
    
    [self.cvHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cvHeros reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectHeroDelegate respondsToSelector:@selector(speciesSetDidSelectHeroWithId:)]) {
        HeroInfo *heroInfo2use=self.herosArr[indexPath.row];
        [self.selectHeroDelegate speciesSetDidSelectHeroWithId:heroInfo2use.heroId];
        
        [self.parentVC.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.herosArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    HeroInfo *heroInfo2use=self.herosArr[indexPath.row];
    
//    heroCell.ivThumb.image=[UIImage imageNamed:heroInfo2use.thumbFile];
//    
//    RankDesc *rankDesc=[self.rankDescDict objectForKey:[MyUtility rankIdForBai]];
//    UIImage *maskImg=[UIImage imageNamed:rankDesc.heroIconFrameThumb];
//    heroCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:[MyUtility rankIdForZi]];
    heroCell.lblName.text=heroInfo2use.heroName;
    
//    HeroTypeDesc *typeDesc=self.heroTypeDescDict[heroInfo2use.heroType];
//    heroCell.ivType.image=[UIImage imageNamed:typeDesc.typeThumb];
    
    return heroCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}
@end
