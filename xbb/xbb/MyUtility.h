//
//  MyUtility.h
//  xbb
//
//  Created by  qin on 2017/3/3.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EquipInfo.h"
#import "RankDesc.h"
#import "EquipAttrDesc.h"
#import "MyAppSizeInfo.h"
#import "MyAppCellIdInfo.h"
#import "EquipComposeInfo.h"
#import "HeroSpecies.h"
#import "DbHandler.h"
#import "HeroInfo.h"
#import "HeroEquips.h"
#import "MyConstants.h"

#define kHeroStarImage @"detail_star"
#define kHeroStarImageGrey @"detail_star_grey"

@interface MyUtility : NSObject
+(NSString *)heroTypeLiliangId;
+(NSString *)heroTypeZhiliId;
+(NSString *)heroTypeMinjieId;

+(NSString *)rankIdForBai;
+(NSString *)rankIdForLv;
+(NSString *)rankIdForLv1;
+(NSString *)rankIdForLan;
+(NSString *)rankIdForLan1;
+(NSString *)rankIdForLan2;
+(NSString *)rankIdForZi;
+(NSString *)rankIdForZi1;
+(NSString *)rankIdForZi2;
+(NSString *)rankIdForZi3;
+(NSString *)rankIdForZi4;
+(NSString *)rankIdForCheng;
+(NSString *)rankIdForCheng1;
+(NSString *)rankIdForCheng2;
+(NSString *)rankIdForHong;
+(NSString *)rankIdForHong1;

+(UIColor *)rankColorForRankId:(NSString *)rankId;

+(NSString *)attrIdForLiliang;
+(NSString *)attrIdForMinjie;
+(NSString *)attrIdForZhili;
+(NSString *)attrIdForHealthMax;
+(NSString *)attrIdForHealthRecover;
+(NSString *)attrIdForEnergyRecover;
+(NSString *)attrIdForPhysicsGongji;
+(NSString *)attrIdForPhysicsHujia;
+(NSString *)attrIdForPhysicsBaoji;
+(NSString *)attrIdForChuantouPhysicsHujia;
+(NSString *)attrIdForMagicQiangdu;
+(NSString *)attrIdForMagicBaoji;
+(NSString *)attrIdForMagicKangxing;
+(NSString *)attrIdForHulueMagicKangxing;
+(NSString *)attrIdForXixue;
+(NSString *)attrIdForZhiliaoXiaoguo;
+(NSString *)attrIdForShangbi;
+(NSString *)attrIdForMingzhong;
+(NSString *)attrIdForMinusControlTime;
+(NSString *)attrIdForYingzhiDikang;
+(NSString *)attrIdForChengmoDikang;
+(NSString *)attrIdForMinusNengliangXiaohao;
+(NSString *)attrIdForSkillLevelAddon;
+(NSString *)attrIdForSiWangDuiFangHuiNengJianBan;

+(UIImage *)makeMaskImageFroFrame:(UIImage *)img2use;

+(BOOL)isStringNilOrZeroLength:(NSString *)str2check;
+(void)pushViewControllerFromNav:(UINavigationController *)navVC withTargetVC:(UIViewController *)targetVC animated:(BOOL)anim;

+(UIView *)getTopViewForNib:(UINib *)nib2use;
+(CGFloat)screenWidth;
+(CGFloat)screenHeight;
+(CGFloat)heightOfStatusBar;

+(NSArray *)getCachedAllHeros;
+(HeroInfo *)getCachedHeroInfoWithHeroId:(NSString *)heroId;

+(NSArray *)getAllEquipInfoFromDbCache;
+(EquipInfo *)getEquipInfoForEquipIdCache:(NSString *)equipId;

+(NSDictionary *)getAllRankDescDictCache;
+(RankDesc *)getRankDescForRankIdCache:(NSString *)rankId;

+(NSArray *)getCachedAllHeroEquips;
+(NSDictionary *)getCachedHeroEquipsDictForHero:(NSString *)heroId;

+(NSArray *)getAllEquipAttrDescArrCache;
+(EquipAttrDesc *)getEquipAttrDescForAttrIdCache:(NSString *)attrId;

+(NSArray *)getAllHeroSpeciesArrCache;
+(NSArray * )getHeroSpeciesCacheForHero:(NSString *)heroId;

+(NSDictionary *)getAllEquipComposeInfoDictCache;
+(EquipComposeInfo *)getEquipComposeInfoCacheForEquipId:(NSString *)equipId;

+(void)applyMaskImageToImageView:(UIImageView *)iv2mask withImage:(UIImage *)img2mask;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
+ (BOOL)shouldSwitchEquipsForRankId:(NSString *)rankId;
@end
