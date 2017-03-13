//
//  EquipComposeAttrTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/12.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipInfo.h"

@interface EquipComposeAttrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *tbAttrs;

@property (strong,nonatomic) EquipInfo *equipInfo2show;
@end
