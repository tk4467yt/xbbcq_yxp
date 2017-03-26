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
#import "HeroDetailViewController.h"

@interface FirstViewController ()
@property (nonatomic,strong) NSArray *allHerosArr;
@property (nonatomic,strong) NSMutableArray *liLiangHerosArr;
@property (nonatomic,strong) NSMutableArray *zhiLiHerosArr;
@property (nonatomic,strong) NSMutableArray *minJieHerosArr;

@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSMutableArray *heroType2showArr;

@property (nonatomic,assign) BOOL showThumbS;
@property (nonatomic,assign) BOOL showHunXiaHero;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHerosInfo];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(handleForNavAction)];
    
    [self.cvHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
}

-(void)updateNavTitle
{
    if (self.showHunXiaHero) {
        int heroCount=0;
        heroCount += self.liLiangHerosArr.count;
        heroCount += self.zhiLiHerosArr.count;
        heroCount += self.minJieHerosArr.count;
        self.navigationItem.title=[NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"nav_title_hun_xia", @""),heroCount];
    } else {
        self.navigationItem.title=[NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"nav_title_hero", @""),(int)self.allHerosArr.count];
    }
}

-(void)handleForNavAction
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *switchThumbAction = nil;
    if (self.showThumbS) {
        switchThumbAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"hero_title_thumb_normal", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self switchThumbShown];
        }];
    } else {
        switchThumbAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"hero_title_thumb_juexing", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self switchThumbShown];
        }];
    }
    [alertController addAction:switchThumbAction];
    
    UIAlertAction *switchHunXiaHeroAction = nil;
    if (self.showHunXiaHero) {
        switchHunXiaHeroAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"nav_title_hero", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self switchHunXiaHeroShown];
        }];
    } else {
        switchHunXiaHeroAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"nav_title_hun_xia", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self switchHunXiaHeroShown];
        }];
    }
    [alertController addAction:switchHunXiaHeroAction];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"") style:UIAlertActionStyleCancel handler:nil]];
    
//    alertController.popoverPresentationController.sourceView = self.view;
//    alertController.popoverPresentationController.sourceRect = CGRectMake(0,0,1.0,1.0);
    alertController.popoverPresentationController.barButtonItem=self.navigationItem.rightBarButtonItem;
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)switchHunXiaHeroShown
{
    self.showHunXiaHero = !self.showHunXiaHero;
    
    [self updateHeros2shown];
    [self.cvHeros reloadData];
}

-(void)switchThumbShown
{
    self.showThumbS= !self.showThumbS;
    [self.cvHeros reloadData];
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

-(void)screenOrientationChangedHandle
{
    [self.cvHeros reloadData];
}

-(void)updateHeros2shown
{
    [self.liLiangHerosArr removeAllObjects];
    [self.zhiLiHerosArr removeAllObjects];
    [self.minJieHerosArr removeAllObjects];
    
    for (HeroInfo *aHeroInfo in self.allHerosArr) {
        if (self.showHunXiaHero && !aHeroInfo.isHunXiaHero) {
            continue;
        }
        if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeLiliangId]]) {
            [self.liLiangHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeZhiliId]]) {
            [self.zhiLiHerosArr addObject:aHeroInfo];
        } else if ([aHeroInfo.heroType isEqualToString:[MyUtility heroTypeMinjieId]]) {
            [self.minJieHerosArr addObject:aHeroInfo];
        }
    }
    
    [self updateNavTitle];
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
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
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
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_liliang_hero", @""),(int)self.liLiangHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForHong]];
        } else if ([typeId isEqualToString:[MyUtility heroTypeZhiliId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_zhili_hero", @""),(int)self.zhiLiHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForLan]];
        } else if ([typeId isEqualToString:[MyUtility heroTypeMinjieId]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_minjie_hero", @""),(int)self.minJieHerosArr.count];
            color2set=[MyUtility rankColorForRankId:[MyUtility rankIdForLv]];
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
    HeroDetailViewController *detailVC=[HeroDetailViewController new];
    detailVC.hero2show=[self getHeroInfoWithIndexPath:indexPath];
    
    [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:detailVC animated:YES];
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=(HeroCollectionViewCell *)cell;
    heroCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
    
    HeroInfo *heroInfo2use=[self getHeroInfoWithIndexPath:indexPath];
    
    if (self.showThumbS && ![MyUtility isStringNilOrZeroLength:heroInfo2use.thumbFileS]) {
        heroCell.ivThumb.image=[UIImage imageNamed:heroInfo2use.thumbFileS];
    } else {
        heroCell.ivThumb.image=[UIImage imageNamed:heroInfo2use.thumbFile];
    }
    
    RankDesc *rankDesc=[self.rankDescDict objectForKey:[MyUtility rankIdForBai]];
    UIImage *maskImg=[UIImage imageNamed:rankDesc.heroIconFrameThumb];
    heroCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    heroCell.lblName.text=heroInfo2use.heroName;
    
    HeroTypeDesc *typeDesc=self.heroTypeDescDict[heroInfo2use.heroType];
    heroCell.ivType.image=[UIImage imageNamed:typeDesc.typeThumb];
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}

@end
