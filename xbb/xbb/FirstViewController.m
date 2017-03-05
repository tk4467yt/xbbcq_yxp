//
//  FirstViewController.m
//  xbb
//
//  Created by  qin on 2017/2/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "FirstViewController.h"
#import "DbHandler.h"
#import "HeroCollectionViewCell.h"
#import "HeroHeaderReusableView.h"
#import "HeroInfo.h"
#import "HeroTypeDesc.h"
#import "MyUtility.h"
#import "RankDesc.h"

#define heroBriefReusableCellId @"hero_cv_cell_id"

@interface FirstViewController ()
@property (nonatomic,strong) NSArray *allHerosArr;
@property (nonatomic,strong) NSMutableArray *liLiangHerosArr;
@property (nonatomic,strong) NSMutableArray *zhiLiHerosArr;
@property (nonatomic,strong) NSMutableArray *minJieHerosArr;

@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSMutableArray *heroType2showArr;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_hero", @"");
    
    [self initHerosInfo];
    
    [self.cvHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:heroBriefReusableCellId];
}

-(void)initHerosInfo
{
    self.allHerosArr=[DbHandler getAllHeros];
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    self.rankDescDict=[DbHandler getAllRankDescDict];
    
    self.liLiangHerosArr=[NSMutableArray new];
    self.zhiLiHerosArr=[NSMutableArray new];
    self.minJieHerosArr=[NSMutableArray new];
    
    self.heroType2showArr=[NSMutableArray arrayWithObjects:[MyUtility heroTypeLiliangId],[MyUtility heroTypeZhiliId],[MyUtility heroTypeMinjieId], nil];
    
    for (HeroInfo *aHeroInfo in self.allHerosArr) {
        if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeLiliangId]]) {
            [self.liLiangHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeZhiliId]]) {
            [self.zhiLiHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeMinjieId]]) {
            [self.minJieHerosArr addObject:aHeroInfo];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *typeId=self.heroType2showArr[section];
    if ([typeId isEqualToString:[MyUtility heroTypeLiliangId]]) {
        return self.liLiangHerosArr.count;
    } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
        return self.zhiLiHerosArr.count;
    } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
        return self.minJieHerosArr.count;
    }
    
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:heroBriefReusableCellId forIndexPath:indexPath];
    
    return heroCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.heroType2showArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        HeroHeaderReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                              withReuseIdentifier:@"hero_reusable_header_cell"
                                                                                     forIndexPath:indexPath];
        
        NSString *typeId=self.heroType2showArr[indexPath.section];
        NSString *title2set=@"";
        UIColor *color2set=[UIColor clearColor];
        if ([typeId isEqualToString:[MyUtility heroTypeLiliangId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_liliang_hero", @""),(int)self.liLiangHerosArr.count];
            color2set=[UIColor redColor];
        } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_zhili_hero", @""),(int)self.zhiLiHerosArr.count];
            color2set=[UIColor blueColor];
        } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_minjie_hero", @""),(int)self.minJieHerosArr.count];
            color2set=[UIColor greenColor];
        }
        headerView.lblTitle.text=title2set;
        headerView.lblTitle.textColor=color2set;
        
        reusableView2ret=headerView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=(HeroCollectionViewCell *)cell;
    
    NSString *typeId=self.heroType2showArr[indexPath.section];
    
    HeroInfo *heroInfo2use=nil;
    if ([typeId isEqualToString:[MyUtility heroTypeLiliangId]]) {
        heroInfo2use = self.liLiangHerosArr[indexPath.row];
    } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
        heroInfo2use = self.zhiLiHerosArr[indexPath.row];
    } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
        heroInfo2use = self.minJieHerosArr[indexPath.row];
    }
    
    heroCell.ivThumb.image=[UIImage imageNamed:heroInfo2use.thumbFile];
    
    RankDesc *rankDesc=[self.rankDescDict objectForKey:[MyUtility rankIdForBai]];
    UIImage *maskImg=[UIImage imageNamed:rankDesc.heroIconFrameThumb];
    heroCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    heroCell.lblName.text=heroInfo2use.heroName;
    
    HeroTypeDesc *typeDesc=self.self.heroTypeDescDict[heroInfo2use.heroType];
    heroCell.ivType.image=[UIImage imageNamed:typeDesc.typeThumb];
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80,100);
}

@end
