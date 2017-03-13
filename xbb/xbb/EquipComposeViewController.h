//
//  EquipComposeViewController.h
//  xbb
//
//  Created by  qin on 2017/3/9.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipInfo.h"
#import "MyRootViewController.h"

@interface EquipComposeViewController : MyRootViewController
@property (nonatomic,strong) EquipInfo *equipInfo;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@end
