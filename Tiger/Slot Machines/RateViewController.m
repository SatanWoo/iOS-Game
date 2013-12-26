//
//  RateViewController.m
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-3-1.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "RateViewController.h"

@implementation RateViewController
@synthesize rateName;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.rateName = nil;
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.rateName isEqualToString:@"rateFruit"]) {
        _fruitView.frame = self.view.bounds;
        [self.view addSubview:_fruitView];
    } else if ([self.rateName isEqualToString:@"rateFood"]) {
        _foodView.frame = self.view.bounds;
        [self.view addSubview:_foodView];
    } else {
        _partyView.frame = self.view.bounds;
        [self.view addSubview:_partyView];
    }
                                            
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBAction

- (IBAction)closeView:(id)sender
{
    [self.view removeFromSuperview];
    [self.delegate dismissRateViewController];
}
@end
