//
//  SpeciesSetViewController.h
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyRootViewController.h"
#import "SpeciesDesc.h"

@protocol SpeciesSetDidSelectHeroDelegate <NSObject>

- (void)speciesSetDidSelectHeroWithId:(NSString *)heroId;

@end

@interface SpeciesSetViewController : MyRootViewController
@property (weak, nonatomic) IBOutlet UITableView *tbSpeciesSet;
@property (nonatomic,strong) SpeciesDesc *speciesDesc2show;

@property (nonatomic,weak) id<SpeciesSetDidSelectHeroDelegate> selectHeroDelegate;
@end
