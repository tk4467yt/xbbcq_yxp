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
#import "StarDesc.h"
#import "SpeciesDesc.h"
#import "RankDesc.h"
#import "PosDesc.h"
#import "HeroSpecies.h"
#import "HeroSkill.h"
#import "HeroGrow.h"
#import "HeroEquips.h"
#import "FragmentFromDesc.h"
#import "EquipInfo.h"
#import "EquipComposeInfo.h"
#import "EquipAttrDesc.h"

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
        
        [DbHandler getHeroInfoFromSet:s intoHeroInfo:aHero];
        
        [arr2ret addObject:aHero];
    }
    
    return arr2ret;
}

+ (void)getHeroInfoFromSet:(FMResultSet *)s intoHeroInfo:(HeroInfo *)aHero
{
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
    
    aHero.isHunXiaHero=[s boolForColumn:@"is_hun_xia"];
}

+(HeroInfo *)getHeroInfoWithHeroId:(NSString *)heroId
{
    HeroInfo *aHero=[HeroInfo new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_info` WHERE `hero_id` = ?",heroId];
    if ([s next]) {
        [DbHandler getHeroInfoFromSet:s intoHeroInfo:aHero];
    }
    
    return aHero;
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

+(NSArray *)getAllStarDesc
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `star_desc` ORDER BY `star_count`"];
    while ([s next]) {
        StarDesc *aStarDesc=[StarDesc new];
        
        aStarDesc.starCount=[s intForColumn:@"star_count"];
        aStarDesc.starDesc=[s stringForColumn:@"star_desc"];
        
        [arr2ret addObject:aStarDesc];
    }
    
    return arr2ret;
}

+(NSDictionary *)getAllSpeciesDescDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `species_desc`"];
    while ([s next]) {
        SpeciesDesc *aSpeciesDesc=[SpeciesDesc new];
        
        aSpeciesDesc.speciesId=[s stringForColumn:@"species_id"];
        aSpeciesDesc.speciesDesc=[s stringForColumn:@"species_desc"];
        aSpeciesDesc.speciesThumb=[s stringForColumn:@"species_thumb"];
        
        [dict2ret setObject:aSpeciesDesc forKey:aSpeciesDesc.speciesId];
    }
    
    return dict2ret;
}

+(void)getRankDescFromSet:(FMResultSet *)s intoRank:(RankDesc *)aRankDesc
{
    aRankDesc.rankId=[s stringForColumn:@"rank_id"];
    aRankDesc.rankName=[s stringForColumn:@"rank_name"];
    aRankDesc.artBgThumb=[s stringForColumn:@"art_bg_thumb"];
    aRankDesc.equipFrameThumb=[s stringForColumn:@"equip_frame_thumb"];
    aRankDesc.fragmentFrameThumb=[s stringForColumn:@"fragment_frame_thumb"];
    aRankDesc.heroIconFrameThumb=[s stringForColumn:@"hero_icon_frame_thumb"];
}

+(NSDictionary *)getAllRankDescDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `rank_desc`"];
    while ([s next]) {
        RankDesc *aRankDesc=[RankDesc new];
        
        [DbHandler getRankDescFromSet:s intoRank:aRankDesc];
        
        [dict2ret setObject:aRankDesc forKey:aRankDesc.rankId];
    }
    
    return dict2ret;
}

+(RankDesc *)getRankDescForRankId:(NSString *)rankId
{
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `rank_desc` WHERE `rank_id` = ?",rankId];
    
    RankDesc *aRankDesc=[RankDesc new];
    
    if ([s next]) {
        [DbHandler getRankDescFromSet:s intoRank:aRankDesc];
    }
    
    return aRankDesc;
}

+(NSDictionary *)getAllPosDescDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `pos_desc`"];
    while ([s next]) {
        PosDesc *aPosDesc=[PosDesc new];
        
        aPosDesc.posId=[s stringForColumn:@"pos_id"];
        aPosDesc.posDesc=[s stringForColumn:@"pos_desc"];
        
        [dict2ret setObject:aPosDesc forKey:aPosDesc.posId];
    }
    
    return dict2ret;
}

+(NSArray *)getAllHeroSpecies
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_species`"];
    while ([s next]) {
        HeroSpecies *aHeroSpecies=[HeroSpecies new];
        
        aHeroSpecies.heroId=[s stringForColumn:@"hero_id"];
        aHeroSpecies.speciesId=[s stringForColumn:@"species_id"];
        
        [arr2ret addObject:aHeroSpecies];
    }
    
    return arr2ret;
}

+(NSArray *)getHeroSpeciesForHero:(NSString *)heroId
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_species` WHERE `hero_id` = ?",heroId];
    while ([s next]) {
        HeroSpecies *aHeroSpecies=[HeroSpecies new];
        
        aHeroSpecies.heroId=[s stringForColumn:@"hero_id"];
        aHeroSpecies.speciesId=[s stringForColumn:@"species_id"];
        
        [arr2ret addObject:aHeroSpecies];
    }
    
    return arr2ret;
}

+(NSArray *)getAllHeroSkills
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_skill`"];
    while ([s next]) {
        HeroSkill *aHeroSkill=[HeroSkill new];
        
        aHeroSkill.heroId=[s stringForColumn:@"hero_id"];
        aHeroSkill.skillId=[s stringForColumn:@"skill_id"];
        aHeroSkill.skillName=[s stringForColumn:@"skill_name"];
        aHeroSkill.skillDesc=[s stringForColumn:@"skill_desc"];
        aHeroSkill.skillThumb=[s stringForColumn:@"skill_thumb"];
        
        [arr2ret addObject:aHeroSkill];
    }
    
    return arr2ret;
}

