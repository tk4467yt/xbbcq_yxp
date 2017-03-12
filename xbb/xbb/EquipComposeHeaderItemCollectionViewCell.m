//
//  EquipComposeHeaderItemCollectionViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/10.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeHeaderItemCollectionViewCell.h"
#import "MyUtility.h"

@implementation EquipComposeHeaderItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [MyUtility applyMaskImageToImageView:self.ivEquip withImage:[UIImage imageNamed:@"equip_stencil"]];
}

@end
