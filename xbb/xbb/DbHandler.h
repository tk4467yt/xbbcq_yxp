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

@end
