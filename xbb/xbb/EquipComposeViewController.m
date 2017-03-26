//
//  EquipComposeViewController.m
//  xbb
//
//  Created by  qin on 2017/3/9.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeViewController.h"
#import "HeroCollectionViewCell.h"
#import "EquipComposeHeaderTableViewCell.h"
#import "EquipComposeContentTableViewCell.h"
#import "EquipComposeAttrTableViewCell.h"
#import "EquipComposeableTableViewCell.h"
#import "EquipComposeHerosTableViewCell.h"
#import "MyUtility.h"
#import "DbHandler.h"
#import "EquipComposeInfo.h"

#define equipComposeHeaderCellId @"equip_compose_header_tb_cell_id"
#define equipComposeContentCellId @"equip_compose_content_tb_cell_id"
#define equipComposeAttrCellId @"equip_compose_attr_tb_cell_id"
#define equipComposeableCellId @"equip_composeable_tb_cell_id"
#define equipComposeHerosCellId @"equip_compose_heros_tb_cell_id"

@interface EquipComposeViewController () <UITableViewDelegate,UITableViewDataSource,EquipComposeItemActionDelegate,EquipComposeableActionDelegate>
@property (nonatomic,strong) NSMutableArray *equip2showArr;

@property (nonatomic,strong) NSMutableArray *composeEquipsArr;
@property (nonatomic,strong) NSMutableArray *composeHeroEquipsArr;
@end

@implementation EquipComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initEquip2show];
    
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeHeaderCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeContentCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeAttrTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeAttrCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeableTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeableCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeHerosTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeHerosCellId];
}

-(void)initEquip2show
{
    self.equip2showArr=[NSMutableArray new];
    [self.equip2showArr addObject:self.equipInfo.equipId];
    
    [self updateNavTitle];
}

-(void)updateNavTitle
{
    EquipInfo *equipInfo=[MyUtility getEquipInfoForEquipIdCache:self.equip2showArr.lastObject];
    self.navigationItem.title=equipInfo.equipName;
    
    [self updateComposeEquipsArrForEquip:self.equip2showArr.lastObject];
    [self updateComposeHerosForEquip:self.equip2showArr.lastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightForEquipComposeCell
{
    if (self.equipInfo.isCompose) {
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equip2showArr.lastObject];
        
        if (composeInfo.fragmentCount > 0) {
            return 150;
        } else {
            NSMutableArray *composeIdArr=[NSMutableArray new];
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom1]) {
                [composeIdArr addObject:composeInfo.composeFrom1];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom2]) {
                [composeIdArr addObject:composeInfo.composeFrom2];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom3]) {
                [composeIdArr addObject:composeInfo.composeFrom3];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom4]) {
                [composeIdArr addObject:composeInfo.composeFrom4];
            }
            
            if (2 == composeIdArr.count) {
                return 220;
            } else if (3 == composeIdArr.count) {
                return 220;
            } else if (4 == composeIdArr.count) {
                return 220;
            } else {
                return 80;
            }
        }
    } else {
        return 80;
    }
    
    return 80;
}

-(NSInteger)numberOfEquipAttr2show
{
    NSInteger count2ret=1;
    
    EquipInfo *curEquipInfo=[MyUtility getEquipInfoForEquipIdCache:self.equip2showArr.lastObject];
    
    if (curEquipInfo.liliang != 0) {
        ++count2ret;
    }
    if (curEquipInfo.minjie != 0) {
        ++count2ret;
    }
    if (curEquipInfo.zhili != 0) {
        ++count2ret;
    }
    if (curEquipInfo.healthMax != 0) {
        ++count2ret;
    }
    if (curEquipInfo.healthRecover != 0) {
        ++count2ret;
    }
    if (curEquipInfo.energyRecover != 0) {
        ++count2ret;
    }
    if (curEquipInfo.physicsGongji != 0) {
        ++count2ret;
    }
    if (curEquipInfo.physicsHujia != 0) {
        ++count2ret;
    }
    if (curEquipInfo.physicsBaoji != 0) {
        ++count2ret;
    }
    if (curEquipInfo.chuantouPhysicsHujia != 0) {
        ++count2ret;
    }
    if (curEquipInfo.magicQiangdu != 0) {
        ++count2ret;
    }
    if (curEquipInfo.magicBaoji != 0) {
        ++count2ret;
    }
    if (curEquipInfo.magicKangxing != 0) {
        ++count2ret;
    }
    if (curEquipInfo.hulueMagicKangxing != 0) {
        ++count2ret;
    }
    if (curEquipInfo.xixue != 0) {
        ++count2ret;
    }
    if (curEquipInfo.zhiliaoXiaoguo != 0) {
        ++count2ret;
    }
    if (curEquipInfo.shangbi != 0) {
        ++count2ret;
    }
    if (curEquipInfo.mingzhong != 0) {
        ++count2ret;
    }
    if (curEquipInfo.minusControlTime != 0) {
        ++count2ret;
    }
    if (curEquipInfo.yingzhiDikang != 0) {
        ++count2ret;
    }
    if (curEquipInfo.chengmoDikang != 0) {
        ++count2ret;
    }
    if (curEquipInfo.minusNengliangXiaohao != 0) {
        ++count2ret;
    }
    if (curEquipInfo.skillLevelAddon != 0) {
        ++count2ret;
    }
    if (curEquipInfo.siWangDuiFangHuiNengJianBan != 0) {
        ++count2ret;
    }
    
    return count2ret;
}

