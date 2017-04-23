//
//  TuanbenTeamTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "TuanbenTeamTableViewCell.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"

@implementation TuanbenTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cvTuanbenTeam.delegate=self;
    self.cvTuanbenTeam.dataSource=self;
    
    [self.cvTuanbenTeam registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblTeamTitle.text=[NSString stringWithFormat:NSLocalizedString(@"team_group_title", @""),self.teamIdx];
    
    [self.cvTuanbenTeam reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    NSString *heroId=@"";
    if (0 == indexPath.row) {
        heroId=self.tuanbenTeam.heroId1;
    } else if (1 == indexPath.row) {
        heroId=self.tuanbenTeam.heroId2;
    } else if (2 == indexPath.row) {
        heroId=self.tuanbenTeam.heroId3;
    } else if (3 == indexPath.row) {
        heroId=self.tuanbenTeam.heroId4;
    } else if (4 == indexPath.row) {
        heroId=self.tuanbenTeam.heroId5;
    }
    
    HeroInfo *heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:heroId];
    if (nil == heroInfo2use) {
        NSLog(@"null hero info");
    }
    heroCell.lblName.text=heroInfo2use.heroName;
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:[MyUtility rankIdForZi]];
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
