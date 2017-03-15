//
//  HeroDetailEquipsTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/8.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroDetailEquipsTableViewCell.h"

@implementation HeroDetailEquipsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblEquipDesc.text=NSLocalizedString(@"equip_title", @"");
}

@end
