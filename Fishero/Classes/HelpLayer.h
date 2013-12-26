//
//  HelpLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-15.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "GameConfig.h"

@interface HelpLayer : CCLayer {
	
	int scrollHeight;
	int scrollWidth;
	
		// Holds the height and width of the screen when the class was inited
	int startHeight;
	int startWidth;
	
		// Holds the current page being displayed
	int currentScreen;
	
		// A count of the total screens available
	int totalScreens;
	
		// The initial point the user starts their swipe
	int startSwipe;
	
	NSMutableArray* savePictures;
	
	CCSprite* backMenu;
	
	CCSprite* pointArray[6];
	CCSprite* pointSelect;

}
@property(nonatomic,retain)NSMutableArray* savePictures;
-(id)addPicturesForScrolling:(NSMutableArray*)layers;
-(void) moveToPage:(int)page;
-(void) moveToNextPage;
-(void) moveToPreviousPage;
	//-(void)initPoint;
-(void)initButton;
-(void)initShowPoint;

@end
