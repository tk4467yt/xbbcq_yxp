//
//  MyUtility.m
//  xbb
//
//  Created by  qin on 2017/3/3.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyUtility.h"

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
    return [img2use resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

+(BOOL)isStringNilOrZeroLength:(NSString *)str2check
{
    return nil == str2check || [str2check isKindOfClass:[NSNull class]] || str2check.length == 0;
}
@end
