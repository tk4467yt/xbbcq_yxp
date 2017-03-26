//
//  AllEquipsRequrieViewController.h
//  xbb
//
//  Created by  qin on 2017/3/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "MyRootViewController.h"

@interface AllEquipsRequrieViewController : MyRootViewController
@property (weak, nonatomic) IBOutlet UICollectionView *cvCountedEquips;

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aidLoading;

@end