- (void)equipComposeItemTappedWithEquipId:(NSString *)itemId
{
    BOOL isItemExist=false;
    for (NSString *aEquipId in self.equip2showArr) {
        if ([aEquipId isEqualToString:itemId]) {
            isItemExist=true;
        }
    }
    
    if (!isItemExist) {
        [self.equip2showArr addObject:itemId];
    } else {
        NSInteger itemIdx=[self.equip2showArr indexOfObject:itemId];
        NSInteger count2remove=self.equip2showArr.count-itemIdx-1;
        for (int i=0; i<count2remove; ++i) {
            [self.equip2showArr removeLastObject];
        }
    }
    
    [self updateNavTitle];
    [self.tbContent reloadData];
}

-(void)updateComposeEquipsArrForEquip:(NSString *)equipId
{
    self.composeEquipsArr=[NSMutableArray new];
    
    NSDictionary *allEquipComposeInfoDict=[MyUtility getAllEquipComposeInfoDictCache];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *arr2ret=[NSMutableArray new];
        
        if (![MyUtility isStringNilOrZeroLength:equipId]) {
            for (NSString *aEquipId in allEquipComposeInfoDict.allKeys) {
                EquipComposeInfo *aComposeInfo=allEquipComposeInfoDict[aEquipId];
                if ([equipId isEqualToString:aComposeInfo.composeFrom1]) {
                    EquipInfo *equip2add=[MyUtility getEquipInfoForEquipIdCache:aEquipId];
                    if (nil != equip2add) {
                        [arr2ret addObject:equip2add];
                    }
                    continue;
                }
                if ([equipId isEqualToString:aComposeInfo.composeFrom2]) {
                    EquipInfo *equip2add=[MyUtility getEquipInfoForEquipIdCache:aEquipId];
                    if (nil != equip2add) {
                        [arr2ret addObject:equip2add];
                    }
                    continue;
                }
                if ([equipId isEqualToString:aComposeInfo.composeFrom3]) {
                    EquipInfo *equip2add=[MyUtility getEquipInfoForEquipIdCache:aEquipId];
                    if (nil != equip2add) {
                        [arr2ret addObject:equip2add];
                    }
                    continue;
                }
                if ([equipId isEqualToString:aComposeInfo.composeFrom4]) {
                    EquipInfo *equip2add=[MyUtility getEquipInfoForEquipIdCache:aEquipId];
                    if (nil != equip2add) {
                        [arr2ret addObject:equip2add];
                    }
                    continue;
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([equipId isEqualToString:self.equip2showArr.lastObject]) {
                [self.composeEquipsArr removeAllObjects];
                [self.composeEquipsArr addObjectsFromArray:arr2ret];
                
                [self.tbContent reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        });
    });
    
}

-(void)updateComposeHerosForEquip:(NSString *)equipId
{
    self.composeHeroEquipsArr=[NSMutableArray new];
    
    NSArray *allHeroEquips=[MyUtility getCachedAllHeroEquips];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *arr2ret=[NSMutableArray new];
        
        if (![MyUtility isStringNilOrZeroLength:equipId]) {
            for (HeroEquips *aHeroEquip in allHeroEquips) {
                if ([aHeroEquip.equip1 isEqualToString:equipId] ||
                    [aHeroEquip.equip2 isEqualToString:equipId] ||
                    [aHeroEquip.equip3 isEqualToString:equipId] ||
                    [aHeroEquip.equip4 isEqualToString:equipId] ||
                    [aHeroEquip.equip5 isEqualToString:equipId] ||
                    [aHeroEquip.equip6 isEqualToString:equipId]) {
                    [arr2ret addObject:aHeroEquip];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([equipId isEqualToString:self.equip2showArr.lastObject]) {
                [self.composeHeroEquipsArr removeAllObjects];
                [self.composeHeroEquipsArr addObjectsFromArray:arr2ret];
                
                [self.tbContent reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:4]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        });
    });
}

-(void)screenOrientationChangedHandle
{
    [self.tbContent reloadData];
}

#pragma mark EquipComposeableActionDelegate
-(void)didSelectComposeableEquip:(EquipInfo *)equipSelected
{
    self.equipInfo=equipSelected;
    [self initEquip2show];
    
    [self.tbContent reloadData];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 84;
    } else if (1 == indexPath.section) {
        return [self heightForEquipComposeCell];
    } else if (2 == indexPath.section) {
        return [self numberOfEquipAttr2show]*30+16;
    } else if (3 == indexPath.section) {
        return [MyAppSizeInfo cacTableCellHeightForCVWithMaxWidth:[MyUtility screenWidth]-16
                                                      andItemSize:[MyAppSizeInfo equipBriefCVItemSmallSize]
                                                     andItemCount:self.composeEquipsArr.count
                                                    andLineOffset:0]+18+16;
    } else if (4 == indexPath.section) {
        return [MyAppSizeInfo cacTableCellHeightForCVWithMaxWidth:[MyUtility screenWidth]-16
                                                      andItemSize:[MyAppSizeInfo heroBriefCVItemSize]
                                                     andItemCount:self.composeHeroEquipsArr.count
                                                    andLineOffset:0]+18+16;
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    } else if (1 == section) {
        return 1;
    } else if (2 == section) {
        return 1;
    } else if (3 == section) {
        return 1;
    } else if (4 == section) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell2ret=nil;
    
    if (0 == indexPath.section) {
        EquipComposeHeaderTableViewCell *headerCell=[tableView dequeueReusableCellWithIdentifier:equipComposeHeaderCellId];
        headerCell.equipShowingArr=self.equip2showArr;
        headerCell.itemActionDelegate=self;
        
        cell2ret=headerCell;
    } else if (1 == indexPath.section) {
        EquipComposeContentTableViewCell *contentCell=[tableView dequeueReusableCellWithIdentifier:equipComposeContentCellId];
        contentCell.equipId2show=self.equip2showArr.lastObject;
        contentCell.itemActionDelegate=self;
        
        cell2ret=contentCell;
    } else if (2 == indexPath.section) {
        EquipComposeAttrTableViewCell *attrCell=[tableView dequeueReusableCellWithIdentifier:equipComposeAttrCellId];
        attrCell.equipInfo2show=[MyUtility getEquipInfoForEquipIdCache:self.equip2showArr.lastObject];
        
        cell2ret=attrCell;
    } else if (3 == indexPath.section) {
        EquipComposeableTableViewCell *composeableCell=[tableView dequeueReusableCellWithIdentifier:equipComposeableCellId];
        composeableCell.composeableEquipsArr=self.composeEquipsArr;
        composeableCell.equipInfoShowing=[MyUtility getEquipInfoForEquipIdCache:self.equip2showArr.lastObject];
        composeableCell.composeableActionDelegate=self;
        
        cell2ret=composeableCell;
    } else if (4 == indexPath.section) {
        EquipComposeHerosTableViewCell *heroCell=[tableView dequeueReusableCellWithIdentifier:equipComposeHerosCellId];
        heroCell.equipInfoShowing=[MyUtility getEquipInfoForEquipIdCache:self.equip2showArr.lastObject];
        heroCell.heroEquipsArr=self.composeHeroEquipsArr;
        heroCell.composeActionDelegate=self.composeActionDelegate;
        
        cell2ret=heroCell;
    } else {
        cell2ret=[UITableViewCell new];
    }
    
    if (0 == indexPath.section%2) {
        cell2ret.backgroundColor=[UIColor lightGrayColor];
    } else {
        cell2ret.backgroundColor=[UIColor grayColor];
    }
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
@end
