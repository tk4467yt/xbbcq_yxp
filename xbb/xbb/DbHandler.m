//
//  DbHandler.m
//  xbb
//
//  Created by  qin on 2017/3/2.
//  Copyright © 2017年  qin. All rights reserved.
//

#import "DbHandler.h"
#import "FMDatabase.h"

@implementation DbHandler

+(void)initLocalDatabase
{
    
}

+(NSString *)configDbPath
{
    NSString *path2ret=[[NSBundle mainBundle] pathForResource:@"xbb" ofType:@"db"];
    return path2ret;
}

+(FMDatabase *)configDb
{
    static FMDatabase *db = nil;
    if (nil == db) {
        db = [FMDatabase databaseWithPath:[DbHandler configDbPath]];
        
        if (![db open]) {
            // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
            db = nil;
        }
    }
    
    return db;
}

+(NSArray *)getAllHeros
{
    FMResultSet *s = [[DbHandler configDb] executeQuery:@"SELECT * FROM `hero_info`"];
    while ([s next]) {
        NSString *heroName=[s stringForColumn:@"hero_name"];
        
    }
    return nil;
}
@end
