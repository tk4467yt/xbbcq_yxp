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
static __strong NSDictionary *allEquipComposeInfoDict;

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

+(UIColor *)rankColorForRankId:(NSString *)rankId
{
    UIColor *color2ret=[UIColor whiteColor];
    if ([rankId isEqualToString:[MyUtility rankIdForBai]]) {
        color2ret=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:243/255.0 alpha:1];
    } else if ([rankId isEqualToString:[MyUtility rankIdForLv]] ||
               [rankId isEqualToString:[MyUtility rankIdForLv1]]) {
        color2ret=[UIColor colorWithRed:216/255.0 green:245/255.0 blue:96/255.0 alpha:1];
    } else if ([rankId isEqualToString:[MyUtility rankIdForLan]] ||
               [rankId isEqualToString:[MyUtility rankIdForLan1]] ||
               [rankId isEqualToString:[MyUtility rankIdForLan2]]) {
        color2ret=[UIColor blueColor];
    } else if ([rankId isEqualToString:[MyUtility rankIdForZi]] ||
               [rankId isEqualToString:[MyUtility rankIdForZi1]] ||
               [rankId isEqualToString:[MyUtility rankIdForZi2]] ||
               [rankId isEqualToString:[MyUtility rankIdForZi3]] ||
               [rankId isEqualToString:[MyUtility rankIdForZi4]]) {
        color2ret=[UIColor purpleColor];
    } else if ([rankId isEqualToString:[MyUtility rankIdForCheng]] ||
               [rankId isEqualToString:[MyUtility rankIdForCheng1]] ||
               [rankId isEqualToString:[MyUtility rankIdForCheng2]]) {
        color2ret=[UIColor orangeColor];
    } else if ([rankId isEqualToString:[MyUtility rankIdForHong]] ||
               [rankId isEqualToString:[MyUtility rankIdForHong1]]) {
        color2ret=[UIColor colorWithRed:246/255.0 green:88/255.0 blue:90/255.0 alpha:1];
    }
    
    return color2ret;
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
+(CGFloat)heightOfStatusBar
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    return rectStatus.size.height;
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
    
    if (![MyUtility isStringNilOrZeroLength:equipId]) {
        for (EquipInfo *aEquipInfo in allEquipsInfoArr) {
            if ([aEquipInfo.equipId isEqualToString:equipId]) {
                return aEquipInfo;
            }
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
    
    if (![MyUtility isStringNilOrZeroLength:rankId]) {
        for (RankDesc *aRankDesc in rankDescDict.allValues) {
            if ([aRankDesc.rankId isEqualToString:rankId]) {
                return aRankDesc;
            }
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
    
    if (![MyUtility isStringNilOrZeroLength:attrId]) {
        for (EquipAttrDesc *aAttrDesc in allEquipAttrDescArr) {
            if ([aAttrDesc.attrId isEqualToString:attrId]) {
                return aAttrDesc;
            }
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

+(NSArray * )getHeroSpeciesCacheForHero:(NSString *)heroId
{
    if (nil == allHeroSpeciesArr) {
        allHeroSpeciesArr = [DbHandler getAllHeroSpecies];
    }
    
    NSMutableArray *apecies2ret=[NSMutableArray new];
    
    if (![MyUtility isStringNilOrZeroLength:heroId]) {
        for (HeroSpecies *aSpecies in allHeroSpeciesArr) {
            if ([aSpecies.heroId isEqualToString:heroId]) {
                [apecies2ret addObject:aSpecies];
            }
        }
    }
    
    return apecies2ret;
}

+(NSDictionary *)getAllEquipComposeInfoDictCache
{
    if (nil == allEquipComposeInfoDict) {
        allEquipComposeInfoDict = [DbHandler getAllEquipComposeInfo];
    }
    
    return allEquipComposeInfoDict;
}
+(EquipComposeInfo *)getEquipComposeInfoCacheForEquipId:(NSString *)equipId
{
    if (nil == allEquipComposeInfoDict) {
        allEquipComposeInfoDict = [DbHandler getAllEquipComposeInfo];
    }
    
    EquipComposeInfo *composeInfo=nil;
    if (![MyUtility isStringNilOrZeroLength:equipId]) {
        composeInfo=allEquipComposeInfoDict[equipId];
    }
    return composeInfo;
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

+ (BOOL)shouldSwitchEquipsForRankId:(NSString *)rankId
{
    if ([rankId isEqualToString:[MyUtility rankIdForCheng]] ||
        [rankId isEqualToString:[MyUtility rankIdForCheng1]] ||
        [rankId isEqualToString:[MyUtility rankIdForCheng2]] ||
        [rankId isEqualToString:[MyUtility rankIdForHong]] ||
        [rankId isEqualToString:[MyUtility rankIdForHong1]]) {
        return true;
    }
    
    return false;
}
@end
