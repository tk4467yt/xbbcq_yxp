//
//  HeroDetailEquipsTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/8.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailEquipsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblEquipDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblRankDesc;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip0;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip1;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip2;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip3;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip4;
@property (weak, nonatomic) IBOutlet UIImageView *ivEquip5;

@end
