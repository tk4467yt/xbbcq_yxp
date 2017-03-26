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
    
    self.rankDescDict=[MyUtility getAllRankDescDictCache];
    
    UITapGestureRecognizer *tapGesture02=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip0Tapped:)];
    [self.ivEquipCompose0MaskFrom2 addGestureRecognizer:tapGesture02];
    
    UITapGestureRecognizer *tapGesture03=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip0Tapped:)];
    [self.ivEquipCompose0MaskFrom3 addGestureRecognizer:tapGesture03];
    
    UITapGestureRecognizer *tapGesture04=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip0Tapped:)];
    [self.ivEquipCompose0MaskFrom4 addGestureRecognizer:tapGesture04];
    
    UITapGestureRecognizer *tapGesture12=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip1Tapped:)];
    [self.ivEquipCompose1MaskFrom2 addGestureRecognizer:tapGesture12];
    
    UITapGestureRecognizer *tapGesture13=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip1Tapped:)];
    [self.ivEquipCompose1MaskFrom3 addGestureRecognizer:tapGesture13];
    
    UITapGestureRecognizer *tapGesture14=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip1Tapped:)];
    [self.ivEquipCompose1MaskFrom4 addGestureRecognizer:tapGesture14];
    
    UITapGestureRecognizer *tapGesture23=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip2Tapped:)];
    [self.ivEquipCompose2MaskFrom3 addGestureRecognizer:tapGesture23];
    
    UITapGestureRecognizer *tapGesture24=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip2Tapped:)];
    [self.ivEquipCompose2MaskFrom4 addGestureRecognizer:tapGesture24];
    
    UITapGestureRecognizer *tapGesture34=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(composeEquip3Tapped:)];
    [self.ivEquipCompose3MaskFrom4 addGestureRecognizer:tapGesture34];
}

- (void)composeEquip0Tapped:(UITapGestureRecognizer *)tapGesture
{
//    NSLog(@"equip 0 tapped");
    
    if ([self.itemActionDelegate respondsToSelector:@selector(equipComposeItemTappedWithEquipId:)]) {
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equipId2show];
        [self.itemActionDelegate equipComposeItemTappedWithEquipId:composeInfo.composeFrom1];
    }
}

- (void)composeEquip1Tapped:(UITapGestureRecognizer *)tapGesture
{
//    NSLog(@"equip 1 tapped");
    
    if ([self.itemActionDelegate respondsToSelector:@selector(equipComposeItemTappedWithEquipId:)]) {
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equipId2show];
        [self.itemActionDelegate equipComposeItemTappedWithEquipId:composeInfo.composeFrom2];
    }
}

- (void)composeEquip2Tapped:(UITapGestureRecognizer *)tapGesture
{
//    NSLog(@"equip 2 tapped");
    
    if ([self.itemActionDelegate respondsToSelector:@selector(equipComposeItemTappedWithEquipId:)]) {
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equipId2show];
        [self.itemActionDelegate equipComposeItemTappedWithEquipId:composeInfo.composeFrom3];
    }
}

