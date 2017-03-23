//
//  SecondViewController.m
//  xbb
//
//  Created by  qin on 2017/2/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "SecondViewController.h"
#import "EquipComposeViewController.h"
#import "DbHandler.h"
#import "MyUtility.h"
#import "EquipInfo.h"
#import "RankDesc.h"
#import "EquipBriefInfoCollectionViewCell.h"
#import "EquipHeaderCollectionReusableView.h"

#define equipBriefReusableCellId @"equip_brief_info_cell_id"

@interface SecondViewController ()
@property (nonatomic,strong) NSArray *allEquipsArr;
@property (nonatomic,strong) NSMutableDictionary *equipRankDict;

@property (nonatomic,strong) NSDictionary *rankDescDict;

@property (nonatomic,strong) NSArray *equipRank2showArr;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=NSLocalizedString(@"nav_title_equip", @"");
    
    [self.cvEquips registerNib:[UINib nibWithNibName:@"EquipBriefInfoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:equipBriefReusableCellId];
    
    [self initEquipInfo];
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
    
    [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:composeVC animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipBriefInfoCollectionViewCell *equipBriefCell=(EquipBriefInfoCollectionViewCell *)cell;
    equipBriefCell.backgroundView=[[UIImageView alloc] initWithImage:[MyUtility makeMaskImageFroFrame:[UIImage imageNamed:@"handbook_equip_bg"]]];
    
    NSString *rankId=self.equipRank2showArr[indexPath.section];
    NSArray *equipsArr=self.equipRankDict[rankId];
    EquipInfo *equipInfo2use=equipsArr[indexPath.row];
    
    equipBriefCell.ivThumb.image=[UIImage imageNamed:equipInfo2use.thumbFile];
    
    RankDesc *rankDesc2use=self.rankDescDict[rankId];
    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
    equipBriefCell.ivMask.image=[MyUtility makeMaskImageFroFrame:maskImg];
    
    equipBriefCell.lblName.text=equipInfo2use.equipName;
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
    EquipBriefInfoCollectionViewCell *equipBriefCell=[collectionView dequeueReusableCellWithReuseIdentifier:equipBriefReusableCellId forIndexPath:indexPath];
    
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
        EquipHeaderCollectionReusableView *equipView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                              withReuseIdentifier:@"equip_reusable_header_cell_id"
                                                                                     forIndexPath:indexPath];
        
        NSString *rankId=self.equipRank2showArr[indexPath.section];
        NSArray *equipsArr=self.equipRankDict[rankId];
        NSString *title2set=@"";
        UIColor *color2set=[UIColor clearColor];
        if ([rankId isEqualToString:[MyUtility rankIdForBai]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_bai", @""),(int)equipsArr.count];
            color2set=[UIColor lightGrayColor];
        } else if ([rankId isEqualToString:[MyUtility rankIdForLv]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_lv", @""),(int)equipsArr.count];
            color2set=[UIColor greenColor];
        } else if ([rankId isEqualToString:[MyUtility rankIdForLan]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_lan", @""),(int)equipsArr.count];
            color2set=[UIColor blueColor];
        } else if ([rankId isEqualToString:[MyUtility rankIdForZi]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_zi", @""),(int)equipsArr.count];
            color2set=[UIColor purpleColor];
        } else if ([rankId isEqualToString:[MyUtility rankIdForCheng]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_cheng", @""),(int)equipsArr.count];
            color2set=[UIColor orangeColor];
        } else if ([rankId isEqualToString:[MyUtility rankIdForHong]]) {
            title2set=[NSString stringWithFormat:@"%@( %d )",NSLocalizedString(@"title_equip_hong", @""),(int)equipsArr.count];
            color2set=[UIColor redColor];
        }
        equipView.lblTitle.text=title2set;
        equipView.lblTitle.textColor=color2set;
        
        reusableView2ret=equipView;
    }
    
    return reusableView2ret;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80,100);
}

@end
