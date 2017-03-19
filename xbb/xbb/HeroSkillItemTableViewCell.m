//
//  HeroSkillItemTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/8.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "HeroSkillItemTableViewCell.h"

@implementation HeroSkillItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ivSkillThumb.layer.masksToBounds=true;
    self.ivSkillThumb.layer.cornerRadius=5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
