//
//  ViewController.m
//  RoomDisplay
//
//  Created by Panumat Muroa on 5/3/14.
//  Copyright (c) 2014 MyProject. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize txtResRoom;
@synthesize txtResDate;
@synthesize lblRoomNo;
@synthesize lblDate;
@synthesize lblTime;
@synthesize txtRow1;
@synthesize txtRow2;
@synthesize txtRow3;
@synthesize txtRow4;
@synthesize txtRow5;

@synthesize wsData;
@synthesize theUname;


- (id)init {
    /*
    self = [super init];
    if (self) {
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        self.calendar = calendar;
        calendar.delegate = self;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
        
        self.disabledDates = @[
                               [self.dateFormatter dateFromString:@"05/01/2013"],
                               [self.dateFormatter dateFromString:@"06/01/2013"],
                               [self.dateFormatter dateFromString:@"07/01/2013"]
                               ];
        
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        
        calendar.frame = CGRectMake(10, 10, 300, 320);
        [self.view addSubview:calendar];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
        [self.view addSubview:self.dateLabel];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    return self;
    */
    
    return nil;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    txtResRoom.text = nil;
    txtResDate.text = nil;
    lblRoomNo.text = nil;
    lblDate.text = nil;
    lblTime.text = nil;
    txtRow1.text = nil;
    txtRow2.text = nil;
    txtRow3.text = nil;
    txtRow4.text = nil;
    txtRow5.text = nil;
}

