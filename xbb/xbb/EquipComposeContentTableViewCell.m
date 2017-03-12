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
#import "RankDesc.h"
#import "DbHandler.h"
#import "MyUtility.h"

@interface EquipComposeContentTableViewCell ()
@property (nonatomic,strong) NSDictionary *rankDescDict;
@end

@implementation EquipComposeContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankDescDict=[DbHandler getAllRankDescDict];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImage *)getEquipMaskForRank:(NSString *)rankId
{
    RankDesc *rankDesc2use=self.rankDescDict[rankId];
    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.equipFrameThumb];
    maskImg=[MyUtility makeMaskImageFroFrame:maskImg];
    
    return maskImg;
}

-(UIImage *)getEquipFragmentMaskForRank:(NSString *)rankId
{
    RankDesc *rankDesc2use=self.rankDescDict[rankId];
    UIImage *maskImg=[UIImage imageNamed:rankDesc2use.fragmentFrameThumb];
    maskImg=[MyUtility makeMaskImageFroFrame:maskImg];
    
    return maskImg;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lblTitle.text=NSLocalizedString(@"equip_compose_title", @"");
    self.lblComposeNone.text=NSLocalizedString(@"desc_for_none", @"");
    
    EquipInfo *equipInfo=[MyUtility getEquipInfoForEquipId:self.equipId2show];
    if (equipInfo.isCompose) {
        self.lblComposeNone.hidden=true;
        
        EquipComposeInfo *composeInfo=[DbHandler getEquipComposeInfoForEquipId:self.equipId2show];
        if (composeInfo.fragmentCount > 0) {
            self.composeFromEquipHolder.hidden=true;
            self.composeFromFragmentHolder.hidden=false;
            
            self.ivFragment.image=[UIImage imageNamed:equipInfo.thumbFile];
            self.ivFragmentMask.image=[self getEquipFragmentMaskForRank:equipInfo.equipRank];
            self.ivEquip.image=[UIImage imageNamed:equipInfo.thumbFile];
            self.ivEquipMask.image=[self getEquipMaskForRank:equipInfo.equipRank];
            self.lblCount.text=[NSString stringWithFormat:@"*%d",(int)composeInfo.fragmentCount];
            
            [MyUtility applyMaskImageToImageView:self.ivFragment withImage:[UIImage imageNamed:@"fragment_stencil"]];
            [MyUtility applyMaskImageToImageView:self.ivEquip withImage:[UIImage imageNamed:@"equip_stencil"]];
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
