//
//  CacheDBCommands.m
//  NETDataset
//
//  Created by Kris Bray on 10-01-22.
//  Copyright 2010 Imperium. All rights reserved.
//

#import "WebServiceHelper.h"
#import "CacheDBCommands.h"

@implementation CacheDBCommands

@synthesize myDataset;
@synthesize delegate;
@synthesize XMLNamespace;
@synthesize ServerURL;

- (void)setDelegate:(id)aDelegate
{   delegate = aDelegate; /// Not retained
	//any time delegate changes reset everything
	//[self reset];
}

-(id)init
{
	
	self.XMLNamespace = @"http://BPuri.com/"; //this must match what is in your .net web service code
	//self.ServerURL = @"http://192.168.1.170/BPWebService/ResService.asmx";    // Server at home
    self.ServerURL = @"http://10.2.0.6/BPWebService/ResService.asmx";       // Server at office
    
	DataSet *tmp = [[DataSet alloc] init];
	self.myDataset = tmp;
	[tmp release];
	
	return self;
}

-(void)dealloc
{
	[myDataset release];
	[ServerURL release];
	[XMLNamespace release];
	[super dealloc];
}

#pragma mark -
#pragma mark Download Work Methods

-(void)getPersonDataset:(NSString *)para1 Para2:(NSString *)para2
{
    
    NSArray *params = [[NSArray alloc] initWithObjects:para1, para2, nil];
    
    // -------------------
    // Get Reserve person
    // -------------------
    NSString *param1 = [params objectAtIndex:0];
    
    // Create an object to the class above which is the connection to the WCF Service
    WebServiceHelper *DataCon = [[WebServiceHelper alloc] init];
    //set up service method and urls
    DataCon.XMLNameSpace = self.XMLNamespace;
    DataCon.XMLURLAddress = self.ServerURL;
    
    //set up method and parameters
    //DataCon.MethodName = @"GetResPerson";
    DataCon.MethodName = @"GetResPersonTab";
    
    DataCon.MethodParameters = [[NSMutableDictionary alloc] init];
    [DataCon.MethodParameters setObject:param1 forKey:@"resPerson"];
    
    NSMutableData *retData;
    retData = [DataCon initiateConnection];
    
    //self.myDataset.doDebug = YES; //uncomment to print all data to NSLog
    [self.myDataset parseXMLWithData:retData];
    
    [DataCon release];
    
    //call delegate to let view know we have finished downloading this
    [delegate performSelectorOnMainThread:@selector(didFinishDownloading:)
                               withObject:self
                            waitUntilDone:NO];
}

-(void)getReservedDataset:(NSString *)para1 Para2:(NSString *)para2
{
  
    NSArray *params = [[NSArray alloc] initWithObjects:para1, para2, nil];
    
    // -------------------
    // Get Reserve person
    // -------------------
    NSString *param1 = [params objectAtIndex:0];
    NSString *param2 = [params objectAtIndex:1];
    
    // Create an object to the class above which is the connection to the WCF Service
    WebServiceHelper *DataCon = [[WebServiceHelper alloc] init];
    //set up service method and urls
    DataCon.XMLNameSpace = self.XMLNamespace;
    DataCon.XMLURLAddress = self.ServerURL;
    
    //set up method and parameters
    //DataCon.MethodName = @"GetResSched";
    DataCon.MethodName = @"GetResSchedTab";
    
    DataCon.MethodParameters = [[NSMutableDictionary alloc] init];
    [DataCon.MethodParameters setObject:param1 forKey:@"resRoom"];
    [DataCon.MethodParameters setObject:param2 forKey:@"resDate"];
    
    NSMutableData *retData;
    retData = [DataCon initiateConnection];
    
    //self.myDataset.doDebug = YES; //uncomment to print all data to NSLog
    [self.myDataset parseXMLWithData:retData];
    
    [DataCon release];
    
    //call delegate to let view know we have finished downloading this
    [delegate performSelectorOnMainThread:@selector(didFinishDownloading:)
                               withObject:self
                            waitUntilDone:NO];
}

@end
