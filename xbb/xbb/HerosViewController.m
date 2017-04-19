//
//  HerosViewController.m
//  xbb
//
//  Created by  qin on 2017/4/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HerosViewController.h"
#import "MyAppSizeInfo.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"
#import "TextContentCollectionReusableView.h"
#import "HeroDetailViewController.h"

@interface HerosViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *allHerosArr;
@property (nonatomic,strong) NSMutableArray *liLiangHerosArr;
@property (nonatomic,strong) NSMutableArray *zhiLiHerosArr;
@property (nonatomic,strong) NSMutableArray *minJieHerosArr;

@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSMutableArray *heroType2showArr;
@end

@implementation HerosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.cvHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
    [self.cvHeros registerNib:[UINib nibWithNibName:@"TextContentCollectionReusableView" bundle:[NSBundle mainBundle]]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]];
    
    [self initHerosInfo];
}

-(void)initHerosInfo
{
    self.allHerosArr=[MyUtility getCachedAllHeros];
    self.heroTypeDescDict=[DbHandler getAllHeroTypeDescDict];
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.liLiangHerosArr=[NSMutableArray new];
    self.zhiLiHerosArr=[NSMutableArray new];
    self.minJieHerosArr=[NSMutableArray new];
    
    self.heroType2showArr=[NSMutableArray arrayWithObjects:[MyUtility heroTypeLiliangId],[MyUtility heroTypeZhiliId],[MyUtility heroTypeMinjieId], nil];
    
    [self updateHeros2shown];
}

-(void)updateHeros2shown
{
    [self.liLiangHerosArr removeAllObjects];
    [self.zhiLiHerosArr removeAllObjects];
    [self.minJieHerosArr removeAllObjects];
    
    for (HeroInfo *aHeroInfo in self.allHerosArr) {
        if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeLiliangId]]) {
            [self.liLiangHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeZhiliId]]) {
            [self.zhiLiHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeMinjieId]]) {
            [self.minJieHerosArr addObject:aHeroInfo];
        }
    }
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"nav_title_hero", @""),(int)self.allHerosArr.count];
}

-(HeroInfo *)getHeroInfoWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *typeId=self.heroType2showArr[indexPath.section];
    
    HeroInfo *heroInfo2use=nil;
    if ([typeId isEqualToString:[MyUtility heroTypeLiliangId]]) {
        heroInfo2use = self.liLiangHerosArr[indexPath.row];
    } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
        heroInfo2use = self.zhiLiHerosArr[indexPath.row];
    } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
        heroInfo2use = self.minJieHerosArr[indexPath.row];
    }
    
    return heroInfo2use;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.cvHeros reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroDetailViewController *detailVC=[HeroDetailViewController new];
    detailVC.hero2show=[self getHeroInfoWithIndexPath:indexPath];
    
    [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:detailVC animated:YES];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.heroType2showArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    HeroInfo *heroInfo2use=[self getHeroInfoWithIndexPath:indexPath];
    heroCell.lblName.text=heroInfo2use.heroName;
    
    return heroCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        TextContentCollectionReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]
                                                                                               forIndexPath:indexPath];
        
        NSString *typeId=self.heroType2showArr[indexPath.section];
        NSString *title2set=@"";
        UIColor *color2set=[UIColor clearColor];
        if ([typeId isEqualToString:[MyUtility heroTypeLiliangId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_liliang_hero", @""),(int)self.liLiangHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForHong]];
        } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_zhili_hero", @""),(int)self.zhiLiHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForLan]];
        } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_minjie_hero", @""),(int)self.minJieHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForLv]];
        }
        headerView.lblContent.text=title2set;
        headerView.lblContent.textColor=color2set;
        
        reusableView2ret=headerView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}

@end
