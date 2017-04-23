//
//  TuanbenTeamTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/4/22.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuanbenTeam.h"

@interface TuanbenTeamTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblTeamTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *cvTuanbenTeam;

@property (nonatomic,strong) TuanbenTeam *tuanbenTeam;
@property (nonatomic,assign) NSInteger teamIdx;
@end
