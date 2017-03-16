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
    
    UITapGestureRecognizer *tapGesture0=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip0Tapped:)];
    [self.ivEquip0 addGestureRecognizer:tapGesture0];
    
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip1Tapped:)];
    [self.ivEquip1 addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip2Tapped:)];
    [self.ivEquip2 addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip3Tapped:)];
    [self.ivEquip3 addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip4Tapped:)];
    [self.ivEquip4 addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer *tapGesture5=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equip5Tapped:)];
    [self.ivEquip5 addGestureRecognizer:tapGesture5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)equip0Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 0 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:0];
    }
}

- (void)equip1Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 1 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:1];
    }
}

- (void)equip2Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 2 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:2];
    }
}

- (void)equip3Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 3 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:3];
    }
}

- (void)equip4Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 4 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:4];
    }
}

- (void)equip5Tapped:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"equip 5 tapped");
    
    if ([self.equipTapDelegate respondsToSelector:@selector(equipTappedWithRank:andItemIdx:)]) {
        [self.equipTapDelegate equipTappedWithRank:self.rankId andItemIdx:5];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblEquipDesc.text=NSLocalizedString(@"equip_title", @"");
}

@end
