//
//  EquipComposeAttrTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/12.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeAttrTableViewCell.h"
#import "EquipComposeAttrItemTableViewCell.h"
#import "DbHandler.h"
#import "MyUtility.h"

#define kEquipComposeAttrItemTBCellId @"equip_compose_attr_item_tb_cell_id"

@interface EquipComposeAttrTableViewCell () <UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic,strong) NSArray *attrDescArr;
@property (nonatomic,strong) NSMutableArray *attr2showIdArr;
@property (nonatomic,strong) NSMutableArray *value2showArr;
@end

@implementation EquipComposeAttrTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tbAttrs.dataSource=self;
    self.tbAttrs.delegate=self;
    
    [self.tbAttrs registerNib:[UINib nibWithNibName:@"EquipComposeAttrItemTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kEquipComposeAttrItemTBCellId];
    
//    self.attrDescArr=[MyUtility getAllEquipAttrDescArr];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.tbAttrs reloadData];
}

-(void)updateAttrId2show
{
    self.attr2showIdArr=[NSMutableArray new];
    self.value2showArr=[NSMutableArray new];
    
    [self.attr2showIdArr addObject:[NSString stringWithFormat:NSLocalizedString(@"equip_attr_title", @""),self.equipInfo2show.equipName]];
    [self.value2showArr addObject:[NSNumber numberWithInteger:0]];
    
    if (self.equipInfo2show.liliang > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForLiliang]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.liliang]];
    }
    if (self.equipInfo2show.minjie > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMinjie]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.minjie]];
    }
    if (self.equipInfo2show.zhili > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForZhili]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.zhili]];
    }
    if (self.equipInfo2show.healthMax > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForHealthMax]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.healthMax]];
    }
    if (self.equipInfo2show.healthRecover > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForHealthRecover]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.healthRecover]];
    }
    if (self.equipInfo2show.energyRecover > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForEnergyRecover]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.energyRecover]];
    }
    if (self.equipInfo2show.physicsGongji > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForPhysicsGongji]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.physicsGongji]];
    }
    if (self.equipInfo2show.physicsHujia > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForPhysicsHujia]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.physicsHujia]];
    }
    if (self.equipInfo2show.physicsBaoji > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForPhysicsBaoji]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.physicsBaoji]];
    }
    if (self.equipInfo2show.chuantouPhysicsHujia > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForChuantouPhysicsHujia]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.chuantouPhysicsHujia]];
    }
    if (self.equipInfo2show.magicQiangdu > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMagicQiangdu]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.magicQiangdu]];
    }
    if (self.equipInfo2show.magicBaoji > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMagicBaoji]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.magicBaoji]];
    }
    if (self.equipInfo2show.magicKangxing > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMagicKangxing]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.magicKangxing]];
    }
    if (self.equipInfo2show.hulueMagicKangxing > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForHulueMagicKangxing]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.hulueMagicKangxing]];
    }
    if (self.equipInfo2show.xixue > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForXixue]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.xixue]];
    }
    if (self.equipInfo2show.zhiliaoXiaoguo > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForZhiliaoXiaoguo]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.zhiliaoXiaoguo]];
    }
    if (self.equipInfo2show.shangbi > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForShangbi]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.shangbi]];
    }
    if (self.equipInfo2show.mingzhong > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMingzhong]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.mingzhong]];
    }
    if (self.equipInfo2show.minusControlTime > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMinusControlTime]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.minusControlTime]];
    }
    if (self.equipInfo2show.yingzhiDikang > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForYingzhiDikang]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.yingzhiDikang]];
    }
    if (self.equipInfo2show.chengmoDikang > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForChengmoDikang]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.chengmoDikang]];
    }
    if (self.equipInfo2show.minusNengliangXiaohao > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForMinusNengliangXiaohao]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.minusNengliangXiaohao]];
    }
    if (self.equipInfo2show.skillLevelAddon > 0) {
        [self.attr2showIdArr addObject:[MyUtility attrIdForSkillLevelAddon]];
        [self.value2showArr addObject:[NSNumber numberWithInteger:self.equipInfo2show.skillLevelAddon]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self updateAttrId2show];
    
    return self.attr2showIdArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EquipComposeAttrItemTableViewCell *attrItemCell=[tableView dequeueReusableCellWithIdentifier:kEquipComposeAttrItemTBCellId];
    
    NSString *attrId=self.attr2showIdArr[indexPath.row];
    
    if (0 == indexPath.row) {
        attrItemCell.lblAttrDesc.text=[NSString stringWithFormat:@"%@",attrId];
    } else {
        EquipAttrDesc *attrDesc=[MyUtility getEquipAttrDescForAttrId:attrId];
        BOOL withPercentSufix=false;
        if ([attrId isEqualToString:[MyUtility attrIdForZhiliaoXiaoguo]] ||
            [attrId isEqualToString:[MyUtility attrIdForMinusControlTime]] ||
            [attrId isEqualToString:[MyUtility attrIdForYingzhiDikang]] ||
            [attrId isEqualToString:[MyUtility attrIdForChengmoDikang]] ||
            [attrId isEqualToString:[MyUtility attrIdForMinusNengliangXiaohao]]) {
            withPercentSufix=true;
        }
        attrItemCell.lblAttrDesc.text=[NSString stringWithFormat:@"%@ + %d%@",attrDesc.attrDesc,[self.value2showArr[indexPath.row] intValue],withPercentSufix?@"\%":@""];
    }
    
    return attrItemCell;
}

@end