+(NSArray *)getHeroSkillsForHero:(NSString *)heroId
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_skill` WHERE `hero_id` = ? ORDER BY `rowid`",heroId];
    while ([s next]) {
        HeroSkill *aHeroSkill=[HeroSkill new];
        
        aHeroSkill.heroId=[s stringForColumn:@"hero_id"];
        aHeroSkill.skillId=[s stringForColumn:@"skill_id"];
        aHeroSkill.skillName=[s stringForColumn:@"skill_name"];
        aHeroSkill.skillDesc=[s stringForColumn:@"skill_desc"];
        aHeroSkill.skillThumb=[s stringForColumn:@"skill_thumb"];
        
        [arr2ret addObject:aHeroSkill];
    }
    
    return arr2ret;
}

+(NSArray *)getAllHeroGrow
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_grow`"];
    while ([s next]) {
        HeroGrow *aHeroGrow=[HeroGrow new];
        
        aHeroGrow.heroId=[s stringForColumn:@"hero_id"];
        aHeroGrow.starCount=[s intForColumn:@"star_count"];
        aHeroGrow.liliang=[s doubleForColumn:@"li_liang"];
        aHeroGrow.zhili=[s doubleForColumn:@"zhi_li"];
        aHeroGrow.minjie=[s doubleForColumn:@"min_jie"];
        
        [arr2ret addObject:aHeroGrow];
    }
    
    return arr2ret;
}

+(NSArray *)getHeroGrowForHero:(NSString *)heroId
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_grow` WHERE `hero_id` = ?",heroId];
    while ([s next]) {
        HeroGrow *aHeroGrow=[HeroGrow new];
        
        aHeroGrow.heroId=[s stringForColumn:@"hero_id"];
        aHeroGrow.starCount=[s intForColumn:@"star_count"];
        aHeroGrow.liliang=[s doubleForColumn:@"li_liang"];
        aHeroGrow.zhili=[s doubleForColumn:@"zhi_li"];
        aHeroGrow.minjie=[s doubleForColumn:@"min_jie"];
        
        [arr2ret addObject:aHeroGrow];
    }
    
    return arr2ret;
}

+(NSArray *)getAllHeroEquips
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_equips`"];
    while ([s next]) {
        HeroEquips *aHeroEquip=[HeroEquips new];
        
        aHeroEquip.heroId=[s stringForColumn:@"hero_id"];
        aHeroEquip.heroRank=[s stringForColumn:@"hero_rank"];
        aHeroEquip.equip1=[s stringForColumn:@"equip_1"];
        aHeroEquip.equip2=[s stringForColumn:@"equip_2"];
        aHeroEquip.equip3=[s stringForColumn:@"equip_3"];
        aHeroEquip.equip4=[s stringForColumn:@"equip_4"];
        aHeroEquip.equip5=[s stringForColumn:@"equip_5"];
        aHeroEquip.equip6=[s stringForColumn:@"equip_6"];
        
        [arr2ret addObject:aHeroEquip];
    }
    
    return arr2ret;
}

