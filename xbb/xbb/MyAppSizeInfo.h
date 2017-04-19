//
//  MyAppSizeInfo.h
//  xbb
//
//  Created by  qin on 2017/3/23.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyAppSizeInfo : NSObject
+(CGSize)heroSpeciesItemSize;
+(CGSize)equipBriefCVItemSize;
+(CGFloat)cacTableCellHeightForCVWithMaxWidth:(CGFloat)maxCVWidth andItemSize:(CGSize)itemSize andItemCount:(NSInteger)itemCount andLineOffset:(CGFloat)lineOffset;
+(CGSize)heroBriefCVItemSize;
@end
