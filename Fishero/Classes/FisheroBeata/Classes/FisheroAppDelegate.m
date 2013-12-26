//
//  FisheroAppDelegate.m
//  Fishero
//
//  Created by  appleclub on 11-3-6.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

#import "FisheroAppDelegate.h"
#import "GameConfig.h"
#import "MenuLayer.h"
#import "RootViewController.h"
#import "SceneManager.h"
#import "MusicHandle.h"
#import "saveData.h"
#import "SaveSetting.h"

@implementation FisheroAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0	
                        ];
    
    [glView setMultipleTouchEnabled:YES];
    // attach the openglView to the director
	[director setOpenGLView:glView];
	
	// To enable Hi-Red mode (iPhone4)
	//	[director setContentScaleFactor:2];
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	//[director setDisplayFPS:YES];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	NSNumber* pointDefault=[NSNumber numberWithInt:0];
	NSNumber* musicDefault=[NSNumber numberWithInt:0];
	NSNumber* sizeDefault=[NSNumber numberWithFloat:0.3];
	NSNumber* powerDefault=[NSNumber numberWithInt:1];
	NSNumber* shelterDefault=[NSNumber numberWithInt:0];
	
	NSArray * miniDefault=[NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil];
	NSData* data=[NSKeyedArchiver archivedDataWithRootObject:miniDefault];
	
	NSArray * costDefault=[NSArray arrayWithObjects:[NSNumber numberWithInt:300],[NSNumber numberWithInt:600],[NSNumber numberWithInt:100],nil];
	NSData* dataTwo=[NSKeyedArchiver archivedDataWithRootObject:costDefault];
	
	NSArray *arrayAll=[NSArray arrayWithObjects:pointDefault,musicDefault,sizeDefault,powerDefault,shelterDefault,data,dataTwo,nil];
	NSArray *keyArray=[NSArray arrayWithObjects:scoreKey,musicKey,sizeKey,powerKey,shelterKey,miniKey,costKey,nil];
	NSDictionary *registrationDefaults = [NSDictionary dictionaryWithObjects:arrayAll
                                                                     forKeys:keyArray]; 
    [[NSUserDefaults standardUserDefaults] registerDefaults: registrationDefaults];
	
	
	// Run the intro Scene
	//[[CCDirector sharedDirector] runWithScene: [HelloWorld scene]];
	[MusicHandle preload];
    [SceneManager goMenu];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
