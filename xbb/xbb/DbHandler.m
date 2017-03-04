//
//  DbHandler.m
//  xbb
//
//  Created by  qin on 2017/3/2.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "DbHandler.h"
#import "FMDB.h"
#import "HeroInfo.h"
#import "HeroTypeDesc.h"

static __strong FMDatabase *dbConfig;

@implementation DbHandler

+(void)initLocalDatabase
{
    [self configDb];
}

+(void)closeLocalDatabase
{
    [dbConfig close];
    
    dbConfig=nil;
}

+(NSString *)configDbPath
{
    NSString *path2ret=[[NSBundle mainBundle] pathForResource:@"xbb" ofType:@"db"];
    return path2ret;
}

+(FMDatabase *)configDb
{
    if (nil == dbConfig) {
        dbConfig = [FMDatabase databaseWithPath:[DbHandler configDbPath]];
        
        if (![dbConfig open]) {
            // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
            dbConfig = nil;
        }
    }
    
    return dbConfig;
}

+(NSArray *)getAllHeros
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_info` ORDER BY `rowid`"];
    while ([s next]) {
        HeroInfo *aHero=[HeroInfo new];
        
        aHero.heroId=[s stringForColumn:@"hero_id"];
        aHero.heroName=[s stringForColumn:@"hero_name"];
        aHero.heroType=[s stringForColumn:@"hero_type"];
        aHero.heroPos=[s stringForColumn:@"hero_pos"];
        aHero.heroFragmentFrom=[s stringForColumn:@"hero_fragment_from"];
        aHero.heroDesc=[s stringForColumn:@"hero_desc"];
        
        aHero.initStar=[s intForColumn:@"hero_init_star"];

        aHero.tuijianLevel=[s intForColumn:@"tuijian_level"];
        aHero.rushouNanduLevel=[s intForColumn:@"rushou_nandu_level"];
        aHero.starUpLevel=[s intForColumn:@"starup_level"];
        aHero.shuchuLevel=[s intForColumn:@"shuchu_level"];
        aHero.tuanduiFuzhuLevel=[s intForColumn:@"tuandui_fuzhu_level"];
        
        aHero.thumbFile=[s stringForColumn:@"thumb_file"];
        aHero.thumbFileS=[s stringForColumn:@"thumb_file_s"];
        aHero.artFile=[s stringForColumn:@"art_file"];
        aHero.artFileS=[s stringForColumn:@"art_file_s"];
        aHero.shortName=[s stringForColumn:@"short_name"];
        
        aHero.initLiliang=[s intForColumn:@"init_liliang"];
        aHero.initZhili=[s intForColumn:@"init_zhili"];
        aHero.initMinjie=[s intForColumn:@"init_minjie"];
        aHero.initHealthMax=[s intForColumn:@"init_health_max"];
        aHero.initPhysicsGongji=[s intForColumn:@"init_physics_gongji"];
        aHero.initMagicQiangdu=[s intForColumn:@"init_magic_qiangdu"];
        aHero.initPhysicsHujia=[s intForColumn:@"init_physics_hujia"];
        aHero.initMagicKangxing=[s intForColumn:@"init_magic_kangxing"];
        aHero.initPhysicaBaoji=[s intForColumn:@"init_physics_baoji"];
        
        [arr2ret addObject:aHero];
    }
    
    return arr2ret;
}

+(NSDictionary *)getAllHeroTypeDescDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `type_desc`"];
    while ([s next]) {
        HeroTypeDesc *aHeroTypeDesc=[HeroTypeDesc new];
        
        aHeroTypeDesc.typeId=[s stringForColumn:@"type_id"];
        aHeroTypeDesc.typeDesc=[s stringForColumn:@"type_name"];
        aHeroTypeDesc.typeThumb=[s stringForColumn:@"thumb"];
        aHeroTypeDesc.typeThumbS=[s stringForColumn:@"thumb_s"];
        
        [dict2ret setObject:aHeroTypeDesc forKey:aHeroTypeDesc.typeId];
    }
    
    return dict2ret;
}
@end
