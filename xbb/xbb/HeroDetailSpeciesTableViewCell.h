//
//  HeroDetailSpeciesTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/6.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailSpeciesTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *heroSpeciesArr;
@property (weak, nonatomic) IBOutlet UILabel *lblSpeciesDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDescNone;
@property (weak, nonatomic) IBOutlet UICollectionView *cvSpecies;
@end
