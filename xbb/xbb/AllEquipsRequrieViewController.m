//
//  AllEquipsRequrieViewController.m
//  xbb
//
//  Created by  qin on 2017/3/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "AllEquipsRequrieViewController.h"
#import "EquipBriefInfoCollectionViewCell.h"
#import "MyUtility.h"
#import "TextContentCollectionReusableView.h"

@interface AllEquipsRequrieViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *allEquipsShowingArr;
@property (nonatomic,strong) NSMutableDictionary *nonComposeEquipCountDict;
@property (nonatomic,strong) NSDictionary *rankDescDict;
@end

@implementation AllEquipsRequrieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"title_for_all_equips_requrie", @"");
    
    [self.cvCountedEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]]
           forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo]];
    [self.cvCountedEquips registerNib:[UINib nibWithNibName:@"TextContentCollectionReusableView" bundle:[NSBundle mainBundle]]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]];
    
    self.loadingView.hidden=false;
    self.lblLoading.text=NSLocalizedString(@"desc_for_loading", @"");
    [self.aidLoading startAnimating];
    
    [self updateNonComposeEquipsArr];
}

-(void)screenOrientationChangedHandle
{
    [self.cvCountedEquips reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateNonComposeEquipsArr
{
    self.allEquipsShowingArr=[NSMutableArray new];
    
    if (nil == self.nonComposeEquipCountDict) {
        self.nonComposeEquipCountDict=[NSMutableDictionary new];
    } else {
        [self.nonComposeEquipCountDict removeAllObjects];
    }
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    NSArray *allHeros=[MyUtility getCachedAllHeros];
    NSArray *allHeroEquips=[MyUtility getCachedAllHeroEquips];//call to cache,or db handle in global_queue may crash
    NSArray *allEquipInfo=[MyUtility getAllEquipInfoFromDbCache];//call to cache
    NSDictionary *allEquipComposeInfoDict=[MyUtility getAllEquipComposeInfoDictCache];//call to cache
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *arr2ret=[NSMutableArray new];
        
        for (HeroInfo *aHeroInfo in allHeros) {
            NSArray *tmpArr=[MyUtility getNonComposeEquipInfoForHero:aHeroInfo
                                                  withHeroEquipsDict:[MyUtility getCachedHeroEquipsDictForHero:aHeroInfo.heroId]
                                                  andNonShownRankArr:[NSArray array]];
            
            [arr2ret addObjectsFromArray:tmpArr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loadingView.hidden=TRUE;
            [self.aidLoading stopAnimating];
            
            for (EquipInfo *aEquipInfo in arr2ret) {
                if (![MyUtility isStringNilOrZeroLength:aEquipInfo.equipId]) {
                    NSNumber *countNumber=self.nonComposeEquipCountDict[aEquipInfo.equipId];
                    if (nil == countNumber) {
                        [self.nonComposeEquipCountDict setObject:[NSNumber numberWithInt:1] forKey:aEquipInfo.equipId];
                        [self.allEquipsShowingArr addObject:aEquipInfo];
                    } else {
                        [self.nonComposeEquipCountDict setObject:[NSNumber numberWithInt:countNumber.intValue+1] forKey:aEquipInfo.equipId];
                    }
                }
            }
            
            [self.allEquipsShowingArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                EquipInfo *equip1=(EquipInfo *)obj1;
                EquipInfo *equip2=(EquipInfo *)obj2;
                
                NSNumber *countNumber1=self.nonComposeEquipCountDict[equip1.equipId];
                NSNumber *countNumber2=self.nonComposeEquipCountDict[equip2.equipId];
                
                if (countNumber1.integerValue > countNumber2.integerValue) {
                    return NSOrderedAscending;
                } else if (countNumber1.integerValue < countNumber2.integerValue) {
                    return NSOrderedDescending;
                } else {
                    return NSOrderedSame;
                }
            }];
            
            [self.cvCountedEquips reloadData];
        });
    });
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
    //    equipBriefCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
    equipBriefCell.noNameShown=true;
    
    EquipInfo *equipInfo2use=self.allEquipsShowingArr[indexPath.row];
    equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
    
    RankDesc *rankDesc2use=self.rankDescDict[equipInfo2use.equipRank];
    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
    equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    equipBriefCell.lblCount.hidden=false;
    NSNumber *countNumber=[self.nonComposeEquipCountDict objectForKey:equipInfo2use.equipId];
    equipBriefCell.lblCount.text=[NSString stringWithFormat:@"%d",countNumber.intValue];
    
    [equipBriefCell setNeedsUpdateConstraints];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allEquipsShowingArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo] forIndexPath:indexPath];
    
    return equipBriefCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        TextContentCollectionReusableView *equipView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]
                                                                                               forIndexPath:indexPath];
        
        equipView.lblContent.text=NSLocalizedString(@"desc_for_all_equips_requrie", @"");
        
        reusableView2ret=equipView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo equipBriefCVItemSmallSize];
}

@end
