//
//  SpeciesSetHerosTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeciesSetHerosTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblHeroDesc;
@property (weak, nonatomic) IBOutlet UICollectionView *cvHeros;

@property (strong, nonatomic) NSArray *herosArr;
@end