+(NSDictionary *)getHeroEquipsDictForHero:(NSString *)heroId
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `hero_equips` WHERE `hero_id` = ?",heroId];
    while ([s next]) {
        HeroEquips *aHeroEquip=[HeroEquips new];
        
        aHeroEquip.heroId=[s stringForColumn:@"hero_id"];
        aHeroEquip.heroRank=[s stringForColumn:@"hero_rank"];
        aHeroEquip.equip1=[s stringForColumn:@"equip_1"];
        aHeroEquip.equip2=[s stringForColumn:@"equip_2"];
        aHeroEquip.equip3=[s stringForColumn:@"equip_3"];
        aHeroEquip.equip4=[s stringForColumn:@"equip_4"];
        aHeroEquip.equip5=[s stringForColumn:@"equip_5"];
        aHeroEquip.equip6=[s stringForColumn:@"equip_6"];
        
        [dict2ret setObject:aHeroEquip forKey:aHeroEquip.heroRank];
    }
    
    return dict2ret;
}

+(NSDictionary *)getAllFragmentFromDescDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `fragment_from_desc`"];
    while ([s next]) {
        FragmentFromDesc *aFragmentFromDesc=[FragmentFromDesc new];
        
        aFragmentFromDesc.fromId=[s stringForColumn:@"from_id"];
        aFragmentFromDesc.fromDesc=[s stringForColumn:@"from_desc"];
        
        [dict2ret setObject:aFragmentFromDesc forKey:aFragmentFromDesc.fromId];
    }
    
    return dict2ret;
}

+(void)getEquipInfoFromSet:(FMResultSet *)s intoEquip:(EquipInfo *)aEquipInfo
{
    aEquipInfo.equipId=[s stringForColumn:@"equip_id"];
    aEquipInfo.equipName=[s stringForColumn:@"equip_name"];
    
    aEquipInfo.levelRequire=[s intForColumn:@"level_require"];
    aEquipInfo.isCompose=[s boolForColumn:@"is_compose"];
    
    aEquipInfo.equipRank=[s stringForColumn:@"equip_rank"];
    aEquipInfo.thumbFile=[s stringForColumn:@"thumb_file"];
    
    aEquipInfo.showInBook=[s boolForColumn:@"show_in_book"];
    
    aEquipInfo.liliang=[s doubleForColumn:@"li_liang"];
    aEquipInfo.minjie=[s doubleForColumn:@"min_jie"];
    aEquipInfo.zhili=[s doubleForColumn:@"zhi_li"];
    aEquipInfo.healthMax=[s doubleForColumn:@"health_max"];
    aEquipInfo.healthRecover=[s doubleForColumn:@"health_recover"];
    aEquipInfo.energyRecover=[s doubleForColumn:@"energy_recover"];
    aEquipInfo.physicsGongji=[s doubleForColumn:@"physics_gongji"];
    aEquipInfo.physicsHujia=[s doubleForColumn:@"physics_hujia"];
    aEquipInfo.physicsBaoji=[s doubleForColumn:@"physics_baoji"];
    aEquipInfo.chuantouPhysicsHujia=[s doubleForColumn:@"chuantou_physics_hujia"];
    aEquipInfo.magicQiangdu=[s doubleForColumn:@"magic_qiangdu"];
    aEquipInfo.magicBaoji=[s doubleForColumn:@"magic_baoji"];
    aEquipInfo.magicKangxing=[s doubleForColumn:@"magic_kangxing"];
    aEquipInfo.hulueMagicKangxing=[s doubleForColumn:@"hulue_magic_kangxing"];
    aEquipInfo.xixue=[s doubleForColumn:@"xixue"];
    aEquipInfo.zhiliaoXiaoguo=[s doubleForColumn:@"zhiliao_xiaoguo"];
    aEquipInfo.shangbi=[s doubleForColumn:@"shangbi"];
    aEquipInfo.mingzhong=[s doubleForColumn:@"mingzhong"];
    aEquipInfo.minusControlTime=[s doubleForColumn:@"minus_control_time"];
    aEquipInfo.yingzhiDikang=[s doubleForColumn:@"yingzhi_dikang"];
    aEquipInfo.chengmoDikang=[s doubleForColumn:@"chengmo_dikang"];
    aEquipInfo.minusNengliangXiaohao=[s doubleForColumn:@"minus_nengliang_xiaohao"];
    aEquipInfo.skillLevelAddon=[s doubleForColumn:@"skill_level_addon"];
    aEquipInfo.siWangDuiFangHuiNengJianBan=[s doubleForColumn:@"si_wang_dui_fang_hui_neng_jian_ban"];
}

