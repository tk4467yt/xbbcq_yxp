//
//  HeroSkill.h
//  xbb
//
//  Created by  qin on 2017/3/4.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroSkill : NSObject
@property (nonatomic,copy) NSString *heroId;
@property (nonatomic,copy) NSString *skillId;
@property (nonatomic,copy) NSString *skillName;
@property (nonatomic,copy) NSString *skillDesc;
@property (nonatomic,copy) NSString *skillThumb;
@end
