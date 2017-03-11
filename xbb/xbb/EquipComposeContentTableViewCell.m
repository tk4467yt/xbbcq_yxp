//
//  EquipComposeContentTableViewCell.m
//  xbb
//
//  Created by  qin on 2017/3/10.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "EquipComposeContentTableViewCell.h"
#import "EquipInfo.h"
#import "EquipComposeInfo.h"
#import "DbHandler.h"
#import "MyUtility.h"

@implementation EquipComposeContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblTitle.text=NSLocalizedString(@"equip_compose_title", @"");
    self.lblComposeNone.text=NSLocalizedString(@"desc_for_none", @"");
    
    EquipInfo *equipInfo=[DbHandler getEquipInfoForEquipId:self.equipId2show];
    if (equipInfo.isCompose) {
        self.lblComposeNone.hidden=true;
        
        EquipComposeInfo *composeInfo=[DbHandler getEquipComposeInfoForEquipId:self.equipId2show];
        if (composeInfo.fragmentCount > 0) {
            self.composeFromEquipHolder.hidden=true;
            self.composeFromFragmentHolder.hidden=false;
        } else {
            self.composeFromEquipHolder.hidden=false;
            self.composeFromFragmentHolder.hidden=true;
            
            NSMutableArray *composeIdArr=[NSMutableArray new];
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom1]) {
                [composeIdArr addObject:composeInfo.composeFrom1];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom2]) {
                [composeIdArr addObject:composeInfo.composeFrom2];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom3]) {
                [composeIdArr addObject:composeInfo.composeFrom3];
            }
            if (![MyUtility isStringNilOrZeroLength:composeInfo.composeFrom4]) {
                [composeIdArr addObject:composeInfo.composeFrom4];
            }
            
            if (2 == composeIdArr.count) {
                self.composeFrom2Holder.hidden=false;
                self.composeFrom3Holder.hidden=true;
                self.composeFrom4Holder.hidden=true;
            } else if (3 == composeIdArr.count) {
                self.composeFrom2Holder.hidden=true;
                self.composeFrom3Holder.hidden=false;
                self.composeFrom4Holder.hidden=true;
            } else if (4 == composeIdArr.count) {
                self.composeFrom2Holder.hidden=true;
                self.composeFrom3Holder.hidden=true;
                self.composeFrom4Holder.hidden=false;
            }
        }
    } else {
        self.composeFromEquipHolder.hidden=true;
        self.composeFromFragmentHolder.hidden=true;
        self.lblComposeNone.hidden=false;
    }
}

@end
