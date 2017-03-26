//
//  EquipComposeHeaderTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/10.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipComposeContentTableViewCell.h"

@interface EquipComposeHeaderTableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cvHeader;
@property (nonatomic,strong) NSArray *equipShowingArr;

@property (weak, nonatomic) id<EquipComposeItemActionDelegate> itemActionDelegate;

- (void)scroll2ViewLastHeaderItem;
@end
