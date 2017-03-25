//
//  EquipComposeableTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipInfo.h"

@protocol EquipComposeableActionDelegate <NSObject>

-(void)didSelectComposeableEquip:(EquipInfo *)equipSelected;

@end

@interface EquipComposeableTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblNone;
@property (weak, nonatomic) IBOutlet UICollectionView *cvComposeableEquips;

@property (nonatomic, strong) NSArray *composeableEquipsArr;
@property (nonatomic,strong) NSDictionary *rankDescDict;
@property (strong,nonatomic) EquipInfo *equipInfoShowing;

@property (nonatomic, weak) id<EquipComposeableActionDelegate> composeableActionDelegate;
@end
