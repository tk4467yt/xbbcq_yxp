//
//  MyUtility.m
//  xbb
//
//  Created by  qin on 2017/3/3.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyUtility.h"
#import "DbHandler.h"

static __strong NSArray *allEquipsInfoArr;
static __strong NSDictionary *rankDescDict;
static __strong NSArray *allEquipAttrDescArr;
static __strong NSArray *allHeroSpeciesArr;

@implementation MyUtility
+(NSString *)heroTypeLiliangId
{
    return @"li_liang";
}
+(NSString *)heroTypeZhiliId
{
    return @"zhi_li";
}
+(NSString *)heroTypeMinjieId
{
    return @"min_jie";
}

+(NSString *)rankIdForBai
{
    return @"rank_bai";
}
+(NSString *)rankIdForLv
{
    return @"rank_lv";
}
+(NSString *)rankIdForLv1
{
    return @"rank_lv_1";
}
+(NSString *)rankIdForLan
{
    return @"rank_lan";
}
+(NSString *)rankIdForLan1
{
    return @"rank_lan_1";
}
+(NSString *)rankIdForLan2
{
    return @"rank_lan_2";
}
+(NSString *)rankIdForZi
{
    return @"rank_zi";
}
+(NSString *)rankIdForZi1
{
    return @"rank_zi_1";
}
+(NSString *)rankIdForZi2
{
    return @"rank_zi_2";
}
+(NSString *)rankIdForZi3
{
    return @"rank_zi_3";
}
+(NSString *)rankIdForZi4
{
    return @"rank_zi_4";
}
+(NSString *)rankIdForCheng
{
    return @"rank_cheng";
}
+(NSString *)rankIdForCheng1
{
    return @"rank_cheng_1";
}
+(NSString *)rankIdForCheng2
{
    return @"rank_cheng_2";
}
+(NSString *)rankIdForHong
{
    return @"rank_hong";
}
+(NSString *)rankIdForHong1
{
    return @"rank_hong_1";
}

+(NSString *)attrIdForLiliang
{
    return @"li_liang";
}
+(NSString *)attrIdForMinjie
{
    return @"min_jie";
}
+(NSString *)attrIdForZhili
{
    return @"zhi_li";
}
+(NSString *)attrIdForHealthMax
{
    return @"health_max";
}
+(NSString *)attrIdForHealthRecover
{
    return @"health_recover";
}
+(NSString *)attrIdForEnergyRecover
{
    return @"energy_recover";
}
+(NSString *)attrIdForPhysicsGongji
{
    return @"physics_gongji";
}
+(NSString *)attrIdForPhysicsHujia
{
    return @"physics_hujia";
}
+(NSString *)attrIdForPhysicsBaoji
{
    return @"physics_baoji";
}
+(NSString *)attrIdForChuantouPhysicsHujia
{
    return @"chuantou_physics_hujia";
}
+(NSString *)attrIdForMagicQiangdu
{
    return @"magic_qiangdu";
}
+(NSString *)attrIdForMagicBaoji
{
    return @"magic_baoji";
}
+(NSString *)attrIdForMagicKangxing
{
    return @"magic_kangxing";
}
+(NSString *)attrIdForHulueMagicKangxing
{
    return @"hulue_magic_kangxing";
}
+(NSString *)attrIdForXixue
{
    return @"xixue";
}
+(NSString *)attrIdForZhiliaoXiaoguo
{
    return @"zhiliao_xiaoguo";
}
+(NSString *)attrIdForShangbi
{
    return @"shangbi";
}
+(NSString *)attrIdForMingzhong
{
    return @"mingzhong";
}
+(NSString *)attrIdForMinusControlTime
{
    return @"minus_control_time";
}
+(NSString *)attrIdForYingzhiDikang
{
    return @"yingzhi_dikang";
}
+(NSString *)attrIdForChengmoDikang
{
    return @"chengmo_dikang";
}
+(NSString *)attrIdForMinusNengliangXiaohao
{
    return @"minus_nengliang_xiaohao";
}
+(NSString *)attrIdForSkillLevelAddon
{
    return @"skill_level_addon";
}
+(NSString *)attrIdForSiWangDuiFangHuiNengJianBan
{
    return @"si_wang_dui_fang_hui_neng_jian_ban";
}

