//
//  MeetingRoom.m
//  TelLookup
//
//  Created by Panumat Muroa on 6/23/14.
//  Copyright (c) 2014 Panumat Muroa. All rights reserved.
//

#import "MeetingRoom.h"

@implementation MeetingRoom

@synthesize wsData;

-(NSArray *)getRoomSched:(NSString *)roomNo ReservedDate:(NSString *)reservedDate;
{
    cacheDB = [[CacheDBCommands alloc] init];
    cacheDB.delegate = self;
    [cacheDB getReservedDataset:roomNo Para2:reservedDate];
    
    //clear data
    [self.wsData removeAllObjects];
    NSMutableDictionary *rows = [[NSMutableDictionary alloc] initWithDictionary:[cacheDB.myDataset getRowsForTable:@"Table"]];
    //each object in the array is a dictionary object containing all of the columns and values
    self.wsData = [[NSMutableArray alloc] initWithArray:[rows allValues]];
    
    return self.wsData;
}

#pragma mark -
#pragma mark CacheDBCommands Delegate

- (void)willStartDownloading:(CacheDBCommands *)cacheDB
{
    //NSLog(@"Delegate called start downloading", nil);
    //[self.act startAnimating];
    //self.act.hidden = NO;
}

-(void)didFinishDownloading:(CacheDBCommands *)acacheDB
{
    //NSLog(@"Delegate called finish downloading", nil);
    
    //clear data
    //[self.wsData removeAllObjects];
    //NSMutableDictionary *rows = [[NSMutableDictionary alloc] initWithDictionary:[acacheDB.myDataset getRowsForTable:@"Table"]];
    //each object in the array is a dictionary object containing all of the columns and values
    //self.wsData = [[NSMutableArray alloc] initWithArray:[rows allValues]];
    
    //NSLog (@"Index position 0 = %@", [wsData objectAtIndex:0]);
    
    // Display data to screen
    //NSString *tmpEmail;
    //tmpEmail = [[wsData objectAtIndex:0] objectForKey: @"Email"];
    //NSArray *substringsEmail = [tmpEmail componentsSeparatedByString:@"@"];
    //NSString *namepart = [substringsEmail objectAtIndex:0];     // Extract only name name before @ sign
    
    //NSString *tmpExtNo;
    
    //ExtNo = [[wsData objectAtIndex:0] objectForKey: @"ExtNo"];
    
    //------ Return value to caller ------
    //txtEmail.text=namepart;
    //txtExtNo.text=tmpExtNo;
    
}

@end
