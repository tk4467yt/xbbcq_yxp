//
//  JueXingSuipianFromViewController.m
//  xbb
//
//  Created by  qin on 2017/4/21.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "JueXingSuipianFromViewController.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"
#import "TextContentCollectionReusableView.h"

@interface JueXingSuipianFromViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSDictionary *juexingFromDict;
@property (nonatomic,strong) NSArray *fromDescArr;
@end

@implementation JueXingSuipianFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.juexingFromDict=[DbHandler getAllJuexingSuipianFromDict];
    self.fromDescArr=[self.juexingFromDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    
    [self.cvSuipianFrom registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
    [self.cvSuipianFrom registerNib:[UINib nibWithNibName:@"TextContentCollectionReusableView" bundle:[NSBundle mainBundle]]
   forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
          withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]];
    
    self.navigationItem.title=NSLocalizedString(@"title_for_juexing_suipian_from", @"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.cvSuipianFrom reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *fromDesc=self.fromDescArr[section];
    NSArray *heroIdArr=self.juexingFromDict[fromDesc];
    return heroIdArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    NSString *fromDesc=self.fromDescArr[indexPath.section];
    NSArray *heroIdArr=self.juexingFromDict[fromDesc];
    HeroInfo *heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:heroIdArr[indexPath.row]];
    heroCell.lblName.text=heroInfo2use.heroName;
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:[MyUtility rankIdForZi]];
    return heroCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.fromDescArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        TextContentCollectionReusableView *equipView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]
                                                                                               forIndexPath:indexPath];
        
        equipView.lblContent.text=self.fromDescArr[indexPath.section];
        
        reusableView2ret=equipView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}

@end
