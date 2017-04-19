//
//  EquipsViewController.m
//  xbb
//
//  Created by  qin on 2017/4/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipsViewController.h"
#import "MyUtility.h"
#import "AllEquipsRequrieViewController.h"
#import "EquipComposeViewController.h"
#import "EquipBriefInfoCollectionViewCell.h"
#import "TextContentCollectionReusableView.h"

@interface EquipsViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *allEquipsArr;
@property (nonatomic,strong) NSMutableDictionary *equipRankDict;

@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSArray *equipRank2showArr;
@end

@implementation EquipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_equip", @"");
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"title_for_all_equips_requrie", @"")
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(showAllEquipRequire)];
    
    [self.cvEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo]];
    [self.cvEquips registerNib:[UINib nibWithNibName:@"TextContentCollectionReusableView" bundle:[NSBundle mainBundle]]
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
          withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]];
    
    [self initEquipInfo];
}

-(void)showAllEquipRequire
{
    AllEquipsRequrieViewController *allEquipsRequrieVC=[AllEquipsRequrieViewController new];
//    allEquipsRequrieVC.composeActionDelegate=self;
    
    [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:allEquipsRequrieVC animated:YES];
}

-(void)initEquipInfo
{
    self.allEquipsArr=[MyUtility getAllEquipInfoFromDbCache];
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    self.equipRank2showArr=[NSMutableArray arrayWithObjects:[MyUtility rankIdForHong],
                            [MyUtility rankIdForCheng],
                            [MyUtility rankIdForZi],
                            [MyUtility rankIdForLan],
                            [MyUtility rankIdForLv],
                            [MyUtility rankIdForBai],
                            nil];
    
    self.equipRankDict=[NSMutableDictionary new];
    
    for (NSString *aRankId in self.equipRank2showArr) {
        [self.equipRankDict setObject:[NSMutableArray new] forKey:aRankId];
    }
    
    for (EquipInfo *aEquipInfo in self.allEquipsArr) {
        if (aEquipInfo.showInBook) {
            NSMutableArray *equipArr=self.equipRankDict[aEquipInfo.equipRank];
            [equipArr addObject:aEquipInfo];
        }
    }
}

-(void)screenOrientationChangedHandle
{
    [self.cvEquips reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipComposeViewController *composeVC=[EquipComposeViewController new];
    
    NSString *rankId=self.equipRank2showArr[indexPath.section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    EquipInfo *equipInfo2use=equipsArr[indexPath.row];
    
    composeVC.equipInfo=equipInfo2use;
//    composeVC.composeActionDelegate=self;
    
    [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:composeVC animated:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *rankId=self.equipRank2showArr[section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    return equipsArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:[MyAppCellIdInfo cellIdForCVEquiBriefInfo] forIndexPath:indexPath];

    NSString *rankId=self.equipRank2showArr[indexPath.section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    EquipInfo *equipInfo2use=equipsArr[indexPath.row];
    
    equipBriefCell.lblName.text=equipInfo2use.equipName;
    return equipBriefCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.equipRank2showArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView2ret=nil;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        TextContentCollectionReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                         withReuseIdentifier:[MyAppCellIdInfo cellIdForTextContentCVReusableViewId]
                                                                                                forIndexPath:indexPath];
        
        NSString *rankId=self.equipRank2showArr[indexPath.section];
        NSArray *equipsArr=self.equipRankDict[rankId];
        NSString *title2set=@"";
        UIColor *color2set=[UIColor clearColor];
        if ([rankId isEqualToString:[MyUtility rankIdForBai]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_bai", @""),(int)equipsArr.count];
        } else if ([rankId isEqualToString:[MyUtility rankIdForLv]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_lv", @""),(int)equipsArr.count];
        } else if ([rankId isEqualToString:[MyUtility rankIdForLan]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_lan", @""),(int)equipsArr.count];
        } else if ([rankId isEqualToString:[MyUtility rankIdForZi]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_zi", @""),(int)equipsArr.count];
        } else if ([rankId isEqualToString:[MyUtility rankIdForCheng]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_cheng", @""),(int)equipsArr.count];
        } else if ([rankId isEqualToString:[MyUtility rankIdForHong]]) {
            title2set=[NSString stringWithFormat:@"%@( %d ):",NSLocalizedString(@"title_equip_hong", @""),(int)equipsArr.count];
        }
        color2set=[MyUtility rankColorForRankId:rankId];
        headerView.lblContent.text=title2set;
        headerView.lblContent.textColor=color2set;
        
        reusableView2ret=headerView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [MyAppSizeInfo equipBriefCVItemSize];
}

@end
