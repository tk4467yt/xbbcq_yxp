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
#import "HeroInfo.h"
#import "MyUtility.h"

#define heroBriefReusableCellId @"hero_cv_cell_id"

@interface FirstViewController ()
@property (nonatomic,strong) NSArray *allHerosArr;
@property (nonatomic,strong) NSMutableArray *liLiangHerosArr;
@property (nonatomic,strong) NSMutableArray *zhiLiHerosArr;
@property (nonatomic,strong) NSMutableArray *minJieHerosArr;

@property (nonatomic,strong) NSMutableArray *heroType2showArr;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=NSLocalizedString(@"title_hero", @"");
    
    [self initHerosInfo];
    
    [self.cvHeros registerNib:[UINib nibWithNibName:@"HeroCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:heroBriefReusableCellId];
}

-(void)initHerosInfo
{
    self.allHerosArr=[DbHandler getAllHeros];
    
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
    heroCell.lblName.text=heroInfo2use.heroName;
    return heroCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.heroType2showArr.count;
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80,100);
}

@end
