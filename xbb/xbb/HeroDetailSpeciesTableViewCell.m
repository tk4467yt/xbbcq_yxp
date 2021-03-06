//
//  HeroDetailSpeciesTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/6.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailSpeciesTableViewCell.h"
#import "HeroSepciesIconCollectionViewCell.h"
#import "HeroSpecies.h"
#import "SpeciesDesc.h"
#import "DbHandler.h"
#import "SpeciesSetViewController.h"
#import "MyUtility.h"

#define kHeroSpeciesIconCVCellId @"hero_species_icon_cv_cell_id"

@interface HeroDetailSpeciesTableViewCell ()
@property (nonatomic,strong) NSDictionary *allSpeciesDict;
@end

@implementation HeroDetailSpeciesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cvSpecies.delegate=self;
    self.cvSpecies.dataSource=self;
    
    self.allSpeciesDict=[DbHandler getAllSpeciesDescDict];
    [self.cvSpecies registerNib:[UINib nibWithNibName:@"HeroSepciesIconCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kHeroSpeciesIconCVCellId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblSpeciesDesc.text=NSLocalizedString(@"species_title", @"");
    
    self.lblDescNone.text=NSLocalizedString(@"desc_for_none", @"");
    if (self.heroSpeciesArr.count > 0) {
        self.lblDescNone.hidden=true;
    } else {
        self.lblDescNone.hidden=false;
    }
    
    [self.cvSpecies reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroSpecies *heroSpecies=self.heroSpeciesArr[indexPath.row];
    SpeciesDesc *species2use=self.allSpeciesDict[heroSpecies.speciesId];
    
    SpeciesSetViewController *detailVC=[SpeciesSetViewController new];
    detailVC.speciesDesc2show=species2use;
    detailVC.selectHeroDelegate=(id<SpeciesSetDidSelectHeroDelegate>)self.parentVC;
    
    [MyUtility pushViewControllerFromNav:self.parentVC.navigationController withTargetVC:detailVC animated:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.heroSpeciesArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroSepciesIconCollectionViewCell *speciesIconCell=[collectionView dequeueReusableCellWithReuseIdentifier:kHeroSpeciesIconCVCellId forIndexPath:indexPath];
    
    HeroSpecies *heroSpecies=self.heroSpeciesArr[indexPath.row];
    SpeciesDesc *species2use=self.allSpeciesDict[heroSpecies.speciesId];
    speciesIconCell.ivSpeciesThumb.image=[UIImage imageNamed:species2use.speciesThumb];
    speciesIconCell.lblSpeciesName.text=species2use.speciesDesc;
    
    return speciesIconCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroSpeciesItemSize];
}
@end
