//
//  HeroDetailAllNonComposeEquipsTableViewCell.h
//  xbb
//
//  Created by  qin on 2017/3/25.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailAllNonComposeEquipsTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UICollectionView *cvNonComposeEquips;

@property (nonatomic, strong) NSArray *nonComposeEquipsArr;
@property (nonatomic,strong) NSDictionary *rankDescDict;
@property (nonatomic, strong) NSDictionary *equipCountDict;

@property (nonatomic,weak) UIViewController *parentVC;
@end
