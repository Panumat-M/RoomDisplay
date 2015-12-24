//
//  PhoneBook.h
//  TelLookup
//
//  Created by Panumat Muroa on 6/8/14.
//  Copyright (c) 2014 Panumat Muroa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheDBCommands.h"

@interface PhoneBook : NSObject <CacheDBDelegate>

//--- web service access ---
{
    CacheDBCommands *cacheDB;
    NSMutableArray *wsData;
}

@property (nonatomic,retain) NSMutableArray *wsData;

 -(NSArray *)getReservedFor:(NSString *)userCname;

@end
