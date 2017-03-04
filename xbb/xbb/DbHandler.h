//
//  DbHandler.h
//  xbb
//
//  Created by  qin on 2017/3/2.
//  Copyright © 2017年  qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DbHandler : NSObject

+(void)initLocalDatabase;
+(void)closeLocalDatabase;

+(NSArray *)getAllHeros;
+(NSDictionary *)getAllHeroTypeDescDict;
+(NSArray *)getAllStarDesc;
+(NSDictionary *)getAllSpeciesDescDict;
+(NSDictionary *)getAllRankDescDict;
+(NSDictionary *)getAllPosDescDict;
+(NSArray *)getAllHeroSpecies;
+(NSArray *)getAllHeroSkills;
+(NSArray *)getAllHeroGrow;
+(NSArray *)getAllHeroEquips;
+(NSDictionary *)getAllFragmentFromDescDict;
@end
