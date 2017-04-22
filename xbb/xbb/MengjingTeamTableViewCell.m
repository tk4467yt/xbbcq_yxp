//
//  MengjingTeamTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MengjingTeamTableViewCell.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"

@implementation MengjingTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.cvTeam.delegate=self;
    self.cvTeam.dataSource=self;
    
    [self.cvTeam registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cvTeam reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([MyUtility isStringNilOrZeroLength:self.teamInfo.heroId6]) {
        return 5;
    } else {
        return 6;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    if ([MyUtility isStringNilOrZeroLength:self.teamInfo.heroId6]) {
        self.lblTeamTitle.text=NSLocalizedString(@"title_for_mengjing_single_team", @"");
    } else {
        self.lblTeamTitle.text=NSLocalizedString(@"title_for_mengjing_lianji_team", @"");
    }
    
    NSString *heroId=@"";
    if (0 == indexPath.row) {
        heroId=self.teamInfo.heroId1;
    } else if (1 == indexPath.row) {
        heroId=self.teamInfo.heroId2;
    } else if (2 == indexPath.row) {
        heroId=self.teamInfo.heroId3;
    } else if (3 == indexPath.row) {
        heroId=self.teamInfo.heroId4;
    } else if (4 == indexPath.row) {
        heroId=self.teamInfo.heroId5;
    } else if (5 == indexPath.row) {
        heroId=self.teamInfo.heroId6;
    }
    HeroInfo *heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:heroId];
    if (nil == heroInfo2use) {
        NSLog(@"null hero info");
    }
    heroCell.lblName.text=heroInfo2use.heroName;
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:[MyUtility rankIdForZi]];
    return heroCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}
@end
