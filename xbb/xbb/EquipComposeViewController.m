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
#import "MyUtility.h"
#import "DbHandler.h"

#define equipComposeHeaderCellId @"equip_compose_header_tb_cell_id"
#define equipComposeContentCellId @"equip_compose_content_tb_cell_id"
#define equipComposeAttrCellId @"equip_compose_attr_tb_cell_id"

@interface EquipComposeViewController () <UITableViewDelegate,UITableViewDataSource,EquipComposeItemActionDelegate>
@property (nonatomic,strong) NSMutableArray *equip2showArr;
@end

@implementation EquipComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.equip2showArr=[NSMutableArray new];
    [self.equip2showArr addObject:self.equipInfo.equipId];
    
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeHeaderCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeContentCellId];
    [self.tbContent registerNib:[UINib nibWithNibName:@"EquipComposeAttrTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:equipComposeAttrCellId];
    
    [self updateNavTitle];
}

-(void)updateNavTitle
{
    EquipInfo *equipInfo=[MyUtility getEquipInfoForEquipId:self.equip2showArr.lastObject];
    self.navigationItem.title=equipInfo.equipName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightForEquipComposeCell
{
    if (self.equipInfo.isCompose) {
        EquipComposeInfo *composeInfo=[DbHandler getEquipComposeInfoForEquipId:self.equip2showArr.lastObject];
        
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
    
    EquipInfo *curEquipInfo=[MyUtility getEquipInfoForEquipId:self.equip2showArr.lastObject];
    
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

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 84;
    } else if (1 == indexPath.section) {
        return [self heightForEquipComposeCell];
    } else if (2 == indexPath.section) {
        return [self numberOfEquipAttr2show]*30+16;
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
        attrCell.equipInfo2show=[MyUtility getEquipInfoForEquipId:self.equip2showArr.lastObject];
        
        cell2ret=attrCell;
    } else {
        cell2ret=[UITableViewCell new];
    }
    
    [cell2ret setNeedsLayout];
    return cell2ret;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
@end
