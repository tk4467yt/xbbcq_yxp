//
//  Juexing2shendianViewController.m
//  xbb
//
//  Created by  qin on 2017/4/21.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "Juexing2shendianViewController.h"
#import "MyUtility.h"
#import "HeroCollectionViewCell.h"
#import "TextContentCollectionReusableView.h"

@interface Juexing2shendianViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSDictionary *shendianInfoDict;
@property (nonatomic,strong) NSDictionary *juexing2shendianInfoDict;
@property (nonatomic,strong) NSArray *shendianIdArr;
@end

@implementation Juexing2shendianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.shendianInfoDict=[DbHandler getAllShenDianInfoDict];
    self.juexing2shendianInfoDict=[DbHandler getAllJuexing2shenDianInfoDict];
    
    self.shendianIdArr=[self.shendianInfoDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        NSString *str1=self.shendianInfoDict[obj1];
        NSString *str2=self.shendianInfoDict[obj2];
        return [str1 compare:str2];
    }];
    
    [self.cvJuexing2shendian registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo]];
    [self.cvJuexing2shendian registerNib:[UINib nibWithNibName:@"TextContentCollectionReusableView" bundle:[NSBundle mainBundle]]
         forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]];
    
    self.navigationItem.title=NSLocalizedString(@"title_for_juexing2_shendian", @"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenOrientationChangedHandle
{
    [self.cvJuexing2shendian reloadData];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *shendianId=self.shendianIdArr[section];
    NSArray *heroIdArr=self.juexing2shendianInfoDict[shendianId];
    return heroIdArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCollectionViewCell *heroCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForHeroInfo] forIndexPath:indexPath];
    
    NSString *shendianId=self.shendianIdArr[indexPath.section];
    NSArray *heroIdArr=self.juexing2shendianInfoDict[shendianId];
    HeroInfo *heroInfo2use=[MyUtility getCachedHeroInfoWithHeroId:heroIdArr[indexPath.row]];
    heroCell.lblName.text=heroInfo2use.heroName;
    heroCell.contentView.backgroundColor=[MyUtility rankColorForRankId:[MyUtility rankIdForZi]];
    return heroCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.shendianIdArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        TextContentCollectionReusableView *equipView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]
                                                                                               forIndexPath:indexPath];
        
        NSString *shendianId=self.shendianIdArr[indexPath.section];
        equipView.lblContent.text=self.shendianInfoDict[shendianId];
        
        reusableView2ret=equipView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo heroBriefCVItemSize];
}

@end
