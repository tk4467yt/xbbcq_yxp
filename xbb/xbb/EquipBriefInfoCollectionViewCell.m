//
//  EquipBriefInfoCollectionViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/5.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipBriefInfoCollectionViewCell.h"
#import "MyUtility.h"

@implementation EquipBriefInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ivThumb.layer.masksToBounds=true;
    self.ivThumb.layer.cornerRadius=5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [MyUtility applyMaskImageToImageView:self.ivThumb withImage:[UIImage imageNamed:@"equip_stencil"]];//call is slow,so use cornerRadius
}

- (void)updateConstraints
{
    for (NSLayoutConstraint *aConstraint in self.lblName.constraints) {
        if ([aConstraint.identifier isEqualToString:@"lbl_name_height"]) {
            if (self.noNameShown) {
                aConstraint.constant=0;
            } else {
                aConstraint.constant=20;
            }
        }
    }
    [super updateConstraints];
}

@end
