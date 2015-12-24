//  DataSet.m
// 
//  Created by Kris Bray with Imperium on 27/05/10.
// * This code is licensed under the GPLv3 license.

#import "DataSet.h"
#import "XMLDataSetParser.h"

@implementation DataSet

@synthesize Tables;
@synthesize DataSetName;
@synthesize doDebug;
@synthesize xmParser;

-(id) init
{
	XmlDataSetParser *tmXmParser = [[XmlDataSetParser  alloc] init];
	self.xmParser = tmXmParser;
	[tmXmParser release];
	return self;
	
}

-(void)removeAllObjects
{
	self.DataSetName = @"";
	self.xmParser.DataSetName = nil;
	self.xmParser.beginDataset = NO;
	self.xmParser.currentRow  = @"0";

	//clear tables
	NSEnumerator *tblIterator = [self.Tables keyEnumerator];
	NSString *tblKey;
	while(tblKey = [tblIterator nextObject])
	{
		NSMutableDictionary *thisTbl = [self.Tables objectForKey:tblKey];
		NSEnumerator *rowIterator = [thisTbl keyEnumerator];
		NSString *rowKey;
		while (rowKey = [rowIterator nextObject]) {
			NSMutableDictionary *thisRow = [thisTbl objectForKey:rowKey];
			NSArray *allKeys = [[NSArray alloc] initWithArray:[thisRow allKeys]];
			NSUInteger i;
			for(i=0;i<[allKeys count];i++)
			{
				[thisRow setObject:@"" forKey:[allKeys objectAtIndex:i]];
				//NSLog(@"thisRowValue:%@ thisKey:%@", [thisRow objectForKey:[allKeys objectAtIndex:i]], [allKeys objectAtIndex:i], nil);
			}
			
			[allKeys release];
			[thisRow removeAllObjects];
			
		}
		[thisTbl removeAllObjects];
	}

	[self.Tables removeAllObjects];
	//NSLog(@"TableCount:%d", [self.Tables count],nil);
}

-(void)parseXMLWithData:(NSMutableData *)data
{
	//reset my own data
	[self removeAllObjects];
	
    if(self.doDebug)
    //encode rawdata from httprequest to string for debugging
	{
		NSString *theXml = [[NSString alloc] initWithBytes:[data mutableBytes] length:[data length] encoding:NSUTF8StringEncoding];
		NSLog(@"response:%@", theXml, nil);
		[theXml release];
	}
    
	// Create the XML Parser Objects
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    // Set XMLParser as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	
    [parser setDelegate:self.xmParser];
    // Set Parser Options
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    // Begin parsing the XML
	xmParser.beginTable = NO;
	xmParser.beginDataset = NO;
	xmParser.currentRow = @"0";
	
    [parser parse];
	
	self.Tables = self.xmParser.Tables;
	self.DataSetName = self.xmParser.DataSetName;
	
	//NSLog(@"%@", self.Tables, nil);  // display contenet of Tables
	[parser release]; 
}

-(NSMutableDictionary *)getRowsForTable:(NSString *)tableName
{
	
	NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.Tables objectForKey:tableName]] ;

	if ([returnDictionary count] > 0)
	{
		//there was data return the array else return nil
		return returnDictionary;
	}
	else
	{
		return nil;
	}

}

-(NSMutableArray *)getRowsForTableWhereColumnEquals:(NSString *)tableName Column:(NSString *)col Where:(NSString *)where
{
	
	NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
	NSMutableDictionary *tbl = [[NSMutableDictionary alloc] initWithDictionary:[self.Tables objectForKey:tableName]];
	
	NSEnumerator *tblIterator = [tbl keyEnumerator];
	NSString *tblKey;
	
	//loop through array
	while(tblKey = [tblIterator nextObject])
	{
		
		NSMutableDictionary *thisRow = [tbl objectForKey:tblKey];
		if([(NSString *)[thisRow objectForKey:col] isEqualToString:where])[returnArray addObject:thisRow];
		
	}	
	[tbl release];
	if ([returnArray count] == 0)
	{
		//there was data return the array else return nil
		returnArray = nil;
	}
	
	return returnArray;
	
}

-(void)dealloc
{
	[xmParser release];
	[DataSetName release];
	[super dealloc];
	
}

@end