+(NSArray *)getAllEquipInfo
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `equip_info` ORDER BY `level_require`"];
    while ([s next]) {
        EquipInfo *aEquipInfo=[EquipInfo new];
        
        [DbHandler getEquipInfoFromSet:s intoEquip:aEquipInfo];
        
        [arr2ret addObject:aEquipInfo];
    }
    
    return arr2ret;
}

+(EquipInfo *)getEquipInfoForEquipId:(NSString *)equipId
{
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `equip_info` WHERE `equip_id` = ?",equipId];
    
    EquipInfo *aEquipInfo=[EquipInfo new];
    if ([s next]) {
        [DbHandler getEquipInfoFromSet:s intoEquip:aEquipInfo];
    }
    
    return aEquipInfo;
}

+(NSDictionary *)getAllEquipComposeInfo
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `equip_compose_info`"];
    while ([s next]) {
        EquipComposeInfo *aEquipComposeInfo=[EquipComposeInfo new];
        
        aEquipComposeInfo.equipId=[s stringForColumn:@"equip_id"];
        aEquipComposeInfo.fragmentCount=[s intForColumn:@"fragment_count"];
        aEquipComposeInfo.composeFrom1=[s stringForColumn:@"compose_from_1"];
        aEquipComposeInfo.composeFrom2=[s stringForColumn:@"compose_from_2"];
        aEquipComposeInfo.composeFrom3=[s stringForColumn:@"compose_from_3"];
        aEquipComposeInfo.composeFrom4=[s stringForColumn:@"compose_from_4"];
        
        [dict2ret setObject:aEquipComposeInfo forKey:aEquipComposeInfo.equipId];
    }
    
    return dict2ret;
}

+(EquipComposeInfo *)getEquipComposeInfoForEquipId:(NSString *)equipId
{
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `equip_compose_info` WHERE `equip_id` = ?",equipId];
    EquipComposeInfo *aEquipComposeInfo;
    if ([s next]) {
        aEquipComposeInfo=[EquipComposeInfo new];
        
        aEquipComposeInfo.equipId=[s stringForColumn:@"equip_id"];
        aEquipComposeInfo.fragmentCount=[s intForColumn:@"fragment_count"];
        aEquipComposeInfo.composeFrom1=[s stringForColumn:@"compose_from_1"];
        aEquipComposeInfo.composeFrom2=[s stringForColumn:@"compose_from_2"];
        aEquipComposeInfo.composeFrom3=[s stringForColumn:@"compose_from_3"];
        aEquipComposeInfo.composeFrom4=[s stringForColumn:@"compose_from_4"];
    }
    
    return aEquipComposeInfo;
}

+(NSArray *)getAllEquipAttrDescArr
{
    NSMutableArray *arr2ret=[NSMutableArray new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `equip_attr_desc` ORDER BY `rowid`"];
    while ([s next]) {
        EquipAttrDesc *aEquipAttrDesc=[EquipAttrDesc new];
        
        aEquipAttrDesc.attrId=[s stringForColumn:@"attr_id"];
        aEquipAttrDesc.attrDesc=[s stringForColumn:@"attr_desc"];
        
        [arr2ret addObject:aEquipAttrDesc];
    }
    
    return arr2ret;
}

+(NSDictionary *)getAllJuexingSuipianFromDict
{
    NSMutableDictionary *dict2ret=[NSMutableDictionary new];
    
    FMResultSet *s = [dbConfig executeQuery:@"SELECT * FROM `juexing_suipian_from`"];
    while ([s next]) {
        NSString *fromDesc=[s stringForColumn:@"from_desc"];
        NSString *heroId=[s stringForColumn:@"hero_id"];
        
        NSMutableArray *heroArr=[dict2ret objectForKey:fromDesc];
        if (nil == heroArr) {
            heroArr=[NSMutableArray new];
        }
        [heroArr addObject:heroId];
        
        [dict2ret setObject:heroArr forKey:fromDesc];
    }
    
    return dict2ret;
}
@end
