//
//  SpeciesSetViewController.h
//  xbb
//
//  Created by  qin on 2017/3/18.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyRootViewController.h"
#import "SpeciesDesc.h"

@interface SpeciesSetViewController : MyRootViewController
@property (weak, nonatomic) IBOutlet UITableView *tbSpeciesSet;
@property (nonatomic,strong) SpeciesDesc *speciesDesc2show;
@end
