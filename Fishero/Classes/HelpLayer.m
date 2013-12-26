//
//  HelpLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-15.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "HelpLayer.h"


@implementation HelpLayer

@synthesize savePictures;

-(id)init
{
	self = [super init];
	if (self) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];//允许触控
																									  //self.isTouchEnabled=YES;
		CCSprite* spriteOne=[CCSprite spriteWithFile:@"help_1.png" rect:CGRectMake(0, 0, 1024, 768)];
		CCSprite* spriteTwo=[CCSprite spriteWithFile:@"help_2.png" rect:CGRectMake(0, 0, 1024, 768)];
		CCSprite* spriteThree=[CCSprite spriteWithFile:@"help_3.png" rect:CGRectMake(0, 0, 1024, 768)];
		CCSprite* spriteFour=[CCSprite spriteWithFile:@"help_4.png" rect:CGRectMake(0, 0, 1024, 768)];
		
		savePictures=[NSMutableArray arrayWithObjects:spriteOne,spriteTwo,spriteThree,spriteFour,nil];
		
		self =[self addPicturesForScrolling:savePictures];
		[self initButton];
		[self initShowPoint];
			//currentScreen=1;
	}
	return self;
}

-(void)initButton
{
	CCSprite* menuPicture=[CCSprite spriteWithFile:@"back.png" ];
	
	CCMenuItem* backButton =[CCMenuItemSprite itemFromNormalSprite:menuPicture selectedSprite:nil target:self selector:@selector(back)];
	backMenu=[CCMenu menuWithItems:backButton,nil];
	backMenu.position=ccp(100,50);
	[self addChild:backMenu z:1 tag:99];
}

-(void)initShowPoint
{
	for (int i=0; i<4;i++) {
		pointArray[i]=[CCSprite spriteWithFile:@"diandefault.png" rect:CGRectMake(0, 0, 50, 50)];
		pointArray[i].position=ccp(i*100+300,25);
		[self addChild:pointArray[i] z:2 tag:70];
	}
	pointSelect=[CCSprite spriteWithFile:@"dianselect.png" rect:CGRectMake(0, 0, 50, 50)];
	pointSelect.position=ccp(pointArray[0].position.x,pointArray[0].position.y);
	[self addChild:pointSelect z:2 tag:60];
}


-(id)addPicturesForScrolling:(NSMutableArray *)layers
{
	currentScreen = 1;
	scrollWidth = [[CCDirector sharedDirector] winSize].width;
	scrollHeight = [[CCDirector sharedDirector] winSize].height;
	startWidth = scrollWidth;
	startHeight = scrollHeight;
		// Loop through the array and add the screens
	int i = 0;
	for (CCSprite *l in layers)
	{
			//
			//l.anchorPoint = ccp(0,0);
		l.position = ccp((i*scrollWidth+scrollWidth/2),scrollHeight/2);
		[self addChild:l ];
		i=i+1;
	}
		// Setup a count of the available screens
	totalScreens = i;
	return self;
	
}

-(void) moveToPage:(int)page
{
	id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.1 position:ccp(-((page-1)*scrollWidth),0)]];
	[self runAction:changePage];
	currentScreen = page;
	
}

-(void) moveToNextPage
{
	if (currentScreen<=totalScreens) {
		id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.1 position:ccp(-(((currentScreen+1)-1)*scrollWidth),0)]];
		[self runAction:changePage];
		currentScreen = currentScreen+1;
		backMenu.position=ccp(backMenu.position.x+ipadWidth,50);
		for(int i=0;i<4;i++)
			pointArray[i].position=ccp(pointArray[i].position.x+ipadWidth,25);
		pointSelect.position=ccp(pointSelect.position.x+ipadWidth,25);
		[pointSelect runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(pointArray[currentScreen-1].position.x,25)]];
		
	}
}

-(void) moveToPreviousPage
{
	
	if (currentScreen>1) {
		id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.1 position:ccp(-(((currentScreen-1)-1)*scrollWidth),0)]];
		[self runAction:changePage];
			//[self addChild:currentPictures];
		currentScreen = currentScreen-1;
		backMenu.position=ccp(backMenu.position.x-ipadWidth,50);
		for (int i=0; i<4; i++) {
			pointArray[i].position=ccp(pointArray[i].position.x-ipadWidth,25);
		}
		pointSelect.position=ccp(pointSelect.position.x-ipadWidth,25);
		[pointSelect runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(pointArray[currentScreen-1].position.x,25)]];
	}
	
}

-(void)back
{
	[SceneManager goMenu];
}

#pragma mark -
#pragma mark delegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	startSwipe = touchPoint.x;
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	self.position = ccp((-(currentScreen-1)*scrollWidth)+(touchPoint.x-startSwipe),0);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	int newX = touchPoint.x;
	
	if ((newX-startSwipe)<-100&&(currentScreen+1)<= totalScreens)
	{
		[self moveToNextPage];
	}
	else if((newX-startSwipe)>100&&(currentScreen-1)>0)
	{
		[self moveToPreviousPage];
	}
	else
	{
		[self moveToPage:currentScreen];
	}
}

-(void)dealloc
{
	[savePictures release];
	[super dealloc];
}
@end


@end
