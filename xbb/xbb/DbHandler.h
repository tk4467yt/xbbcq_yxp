//
//  DbHandler.h
//  xbb
//
//  Created by  qin on 2017/3/2.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EquipInfo.h"
#import "HeroInfo.h"
#import "EquipComposeInfo.h"
#import "RankDesc.h"

@interface DbHandler : NSObject

+(void)initLocalDatabase;
+(void)closeLocalDatabase;

+(NSArray *)getAllHeros;
+(HeroInfo *)getHeroInfoWithHeroId:(NSString *)heroId;

+(NSDictionary *)getAllHeroTypeDescDict;
+(NSArray *)getAllStarDesc;
+(NSDictionary *)getAllSpeciesDescDict;

+(NSDictionary *)getAllRankDescDict;
+(RankDesc *)getRankDescForRankId:(NSString *)rankId;

+(NSDictionary *)getAllPosDescDict;

+(NSArray *)getAllHeroSpecies;
+(NSArray *)getHeroSpeciesForHero:(NSString *)heroId;

+(NSArray *)getAllHeroSkills;
+(NSArray *)getHeroSkillsForHero:(NSString *)heroId;

+(NSArray *)getAllHeroGrow;
+(NSArray *)getHeroGrowForHero:(NSString *)heroId;

+(NSArray *)getAllHeroEquips;
+(NSDictionary *)getHeroEquipsDictForHero:(NSString *)heroId;

+(NSDictionary *)getAllFragmentFromDescDict;

+(NSArray *)getAllEquipInfo;
+(EquipInfo *)getEquipInfoForEquipId:(NSString *)equipId;

+(NSDictionary *)getAllEquipComposeInfo;
+(EquipComposeInfo *)getEquipComposeInfoForEquipId:(NSString *)equipId;

+(NSArray *)getAllEquipAttrDescArr;
@end
