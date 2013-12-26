    //
	//  RootViewController.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 10-11-15.
	//  Copyright 2010 同济大学. All rights reserved.
	//

#import "RootViewController.h"
#import "cocos2d.h"




@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


	// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
}



	// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

	/*if( interfaceOrientation == UIInterfaceOrientationLandscapeLeft ) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeRight];
	} else if( interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	}
	
	return NO;*/
	
	if( interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight )
		return YES;
	
		// Unsupported orientations:
		// UIInterfaceOrientationPortrait, UIInterfaceOrientationPortraitUpsideDown
	return NO;
	
	
	
		// Shold not happen
	return NO;
}
 
 //
 // This callback only will be called when GAME_AUTOROTATION == kGameAutorotationUIViewController
 //
 -(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
 {
 //
 // Assuming that the main window has the size of the screen
 // BUG: This won't work if the EAGLView is not fullscreen
 ///
 CGRect screenRect = [[UIScreen mainScreen] bounds];
 CGRect rect;
 
 if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)		
 rect = screenRect;
 
 else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
 rect.size = CGSizeMake( screenRect.size.height, screenRect.size.width );
 
 CCDirector *director = [CCDirector sharedDirector];
 EAGLView *glView = [director openGLView];
 float contentScaleFactor = [director contentScaleFactor];
 
 if( contentScaleFactor != 1 ) {
 rect.size.width *= contentScaleFactor;
 rect.size.height *= contentScaleFactor;
 }
 glView.frame = rect;
 }


- (void)didReceiveMemoryWarning {
		// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
		// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
		// Release any retained subviews of the main view.
		// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[super dealloc];
}



@end


