//
//  MyAppSizeInfo.m
//  xbb
//
//  Created by  qin on 2017/3/23.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyAppSizeInfo.h"

@implementation MyAppSizeInfo

+(CGSize)heroSpeciesItemSize
{
    return CGSizeMake(50,60);
}

+(CGSize)equipBriefCVItemSize
{
    return CGSizeMake(80,100);
}
+(CGSize)equipBriefCVItemSmallSize
{
    return CGSizeMake(60, 60);
}
+(CGFloat)cacTableCellHeightForCVWithMaxWidth:(CGFloat)maxCVWidth andItemSize:(CGSize)itemSize andItemCount:(NSInteger)itemCount andLineOffset:(CGFloat)lineOffset
{
    NSInteger maxItemOneLine=maxCVWidth/itemSize.width;
    NSInteger itemShown=maxItemOneLine;
    CGFloat height=itemSize.height;
    while (itemShown < itemCount) {
        itemShown += maxItemOneLine;
        height += itemSize.height;
        height += lineOffset;
    }
    return height;
}
@end
