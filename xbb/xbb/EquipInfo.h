//
//  EquipInfo.h
//  xbb
//
//  Created by  qin on 2017/3/4.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipInfo : NSObject
@property (nonatomic,copy) NSString *equipId;
@property (nonatomic,copy) NSString *equipName;

@property (nonatomic,assign) NSInteger levelRequire;
@property (nonatomic,assign) BOOL isCompose;

@property (nonatomic,copy) NSString *equipRank;
@property (nonatomic,copy) NSString *thumbFile;

@property (nonatomic,assign) NSInteger liliang;
@property (nonatomic,assign) NSInteger minjie;
@property (nonatomic,assign) NSInteger zhili;
@property (nonatomic,assign) NSInteger healthMax;
@property (nonatomic,assign) NSInteger healthRecover;
@property (nonatomic,assign) NSInteger energyRecover;
@property (nonatomic,assign) NSInteger physicsGongji;
@property (nonatomic,assign) NSInteger physicsHujia;
@property (nonatomic,assign) NSInteger physicsBaoji;
@property (nonatomic,assign) NSInteger chuantouPhysicsHujia;
@property (nonatomic,assign) NSInteger magicQiangdu;
@property (nonatomic,assign) NSInteger magicBaoji;
@property (nonatomic,assign) NSInteger magicKangxing;
@property (nonatomic,assign) NSInteger hulueMagicKangxing;
@property (nonatomic,assign) NSInteger xixue;
@property (nonatomic,assign) NSInteger zhiliaoXiaoguo;
@property (nonatomic,assign) NSInteger shangbi;
@property (nonatomic,assign) NSInteger mingzhong;
@property (nonatomic,assign) NSInteger minusControlTime;
@property (nonatomic,assign) NSInteger yingzhiDikang;
@property (nonatomic,assign) NSInteger chengmoDikang;
@property (nonatomic,assign) NSInteger minusNengliangXiaohao;
@property (nonatomic,assign) NSInteger skillLevelAddon;
@end
