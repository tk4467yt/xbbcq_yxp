//
//  SecondViewController.h
//  xbb
//
//  Created by  qin on 2017/2/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRootViewController.h"
#import "MyDelegateSet.h"

@interface SecondViewController : MyRootViewController <UICollectionViewDelegate,UICollectionViewDataSource,equipComposeVCActionDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cvEquips;

@end

