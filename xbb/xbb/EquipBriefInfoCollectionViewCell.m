//
//  EquipBriefInfoCollectionViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/5.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipBriefInfoCollectionViewCell.h"

@implementation EquipBriefInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ivThumb.layer.masksToBounds=true;
    self.ivThumb.layer.cornerRadius=10;
}

@end
