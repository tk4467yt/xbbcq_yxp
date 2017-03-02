//
//  HeroInfo.h
//  xbb
//
//  Created by  qin on 2017/3/2.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroInfo : NSObject
@property (nonatomic,copy) NSString *heroId;
@property (nonatomic,copy) NSString *heroName;
@property (nonatomic,copy) NSString *heroType;
@property (nonatomic,copy) NSString *heroPos;
@property (nonatomic,copy) NSString *heroFragmentFrom;
@property (nonatomic,copy) NSString *heroDesc;

@property (nonatomic,assign) NSInteger initStar;

@property (nonatomic,assign) NSInteger tuijianLevel;
@property (nonatomic,assign) NSInteger rushouNanduLevel;
@property (nonatomic,assign) NSInteger starUpLevel;
@property (nonatomic,assign) NSInteger shuchuLevel;
@property (nonatomic,assign) NSInteger tuanduiFuzhuLevel;

@property (nonatomic,copy) NSString *thumbFile;
@property (nonatomic,copy) NSString *thumbFileS;
@property (nonatomic,copy) NSString *artFile;
@property (nonatomic,copy) NSString *artFileS;
@property (nonatomic,copy) NSString *shortName;

@property (nonatomic,assign) NSInteger initLiliang;
@property (nonatomic,assign) NSInteger initZhili;
@property (nonatomic,assign) NSInteger initMinjie;
@property (nonatomic,assign) NSInteger initHealthMax;
@property (nonatomic,assign) NSInteger initPhysicsGongji;
@property (nonatomic,assign) NSInteger initMagicQiangdu;
@property (nonatomic,assign) NSInteger initPhysicsHujia;
@property (nonatomic,assign) NSInteger initMagicKangxing;
@property (nonatomic,assign) NSInteger initPhysicaBaoji;
@end
