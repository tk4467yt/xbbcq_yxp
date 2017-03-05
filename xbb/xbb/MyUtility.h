//
//  MyUtility.h
//  xbb
//
//  Created by  qin on 2017/3/3.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

+(UIImage *)makeMaskImageFroFrame:(UIImage *)img2use;

+(BOOL)isStringNilOrZeroLength:(NSString *)str2check;
@end