+(UIImage *)makeMaskImageFroFrame:(UIImage *)img2use
{
    return [img2use resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
}

+(BOOL)isStringNilOrZeroLength:(NSString *)str2check
{
    return nil == str2check || str2check == NULL || [str2check isKindOfClass:[NSNull class]] || str2check.length == 0;
}

+(void)pushViewControllerFromNav:(UINavigationController *)navVC withTargetVC:(UIViewController *)targetVC animated:(BOOL)anim
{
    targetVC.hidesBottomBarWhenPushed=true;
    [navVC pushViewController:targetVC animated:anim];
}

+(UIView *)getTopViewForNib:(UINib *)nib2use
{
    return nil;
}

+(CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(NSArray *)getAllEquipInfoFromDbCache
{
    if (nil == allEquipsInfoArr) {
        allEquipsInfoArr=[DbHandler getAllEquipInfo];
    }
    
    return allEquipsInfoArr;
}

+(EquipInfo *)getEquipInfoForEquipIdCache:(NSString *)equipId
{
    if (nil == allEquipsInfoArr) {
        allEquipsInfoArr=[DbHandler getAllEquipInfo];
    }
    
    for (EquipInfo *aEquipInfo in allEquipsInfoArr) {
        if ([aEquipInfo.equipId isEqualToString:equipId]) {
            return aEquipInfo;
        }
    }
    
    return nil;
}

+(NSDictionary *)getAllRankDescDictCache
{
    if (nil == rankDescDict) {
        rankDescDict=[DbHandler getAllRankDescDict];
    }
    
    return rankDescDict;
}

+(RankDesc *)getRankDescForRankIdCache:(NSString *)rankId
{
    if (nil == rankDescDict) {
        rankDescDict=[DbHandler getAllRankDescDict];
    }
    
    for (RankDesc *aRankDesc in rankDescDict.allValues) {
        if ([aRankDesc.rankId isEqualToString:rankId]) {
            return aRankDesc;
        }
    }
    
    return nil;
}

+(NSArray *)getAllEquipAttrDescArrCache
{
    if (nil == allEquipAttrDescArr) {
        allEquipAttrDescArr=[DbHandler getAllEquipAttrDescArr];
    }
    
    return allEquipAttrDescArr;
}
+(EquipAttrDesc *)getEquipAttrDescForAttrIdCache:(NSString *)attrId
{
    if (nil == allEquipAttrDescArr) {
        allEquipAttrDescArr=[DbHandler getAllEquipAttrDescArr];
    }
    
    for (EquipAttrDesc *aAttrDesc in allEquipAttrDescArr) {
        if ([aAttrDesc.attrId isEqualToString:attrId]) {
            return aAttrDesc;
        }
    }
    
    return nil;
}

+(NSArray *)getAllHeroSpeciesArrCache
{
    if (nil == allHeroSpeciesArr) {
        allHeroSpeciesArr = [DbHandler getAllHeroSpecies];
    }
    
    return allHeroSpeciesArr;
}

+(void)applyMaskImageToImageView:(UIImageView *)iv2mask withImage:(UIImage *)img2mask
{
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, iv2mask.frame.size.width, iv2mask.frame.size.height);
    maskLayer.contents = (id)[img2mask CGImage];
    [iv2mask.layer setMask:maskLayer];
    iv2mask.layer.masksToBounds=true;
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font
{
    static UILabel *label = nil;
    if (nil == label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    label.frame=CGRectMake(0, 0, width, 0);
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    CGFloat height = label.frame.size.height;
    return height;
}
@end
