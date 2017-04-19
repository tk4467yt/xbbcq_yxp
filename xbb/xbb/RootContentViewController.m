//
//  RootContentViewController.m
//  xbb
//
//  Created by  qin on 2017/4/17.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "RootContentViewController.h"
#import "MainCategoryCollectionViewCell.h"
#import "HerosViewController.h"
#import "EquipsViewController.h"
#import "MyUtility.h"

#define CATEGORY_2_SHOW_HERO @"hero"
#define CATEGORY_2_SHOW_EQUIP @"equip"
#define CATEGORY_2_SHOW_JUE_XING @"jue_xing"
#define CATEGORY_2_SHOW_JUE_XING_2 @"jue_xing_2"
#define CATEGORY_2_SHOW_FU_SHI @"fu_shi"
#define CATEGORY_2_SHOW_MENG_JING @"meng_jing"
#define CATEGORY_2_SHOW_TUAN_BEN @"tuan_ben"

@interface RootContentViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *categoryArr;
@end

@implementation RootContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=NSLocalizedString(@"title_for_main_content", @"");
    
    self.categoryArr=[NSMutableArray arrayWithObjects:CATEGORY_2_SHOW_HERO,
                      CATEGORY_2_SHOW_EQUIP,
                      CATEGORY_2_SHOW_JUE_XING,
                      CATEGORY_2_SHOW_JUE_XING_2,
                      CATEGORY_2_SHOW_FU_SHI,
                      CATEGORY_2_SHOW_MENG_JING,
                      CATEGORY_2_SHOW_TUAN_BEN,nil];
    
}

-(void)screenOrientationChangedHandle
{
    [self.cvCategory reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *curCategory=self.categoryArr[indexPath.row];
    if ([CATEGORY_2_SHOW_HERO isEqualToString:curCategory]) {
        HerosViewController *detailVC=[HerosViewController new];
        
        [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:detailVC animated:YES];
    } else if ([CATEGORY_2_SHOW_EQUIP isEqualToString:curCategory]) {
        EquipsViewController *detailVC=[EquipsViewController new];
        
        [MyUtility pushViewControllerFromNav:self.navigationController withTargetVC:detailVC animated:YES];
    } else if ([CATEGORY_2_SHOW_JUE_XING isEqualToString:curCategory]) {
        
    } else if ([CATEGORY_2_SHOW_JUE_XING_2 isEqualToString:curCategory]) {
        
    } else if ([CATEGORY_2_SHOW_FU_SHI isEqualToString:curCategory]) {
        
    } else if ([CATEGORY_2_SHOW_MENG_JING isEqualToString:curCategory]) {
        
    } else if ([CATEGORY_2_SHOW_TUAN_BEN isEqualToString:curCategory]) {
        
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categoryArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCategoryCollectionViewCell *categoryCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"category_cell_id" forIndexPath:indexPath];
    
    NSString *curCategory=self.categoryArr[indexPath.row];
    if ([CATEGORY_2_SHOW_HERO isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"hero"];
    } else if ([CATEGORY_2_SHOW_EQUIP isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"equip"];
    } else if ([CATEGORY_2_SHOW_JUE_XING isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"juexing"];
    } else if ([CATEGORY_2_SHOW_JUE_XING_2 isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"juexing2"];
    } else if ([CATEGORY_2_SHOW_FU_SHI isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"fushi"];
    } else if ([CATEGORY_2_SHOW_MENG_JING isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"mengjing"];
    } else if ([CATEGORY_2_SHOW_TUAN_BEN isEqualToString:curCategory]) {
        categoryCell.ivCategory.image=[UIImage imageNamed:@"tuanben"];
    }
    
    return categoryCell;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

@end