- (void)composeEquip3Tapped:(UITapGestureRecognizer *)tapGesture
{
//    NSLog(@"equip 3 tapped");
    
    if ([self.itemActionDelegate respondsToSelector:@selector(equipComposeItemTappedWithEquipId:)]) {
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equipId2show];
        [self.itemActionDelegate equipComposeItemTappedWithEquipId:composeInfo.composeFrom4];
    }
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
    
    EquipInfo *equipInfo=[MyUtility getEquipInfoForEquipIdCache:self.equipId2show];
    
    self.lblTitle.text=[NSString stringWithFormat:NSLocalizedString(@"equip_compose_title", @""),equipInfo.equipName];
    self.lblComposeNone.text=NSLocalizedString(@"desc_for_none", @"");
    
    if (equipInfo.isCompose) {
        self.lblComposeNone.hidden=true;
        
        EquipComposeInfo *composeInfo=[MyUtility getEquipComposeInfoCacheForEquipId:self.equipId2show];
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
                
                self.ivEquipFrom2.image=[UIImage imageNamed:equipInfo.thumbFile];
                self.ivEquipMaskFrom2.image=[self getEquipMaskForRank:equipInfo.equipRank];
                
                EquipInfo *composeFrom1Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom1];
                self.ivEquipCompose0From2.image=[UIImage imageNamed:composeFrom1Equip.thumbFile];
                self.ivEquipCompose0MaskFrom2.image=[self getEquipMaskForRank:composeFrom1Equip.equipRank];
                
                EquipInfo *composeFrom2Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom2];
                self.ivEquipCompose1From2.image=[UIImage imageNamed:composeFrom2Equip.thumbFile];
                self.ivEquipCompose1MaskFrom2.image=[self getEquipMaskForRank:composeFrom2Equip.equipRank];
            } else if (3 == composeIdArr.count) {
                self.composeFrom2Holder.hidden=true;
                self.composeFrom3Holder.hidden=false;
                self.composeFrom4Holder.hidden=true;
                
                self.ivEquipFrom3.image=[UIImage imageNamed:equipInfo.thumbFile];
                self.ivEquipMaskFrom3.image=[self getEquipMaskForRank:equipInfo.equipRank];
                
                EquipInfo *composeFrom1Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom1];
                self.ivEquipCompose0From3.image=[UIImage imageNamed:composeFrom1Equip.thumbFile];
                self.ivEquipCompose0MaskFrom3.image=[self getEquipMaskForRank:composeFrom1Equip.equipRank];
                
                EquipInfo *composeFrom2Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom2];
                self.ivEquipCompose1From3.image=[UIImage imageNamed:composeFrom2Equip.thumbFile];
                self.ivEquipCompose1MaskFrom3.image=[self getEquipMaskForRank:composeFrom2Equip.equipRank];
                
                EquipInfo *composeFrom3Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom3];
                self.ivEquipCompose2From3.image=[UIImage imageNamed:composeFrom3Equip.thumbFile];
                self.ivEquipCompose2MaskFrom3.image=[self getEquipMaskForRank:composeFrom3Equip.equipRank];
            } else if (4 == composeIdArr.count) {
                self.composeFrom2Holder.hidden=true;
                self.composeFrom3Holder.hidden=true;
                self.composeFrom4Holder.hidden=false;
                
                self.ivEquipFrom4.image=[UIImage imageNamed:equipInfo.thumbFile];
                self.ivEquipMaskFrom4.image=[self getEquipMaskForRank:equipInfo.equipRank];
                
                EquipInfo *composeFrom1Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom1];
                self.ivEquipCompose0From4.image=[UIImage imageNamed:composeFrom1Equip.thumbFile];
                self.ivEquipCompose0MaskFrom4.image=[self getEquipMaskForRank:composeFrom1Equip.equipRank];
                
                EquipInfo *composeFrom2Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom2];
                self.ivEquipCompose1From4.image=[UIImage imageNamed:composeFrom2Equip.thumbFile];
                self.ivEquipCompose1MaskFrom4.image=[self getEquipMaskForRank:composeFrom2Equip.equipRank];
                
                EquipInfo *composeFrom3Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom3];
                self.ivEquipCompose2From4.image=[UIImage imageNamed:composeFrom3Equip.thumbFile];
                self.ivEquipCompose2MaskFrom4.image=[self getEquipMaskForRank:composeFrom3Equip.equipRank];
                
                EquipInfo *composeFrom4Equip=[MyUtility getEquipInfoForEquipIdCache:composeInfo.composeFrom4];
                self.ivEquipCompose3From4.image=[UIImage imageNamed:composeFrom4Equip.thumbFile];
                self.ivEquipCompose3MaskFrom4.image=[self getEquipMaskForRank:composeFrom4Equip.equipRank];
            } else {
                self.composeFrom2Holder.hidden=true;
                self.composeFrom3Holder.hidden=true;
                self.composeFrom4Holder.hidden=true;
            }
        }
    } else {
        self.composeFromEquipHolder.hidden=true;
        self.composeFromFragmentHolder.hidden=true;
        self.lblComposeNone.hidden=false;
    }
}

@end
