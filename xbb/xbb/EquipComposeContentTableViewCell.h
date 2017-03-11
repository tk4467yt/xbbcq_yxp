//
//  EquipComposeContentTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/10.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipComposeContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIView *composeFromEquipHolder;

@property (weak, nonatomic) IBOutlet UIView *composeFrom2Holder;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipFrom2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipMaskFrom2;
@property (weak, nonatomic) IBOutlet UIImageView *ivComposeIndFrom2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0From2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0MaskFrom2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1From2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1MaskFrom2;

@property (weak, nonatomic) IBOutlet UIView *composeFrom3Holder;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipFrom3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipMaskFrom3;
@property (weak, nonatomic) IBOutlet UIImageView *ivComposeIndFrom3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0From3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0MaskFrom3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1From3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1MaskFrom3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose2From3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose2MaskFrom3;

@property (weak, nonatomic) IBOutlet UIView *composeFrom4Holder;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipMaskFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivComposeIndFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0From4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose0MaskFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1From4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose1MaskFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose2From4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose2MaskFrom4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose3From4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquipCompose3MaskFrom4;


@property (weak, nonatomic) IBOutlet UIView *composeFromFragmentHolder;
@property (weak, nonatomic) IBOutlet UIImageView *ivFragment;
@property (weak, nonatomic) IBOutlet UIImageView *ivFragmentMask;
@property (weak, nonatomic) IBOutlet UIImageView *ivArrow;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip;

@property (weak, nonatomic) IBOutlet UILabel *lblComposeNone;

@property (strong,nonatomic) NSString *equipId2show;
@end
