//
//  MengjingTeamTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MengjingTeam.h"

@interface MengjingTeamTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblTeamTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *cvTeam;

@property (nonatomic,strong) MengjingTeam *teamInfo;
@end
