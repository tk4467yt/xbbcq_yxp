//
//  MyDelegateSet.h
//  xbb
//
//  Created by  qin on 2017/3/26.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol equipComposeVCActionDelegate <NSObject>

- (void)didSelectEquipableHero:(NSString *)heroId;

@end

@interface MyDelegateSet : NSObject

@end
