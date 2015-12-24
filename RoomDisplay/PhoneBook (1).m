//
//  PhoneBook.m
//  TelLookup
//
//  Created by Panumat Muroa on 6/8/14.
//  Copyright (c) 2014 Panumat Muroa. All rights reserved.
//

#import "PhoneBook.h"

@implementation PhoneBook

@synthesize wsData;

-(NSArray *)getReservedFor:(NSString *)userCname
{
    cacheDB = [[CacheDBCommands alloc] init];
    cacheDB.delegate = self;
    [cacheDB getPersonDataset:userCname Para2:@""];
    
    //clear data
    [self.wsData removeAllObjects];
    NSMutableDictionary *rows = [[NSMutableDictionary alloc] initWithDictionary:[cacheDB.myDataset getRowsForTable:@"Table"]];
    //each object in the array is a dictionary object containing all of the columns and values
    self.wsData = [[NSMutableArray alloc] initWithArray:[rows allValues]];
    
    NSString *tmpExtNo;
    NSString *tmpusername;
    NSString *tmpEmail;
    
    if (wsData.count == 0) {
        tmpExtNo = @"-";
        //tmpusername = [[wsData objectAtIndex:0] objectForKey: @"Email"];
        //tmpEmail = @"-";
        tmpEmail = [self getOnlyShortName:(userCname)];
    }
    else {
        tmpExtNo = [[wsData objectAtIndex:0] objectForKey: @"ExtNo"];
        tmpusername = [[wsData objectAtIndex:0] objectForKey: @"Email"];
        tmpEmail = [self getOnlyName:(tmpusername)];
    }
    
    // Prepare return arra, index 0 = User name, index 1 = Extension No
    NSArray *retArray = [NSArray arrayWithObjects:tmpEmail,tmpExtNo,nil];
    
    return retArray;
}

-(NSString *)getOnlyName:(NSString *)userFname;
{
    // Extract only name name before @ sign
    NSArray *substringsEmail = [userFname componentsSeparatedByString:@"@"];
    NSString *namepart = [substringsEmail objectAtIndex:0];
    
    return namepart;
}

-(NSString *)getOnlyShortName:(NSString *)userSname;
{
    // Extract only name name before / sign
    NSArray *substringSname = [userSname componentsSeparatedByString:@"/"];
    NSString *namepart = [substringSname objectAtIndex:0];
    
    return namepart;
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
