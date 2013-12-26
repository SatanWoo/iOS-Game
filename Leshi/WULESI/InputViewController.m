//
//  InputViewController.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-12.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "AppDelegate.h"
#import "InputViewController.h"
#import <CoreData/CoreData.h>
#import "Macro.h"
#import "Numbers.h"

@interface InputViewController ()

@end

@implementation InputViewController
@synthesize context = _context;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _textField.text = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppController *appDelegate =(AppController*)[[UIApplication sharedApplication] delegate];
    _context = [appDelegate managedObjectContext];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _textField = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    _textField.text = @"";
}

- (void)dealloc
{
    [_textField release],_textField = nil;
    [super dealloc];
}

- (IBAction)confirm:(id)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:REMOVEINPUTCONTROLLER object:nil userInfo:[NSDictionary dictionaryWithObject:_textField.text forKey:INPUTCONTENT]];
    if([self checkValid]){
        Numbers *numbers = [NSEntityDescription
                            insertNewObjectForEntityForName:@"PhoneNumber" 
                            inManagedObjectContext:_context];
        numbers.number = _textField.text;
        numbers.time = [NSDate date];
        NSError *error;
        if (![_context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        // Test listing all FailedBankInfos from the store
        /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"PhoneNumber" 
                                                  inManagedObjectContext:_context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
        for (Numbers *number in fetchedObjects) {
            NSLog(@"Number: %@", number.number);
            NSLog(@"Date: %@", number.time);
        }        
        [fetchRequest release];*/
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REMOVEINPUTCONTROLLER object:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"出错啦!"
                              message:@"输入的手机号码位数不正确"
                              delegate:nil
                              cancelButtonTitle:@"重新输入"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)reinput:(id)sender
{
    [_textField setText:@""];
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSString *string = [[sender titleLabel] text];
    [_textField setText:[_textField.text stringByAppendingString:string]];
}

- (BOOL)checkValid{
    if ([_textField.text length] == 11) {
        return true;
    }else return false;
}

@end
