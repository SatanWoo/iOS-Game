	//
	//  tapatAppDelegate.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 10-10-28.
	//  Copyright 同济大学 2010. All rights reserved.
	//

#import "cocos2d.h"

#import "tapatAppDelegate.h"
#import "GameConfig.h"
#import "loadingLayer.h"

@implementation tapatAppDelegate

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
   [viewController.view setMultipleTouchEnabled:YES];
	
		//
		// Create the EAGLView manually
		//  1. Create a RGB565 format. Alternative: RGBA8
		//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
		//
		//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
							preserveBackbuffer:NO];
	
		// attach the openglView to the director
	[director setOpenGLView:glView];
	
		// To enable Hi-Red mode (iPhone4)
		//	[director setContentScaleFactor:2];
	
		//
		// VERY IMPORTANT:
		// If the rotation is going to be controlled by a UIViewController
		// then the device orientation should be "Portrait".
		//
	/*#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeRight];
	#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
	#endif*/
	
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	
		//[director setAnimationInterval:1.0/60];
		//[director setDisplayFPS:YES];
	
	
		// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
		// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	window.rootViewController=viewController;
	

	
	[window makeKeyAndVisible];
	
		// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
		// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
		// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
		//[self gameCenterFunction];
	
	
		// Run the intro Scene
	
		////register defaults
	NSNumber *challengePointDefault = [NSNumber numberWithInt:0];
	NSNumber *backgroundDefault=[NSNumber numberWithInt:0];
	NSNumber *soundDefault=[NSNumber numberWithInt:0];
	NSNumber *musicDefault=[NSNumber numberWithInt:0];
	NSNumber *firstLevelDefault=[NSNumber numberWithInt:0];
	NSNumber *levelStart=[NSNumber numberWithInt:0];
	NSArray *arrayDefault=[NSArray arrayWithObjects:firstLevelDefault,firstLevelDefault,firstLevelDefault,firstLevelDefault,firstLevelDefault,firstLevelDefault,firstLevelDefault,firstLevelDefault,nil];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrayDefault];
	NSArray *arrayAll=[NSArray arrayWithObjects:challengePointDefault,backgroundDefault,soundDefault,musicDefault,data,levelStart,nil];
	NSArray *keyArray=[NSArray arrayWithObjects:saveChallengeKey,choiceBackgroundKey,soundPlayKey,musicPlayKey,saveAdvenKey,saveLevelKey,nil];
    NSDictionary *registrationDefaults = [NSDictionary dictionaryWithObjects:arrayAll
                                                                     forKeys:keyArray]; 
    [[NSUserDefaults standardUserDefaults] registerDefaults: registrationDefaults];
	
	[[CCDirector sharedDirector] runWithScene: [loadingLayer scene]];
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	
	
		
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
	//[SimpleAudioEngine end];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	[[CCDirector sharedDirector] release];
	
	[window release];
	[super dealloc];
}

- (void) orientationChanged:(NSNotification *)notification
{
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	if (orientation==UIInterfaceOrientationLandscapeLeft||orientation==UIInterfaceOrientationLandscapeRight) {
	}	
}
															


															
														





@end

