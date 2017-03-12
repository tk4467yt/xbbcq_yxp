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

+(NSArray *)getAllEquipInfoFromDb
{
    if (nil == allEquipsInfoArr) {
        allEquipsInfoArr=[DbHandler getAllEquipInfo];
    }
    
    return allEquipsInfoArr;
}

+(EquipInfo *)getEquipInfoForEquipId:(NSString *)equipId
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

+(NSDictionary *)getAllRankDescDict
{
    if (nil == rankDescDict) {
        rankDescDict=[DbHandler getAllRankDescDict];
    }
    
    return rankDescDict;
}

+(RankDesc *)getRankDescForRankId:(NSString *)rankId
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

+(void)applyMaskImageToImageView:(UIImageView *)iv2mask withImage:(UIImage *)img2mask
{
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, iv2mask.frame.size.width, iv2mask.frame.size.height);
    maskLayer.contents = (id)[img2mask CGImage];
    [iv2mask.layer setMask:maskLayer];
    iv2mask.layer.masksToBounds=true;
}
@end
