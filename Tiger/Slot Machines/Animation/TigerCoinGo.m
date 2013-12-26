//
//  TigerCoinGo.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "TigerCoinGo.h"
#import "SceneManager.h"
#import "MusicCenter.h"

#define LOGO_X 225
#define LOGO_Y 188

#define StickerPointX 395
#define StickerPointY 125 

#define GO_LEFT 371
#define GO_RIGHT 424
#define GO_TOP 197
#define GO_BOTTOM 144

#define LEFT_EYE_X 295
#define LEFT_EYE_Y 210
#define RIGHT_EYE_X 330
#define RIGHT_EYE_Y 200



@implementation TigerCoinGo

static TigerCoinGo *_sharedAnimation = nil;

+ (TigerCoinGo *)sharedAnimation
{
	if (!_sharedAnimation) {
        _sharedAnimation = [[self alloc] init];
	}
	return _sharedAnimation;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        [self InitGoSticker];       
        [self InitLogo];
        [self InitEyes];
    }
    return self;
}

-(void)InitEyes
{
    leftEye = [CCSprite spriteWithFile:OC("tc_tiger_eye.png")];
    rightEye = [CCSprite spriteWithFile:OC("tc_tiger_eye.png")];
    leftEye.scale = 1.5;
    rightEye.scale = 1.5;
    leftEye.position = ccp(LEFT_EYE_X, LEFT_EYE_Y);
    rightEye.position = ccp(RIGHT_EYE_X, RIGHT_EYE_Y);
    [self addChild:leftEye];
    [self addChild:rightEye];    
}

-(void)InitLogo
{
    logoImage = [CCSprite spriteWithFile:OC("tc_ch_mi_logo.png")];
    logoImage.position = ccp(LOGO_X, LOGO_Y);
    [self addChild:logoImage z:0];

}

-(void)InitGoSticker
{
    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("tc_ani_golagan.plist")];
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:OC("tc_ani_golagan.png")];
    [self addChild:_spriteSheet z:0];
    _image = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_golagan_001.png")];
    _image.position = ccp(StickerPointX,StickerPointY);
    [_spriteSheet addChild:_image];     
}

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    isOn = false;
    touchBegin = [touch locationInView:[touch view]];
	touchBegin = [[CCDirector sharedDirector] convertToGL:touchBegin];
    isOn = (GO_LEFT <= touchBegin.x && touchBegin.x <= GO_RIGHT && GO_BOTTOM <= touchBegin.y && touchBegin.y <= GO_TOP);
    if(isOn){
        [MusicCenter playSoundEffect:lagan];
    }
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!isOn) return;
    touchMove = [touch locationInView:[touch view]];
	touchMove = [[CCDirector sharedDirector] convertToGL:touchMove];
    nowPage = (int)((touchBegin.y - touchMove.y) / 4);
    nowPage = MAX(nowPage, 1);
    nowPage = MIN(nowPage, 30);
    leftEye.position = ccp(LEFT_EYE_X, LEFT_EYE_Y - nowPage / 10);
    rightEye.position = ccp(RIGHT_EYE_X, RIGHT_EYE_Y - nowPage / 10);
    [_spriteSheet removeChild:_image cleanup:YES];
    _image = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:OC("tc_ani_golagan_%03d.png"), nowPage]];
    _image.position = ccp(StickerPointX,StickerPointY);    
    [_spriteSheet addChild:_image];
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!isOn) return;
    leftEye.position = ccp(LEFT_EYE_X, LEFT_EYE_Y);
    rightEye.position = ccp(RIGHT_EYE_X, RIGHT_EYE_Y);
    if(nowPage <= 1) return;
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = nowPage - 1; i >= 1; --i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:OC("tc_ani_golagan_%03d.png"), i]]];
    }
    
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:0.005f];  
    CCAction *action = [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO];    
    [_image runAction:action];    
    if(25 <= nowPage && nowPage <= 30){
        [SceneManager GoSelectMode];
        return;
    }
    
}


- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

-(void)dealloc
{
    [super dealloc];
}

@end
