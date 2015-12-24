//
//  CacheDBCommands.h
//  NETDataset
//
//  Created by Kris Bray on 10-01-22.
//  Copyright 2010 Imperium. All rights reserved.
//

#import "DataSet.h"

@class CacheDBCommands;
@protocol CacheDBDelegate <NSObject>
@optional
- (void)willStartDownloading:(CacheDBCommands *)cacheDB;
- (void)didFinishDownloading:(CacheDBCommands *)cacheDB;
- (void)shouldShowSignIn:(CacheDBCommands *)cacheDB;
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
@end

@interface CacheDBCommands : NSObject

{
	id <CacheDBDelegate>delegate;
	DataSet *myDataset;
	NSString *XMLNamespace;
	NSString *ServerURL;
}

@property(nonatomic, retain) DataSet *myDataset;
@property(nonatomic, copy) NSString *XMLNamespace;
@property(nonatomic, copy) NSString *ServerURL;
@property(nonatomic, assign) id <CacheDBDelegate>delegate;

-(void)getPersonDataset:(NSString *)para1 Para2:(NSString *)para2;
-(void)getReservedDataset:(NSString *)para1 Para2:(NSString *)para2;

@end


