//
//  LotteryViewController.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-14.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "LotteryViewController.h"
#import <CoreData/CoreData.h>
#import "Macro.h"
#import "Numbers.h"
#import "CongratulationViewController.h"

@interface LotteryViewController ()

@end

@implementation LotteryViewController

@synthesize context = _context;

#pragma mark - Private Method
- (void)timerFireMethod:(NSTimer*)theTimer
{
    int a = 100000000;
    int b = 999999999;
    int randomNumber = (rand() % (b-a+1))+ a;
    int tmp = rand() % 3;
    if (tmp == 0) {
        [_textLabel setText:[NSString stringWithFormat:@"15%d",randomNumber]];
    }else if (tmp == 1) {
        [_textLabel setText:[NSString stringWithFormat:@"18%d",randomNumber]];
    }else {
        [_textLabel setText:[NSString stringWithFormat:@"13%d",randomNumber]];
    }
}

#pragma mark - Public Method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_textLabel setText:@""];
    _timer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
	return YES;
}

- (void)dealloc
{
    [_timer release],_timer = nil;
    [super dealloc];
}

- (IBAction)startLottery:(id)sender
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.0f
                                               target:self 
                                            selector:@selector(timerFireMethod:) 
                                             userInfo:nil 
                                                 repeats:YES];
    }
    [_timer fire];
}

- (IBAction)stopLottery:(id)sender
{
    [_timer invalidate];
   
    if (_vc == nil) {
        _vc = [[CongratulationViewController alloc] init];
    }
    [self.view addSubview:_vc.view];

}
@end
