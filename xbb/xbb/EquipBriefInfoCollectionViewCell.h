//
//  EquipBriefInfoCollectionViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/5.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipBriefInfoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivThumb;
@property (weak, nonatomic) IBOutlet UIImageView *ivMask;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (nonatomic, assign) BOOL noNameShown;
@end
