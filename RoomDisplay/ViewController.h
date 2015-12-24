//
//  ViewController.h
//  RoomDisplay
//
//  Created by Panumat Muroa on 5/3/14.
//  Copyright (c) 2014 MyProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingRoom.h"
#import "PhoneBook.h"
#import "CKCalendarView.h"

@interface ViewController : UIViewController <CKCalendarDelegate>

//--- web service access ---
{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    
    CacheDBCommands *cacheDB;
    NSMutableArray *wsData;
    NSString *theUname;
    
}


@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@property (nonatomic,retain) IBOutlet UITextField *txtResRoom;
@property (nonatomic,retain) IBOutlet UITextField *txtResDate;
@property (nonatomic,retain) IBOutlet UILabel *lblRoomNo;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UILabel *lblTime;
@property (nonatomic,retain) IBOutlet UILabel *txtRow1;
@property (nonatomic,retain) IBOutlet UILabel *txtRow2;
@property (nonatomic,retain) IBOutlet UILabel *txtRow3;
@property (nonatomic,retain) IBOutlet UILabel *txtRow4;
@property (nonatomic,retain) IBOutlet UILabel *txtRow5;

@property (nonatomic,retain) NSMutableArray *wsData;
@property (nonatomic,retain) NSString *theUname;

- (IBAction)btnQuery:(id)sender;
- (IBAction)btnSelectRoom:(id)sender;
- (IBAction)btnSelectDate:(id)sender;

@end
