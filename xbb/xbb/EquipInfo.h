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

@property (nonatomic,assign) BOOL showInBook;

@property (nonatomic,assign) double liliang;
@property (nonatomic,assign) double minjie;
@property (nonatomic,assign) double zhili;
@property (nonatomic,assign) double healthMax;
@property (nonatomic,assign) double healthRecover;
@property (nonatomic,assign) double energyRecover;
@property (nonatomic,assign) double physicsGongji;
@property (nonatomic,assign) double physicsHujia;
@property (nonatomic,assign) double physicsBaoji;
@property (nonatomic,assign) double chuantouPhysicsHujia;
@property (nonatomic,assign) double magicQiangdu;
@property (nonatomic,assign) double magicBaoji;
@property (nonatomic,assign) double magicKangxing;
@property (nonatomic,assign) double hulueMagicKangxing;
@property (nonatomic,assign) double xixue;
@property (nonatomic,assign) double zhiliaoXiaoguo;
@property (nonatomic,assign) double shangbi;
@property (nonatomic,assign) double mingzhong;
@property (nonatomic,assign) double minusControlTime;
@property (nonatomic,assign) double yingzhiDikang;
@property (nonatomic,assign) double chengmoDikang;
@property (nonatomic,assign) double minusNengliangXiaohao;
@property (nonatomic,assign) double skillLevelAddon;
@end
