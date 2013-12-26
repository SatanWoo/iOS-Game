//
//  CongratulationViewController.m
//  WULESI
//
//  Created by M.K.Rain on 12-6-2.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "CongratulationViewController.h"
#import <CoreData/CoreData.h>
#import "Macro.h"
#import "Numbers.h"
#import "MusicHandle.h"
#import "AppDelegate.h"

@interface CongratulationViewController ()

@end

@implementation CongratulationViewController

@synthesize context = _context;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backToMenu:(id)sender
{
    [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:REMOVELOTTERYCONTROLLER object:nil userInfo:nil];
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    AppController *appDelegate =(AppController*)[[UIApplication sharedApplication] delegate];
    _context = [appDelegate managedObjectContext];NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PhoneNumber" 
                                              inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    int randomNumber  = rand()%[fetchedObjects count];
    Numbers *number = [fetchedObjects objectAtIndex:randomNumber];
    NSDate *date = number.time;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日 hh:mm aaa"];
    
    [self updateNumber:number.number time:[dateFormat stringFromDate:date]];
    [fetchRequest release];
    [_context deleteObject:number];
    [MusicHandle notifyCongratulation];
}

- (void)viewWillAppear:(BOOL)animated{
    AppController *appDelegate =(AppController*)[[UIApplication sharedApplication] delegate];
    _context = [appDelegate managedObjectContext];NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PhoneNumber" 
                                              inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
    int randomNumber  = rand()%[fetchedObjects count];
    Numbers *number = [fetchedObjects objectAtIndex:randomNumber];
    NSDate *date = number.time;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日 hh:mm aaa"];
    
    [self updateNumber:number.number time:[dateFormat stringFromDate:date]];
    [fetchRequest release];
    [_context deleteObject:number];
    [MusicHandle notifyCongratulation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateNumber:(NSString *)number time:(NSString *)date{
    _phoneNumber.text = number;
    _date.text = date;
}

- (void)dealloc
{
    [_context release],_context = nil;
    _phoneNumber = nil;
    _date = nil;
    [super dealloc];
}


@end
