//
//  EquipComposeHerosTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipInfo.h"
#import "MyDelegateSet.h"

@interface EquipComposeHerosTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblNone;
@property (weak, nonatomic) IBOutlet UICollectionView *cvEquipableHeros;

@property (strong, nonatomic) NSArray *heroEquipsArr;
@property (nonatomic,strong) NSDictionary *rankDescDict;
@property (nonatomic,strong) NSDictionary *heroTypeDescDict;
@property (strong,nonatomic) EquipInfo *equipInfoShowing;

@property (nonatomic,weak) UIViewController<equipComposeVCActionDelegate> *composeActionDelegate;
@end
