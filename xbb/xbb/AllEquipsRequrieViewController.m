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
@property (nonatomic,strong) NSArray *allEquipsShowingArr;
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
}

-(void)screenOrientationChangedHandle
{
    [self.cvCountedEquips reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateComposeEquipsArrForEquip:(NSString *)equipId
{
    self.allEquipsShowingArr=[NSMutableArray new];
    
    NSArray *allEquips=[MyUtility getAllEquipInfoFromDbCache];
    NSDictionary *allEquipComposeInfoDict=[MyUtility getAllEquipComposeInfoDictCache];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *arr2ret=[NSMutableArray new];
        
        for (EquipInfo *aEquipInfo in allEquips) {
            if (!aEquipInfo.isCompose) {
                [arr2ret addObject:aEquipInfo];
            } else {
                EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:aEquipInfo.equipId];
                if (composeInfo.fragmentCount > 0) {
                    [arr2ret addObject:aEquipInfo];
                } else {
                    
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
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
    return [MyAppSizeInfo equipBriefCVItemSize];
}

@end