- (void)viewDidUnload
{
    [self setTxtResRoom:nil];
    [self setTxtResDate:nil];
    [self setLblRoomNo:nil];
    [self setLblDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSelectRoom:(id)sender {
    
    // Select Room
    //[calendar.view removeFromSuperview];
    [self.calendar removeFromSuperview];
    
}

- (IBAction)btnSelectDate:(id)sender {
    
    // Select Date
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //[self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    self.minimumDate = [self.dateFormatter dateFromString:@"2012-09-20"];
    
    //self.disabledDates = @[
    //                       [self.dateFormatter dateFromString:@"05/01/2013"],
    //                       [self.dateFormatter dateFromString:@"06/01/2013"],
    //                       [self.dateFormatter dateFromString:@"07/01/2013"]
    //                       ];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"2013-01-05"],
                           [self.dateFormatter dateFromString:@"2013-01-06"],
                           [self.dateFormatter dateFromString:@"2013-01-07"]
                           ];

    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(10, 10, 300, 320);
    [self.view addSubview:calendar];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    [self.view addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
}

- (IBAction)btnQuery:(id)sender
{
    //
    NSString *theResRoom = txtResRoom.text;
    NSString *theResDate = txtResDate.text;
    
    lblRoomNo.text=theResRoom;
    lblDate.text=theResDate;
    txtRow1.text = nil;
    txtRow2.text = nil;
    txtRow3.text = nil;
    txtRow4.text = nil;
    txtRow5.text = nil;

    // hide keypad
    if ([txtResRoom isFirstResponder])
        [txtResRoom resignFirstResponder];
    
    if ([txtResDate isFirstResponder])
        [txtResDate resignFirstResponder];
    
    // ensure valid romm is specified
    NSString *theRoom = txtResRoom.text;
    if ((theRoom == nil) || ([theRoom length] == 0))
    {
        UIAlertView* errorMessage = [[UIAlertView alloc] initWithTitle:nil
                                                               message:@"Room not specified"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [errorMessage show];
        
        return;
    }
    
    // ensure valid date is specified
    NSString *theDate = txtResDate.text;
    if ((theDate == nil) || ([theDate length] == 0))
    {
        UIAlertView* errorMessage = [[UIAlertView alloc] initWithTitle:nil
                                                               message:@"Date not specified"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [errorMessage show];
        
        return;
    }
    
    MeetingRoom *myMeetingRoom = [[MeetingRoom alloc] init];
    PhoneBook *myPhoneBook = [[PhoneBook alloc] init];
    
    NSArray *myArray2 = [myMeetingRoom getRoomSched:theRoom ReservedDate:theDate];
    
    NSInteger xrows = myArray2.count;
    
    // Display return value to screen
    if (xrows > 0)
    {
        NSString *tmpStartTime = nil;
        NSString *tmpEndTime = nil;
        NSString *tmpResPerson = nil;
        NSString *tmpResPurpose = nil;
        NSString *tmpPerson = nil;
        NSString *tmpExtNo = nil;
        
        tmpStartTime = [[myArray2 objectAtIndex:0] objectForKey: @"StartTime"];
        tmpEndTime = [[myArray2 objectAtIndex:0] objectForKey: @"EndTime"];
        tmpResPerson = [[myArray2 objectAtIndex:0] objectForKey: @"ResPerson"];
        tmpResPurpose = [[myArray2 objectAtIndex:0] objectForKey: @"Purpose"];
        
        NSArray *myArray = [myPhoneBook getReservedFor:(tmpResPerson)];
        NSString *tmpP1 = [myArray objectAtIndex:0];
        NSString *tmpP2 = [myArray objectAtIndex:1];
        NSMutableString *tmptxtRow1 = [[NSMutableString alloc] initWithString:@""];
        [tmptxtRow1 appendString:tmpStartTime];
        [tmptxtRow1 appendString:@" - "];
        [tmptxtRow1 appendString:tmpEndTime];
        [tmptxtRow1 appendString:@"     "];
        [tmptxtRow1 appendString:tmpP1];
        [tmptxtRow1 appendString:@"     "];
        [tmptxtRow1 appendString:tmpP2];
        [tmptxtRow1 appendString:@"     "];
        [tmptxtRow1 appendString:tmpResPurpose];
        
        txtRow1.text = tmptxtRow1;
        tmpStartTime = nil;
        tmpEndTime = nil;
        tmpResPerson = nil;
        tmpResPurpose = nil;
        tmpPerson = nil;
        tmpExtNo = nil;
        xrows--;
        if (xrows>0)
        {
            tmpStartTime = [[myArray2 objectAtIndex:1] objectForKey: @"StartTime"];
            tmpEndTime = [[myArray2 objectAtIndex:1] objectForKey: @"EndTime"];
            tmpResPerson = [[myArray2 objectAtIndex:1] objectForKey: @"ResPerson"];
            tmpResPurpose = [[myArray2 objectAtIndex:1] objectForKey: @"Purpose"];
            
            NSArray *myArray = [myPhoneBook getReservedFor:(tmpResPerson)];
            NSString *tmpP1 = [myArray objectAtIndex:0];
            NSString *tmpP2 = [myArray objectAtIndex:1];
            NSMutableString *tmptxtRow2 = [[NSMutableString alloc] initWithString:@""];
            [tmptxtRow2 appendString:tmpStartTime];
            [tmptxtRow2 appendString:@" - "];
            [tmptxtRow2 appendString:tmpEndTime];
            [tmptxtRow2 appendString:@"     "];
            [tmptxtRow2 appendString:tmpP1];
            [tmptxtRow2 appendString:@"     "];
            [tmptxtRow2 appendString:tmpP2];
            [tmptxtRow2 appendString:@"     "];
            [tmptxtRow2 appendString:tmpResPurpose];
            
            txtRow2.text = tmptxtRow2;
            tmpStartTime = nil;
            tmpEndTime = nil;
            tmpResPerson = nil;
            tmpResPurpose = nil;
            xrows--;
        }
        if (xrows>0)
        {
            tmpStartTime = [[myArray2 objectAtIndex:2] objectForKey: @"StartTime"];
            tmpEndTime = [[myArray2 objectAtIndex:2] objectForKey: @"EndTime"];
            tmpResPerson = [[myArray2 objectAtIndex:2] objectForKey: @"ResPerson"];
            tmpResPurpose = [[myArray2 objectAtIndex:2] objectForKey: @"Purpose"];
            
            NSArray *myArray = [myPhoneBook getReservedFor:(tmpResPerson)];
            NSString *tmpP1 = [myArray objectAtIndex:0];
            NSString *tmpP2 = [myArray objectAtIndex:1];
            NSMutableString *tmptxtRow3 = [[NSMutableString alloc] initWithString:@""];
            [tmptxtRow3 appendString:tmpStartTime];
            [tmptxtRow3 appendString:@" - "];
            [tmptxtRow3 appendString:tmpEndTime];
            [tmptxtRow3 appendString:@"     "];
            [tmptxtRow3 appendString:tmpP1];
            [tmptxtRow3 appendString:@"     "];
            [tmptxtRow3 appendString:tmpP2];
            [tmptxtRow3 appendString:@"     "];
            [tmptxtRow3 appendString:tmpResPurpose];

            txtRow3.text = tmptxtRow3;
            tmpStartTime = nil;
            tmpEndTime = nil;
            tmpResPerson = nil;
            tmpResPurpose = nil;
            xrows--;
        }
        if (xrows>0)
        {
            tmpStartTime = [[myArray2 objectAtIndex:3] objectForKey: @"StartTime"];
            tmpEndTime = [[myArray2 objectAtIndex:3] objectForKey: @"EndTime"];
            tmpResPerson = [[myArray2 objectAtIndex:3] objectForKey: @"ResPerson"];
            tmpResPurpose = [[myArray2 objectAtIndex:3] objectForKey: @"Purpose"];
            
            NSArray *myArray = [myPhoneBook getReservedFor:(tmpResPerson)];
            NSString *tmpP1 = [myArray objectAtIndex:0];
            NSString *tmpP2 = [myArray objectAtIndex:1];
            NSMutableString *tmptxtRow4 = [[NSMutableString alloc] initWithString:@""];
            [tmptxtRow4 appendString:tmpStartTime];
            [tmptxtRow4 appendString:@" - "];
            [tmptxtRow4 appendString:tmpEndTime];
            [tmptxtRow4 appendString:@"     "];
            [tmptxtRow4 appendString:tmpP1];
            [tmptxtRow4 appendString:@"     "];
            [tmptxtRow4 appendString:tmpP2];
            [tmptxtRow4 appendString:@"     "];
            [tmptxtRow4 appendString:tmpResPurpose];
            
            txtRow4.text = tmptxtRow4;
            tmpStartTime = nil;
            tmpEndTime = nil;
            tmpResPerson = nil;
            tmpResPurpose = nil;
            xrows--;
        }
        
        if (xrows>0)
        {
            tmpStartTime = [[myArray2 objectAtIndex:4] objectForKey: @"StartTime"];
            tmpEndTime = [[myArray2 objectAtIndex:4] objectForKey: @"EndTime"];
            tmpResPerson = [[myArray2 objectAtIndex:4] objectForKey: @"ResPerson"];
            tmpResPurpose = [[myArray2 objectAtIndex:4] objectForKey: @"Purpose"];
            
            NSArray *myArray = [myPhoneBook getReservedFor:(tmpResPerson)];
            NSString *tmpP1 = [myArray objectAtIndex:0];
            NSString *tmpP2 = [myArray objectAtIndex:1];
            NSMutableString *tmptxtRow5 = [[NSMutableString alloc] initWithString:@""];
            [tmptxtRow5 appendString:tmpStartTime];
            [tmptxtRow5 appendString:@" - "];
            [tmptxtRow5 appendString:tmpEndTime];
            [tmptxtRow5 appendString:@"     "];
            [tmptxtRow5 appendString:tmpP1];
            [tmptxtRow5 appendString:@"     "];
            [tmptxtRow5 appendString:tmpP2];
            [tmptxtRow5 appendString:@"     "];
            [tmptxtRow5 appendString:tmpResPurpose];
            
            txtRow5.text = tmptxtRow5;
            tmpStartTime = nil;
            tmpEndTime = nil;
            tmpResPerson = nil;
            tmpResPurpose = nil;
            xrows--;
        }
        
        
    }
    
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    self.txtResDate.text = [self.dateFormatter stringFromDate:date];
    //lblDate.text=[self.dateFormatter stringFromDate:date];
    //txtResDate.text = [self.dateFormatter stringFromDate:date];
    NSLog(@"User select date %@", date);
    [self.calendar removeFromSuperview];
}

- (BOOL)calendar:(CKCalendarView *)calendar willDeselectDate:(NSDate *)date; {
    NSLog(@"User deselect date %@", date);
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didDeselectDate:(NSDate *)date; {
    NSLog(@"User did select date %@", date);
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date; {
    NSLog(@"User did change month %@", date);
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

@end
