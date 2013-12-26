//
//  OptionLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "OptionLayer.h"
#import "GameConfig.h"
#import "SaveSetting.h"


@implementation OptionLayer

-(id)init
{
    self =[super init];
    if (self) {
        CCSprite* optionBackground=[CCSprite spriteWithFile:@"optionBackground.png" rect:CGRectMake(0,0,74,219)];
        optionBackground.position=ccp(ipadWidth/2+280,220);
        [self addChild:optionBackground z:0 tag:1 ];
        [self addButton];
    }
    return self;
}

-(void)addButton
{
    CCSprite* musicSprite=[CCSprite spriteWithFile:@"music.png" rect:CGRectMake(0,0,63,63)];
    CCSprite* musicNoSprite=[CCSprite spriteWithFile:@"musicNo.png" rect:CGRectMake(0,0, 66,65)];
    /*musicSprite.position=ccp(ipadWidth/2+280,240);
    [self addChild:musicSprite z:1];*/
    
    CCMenuItemToggle* musicToggle=[CCMenuItemToggle itemWithTarget:self selector:@selector(saveMusic:) items:[CCMenuItemSprite itemFromNormalSprite:musicSprite selectedSprite:nil],[CCMenuItemSprite itemFromNormalSprite:musicNoSprite selectedSprite:nil],nil];
    [musicToggle setSelectedIndex:[SaveSetting getMusic]];
	CCMenu* musicMenu=[CCMenu menuWithItems:musicToggle, nil];
    musicMenu.position=ccp(ipadWidth/2+280,320);
    [self addChild:musicMenu z:1 tag:2];
    //CCSprite* soundSprite=[CCSprite spriteWithFile:@"sound.png" rect:CGRectMake(0,0,63,63)];
    /*soundSprite.position=ccp(musicSprite.position.x,musicSprite.position.y-70);
    [self addChild:soundSprite z:1];*/
}

-(void)saveMusic:(id)sender
{
    if ([sender selectedIndex]==0) {
        [SaveSetting saveMusic:0];
    }
    else
    {
        [SaveSetting saveMusic:1];
    }
}

-(void)saveSound:(id)sender
{
    if ([sender selectedIndex]==0) {
        [SaveSetting saveSound:0];
    }
    else
    {
        [SaveSetting saveSound:1];
    }
}

-(void)dealloc
{
    [self removeChildByTag:1 cleanup:YES];
    [self removeChildByTag:2 cleanup:YES];
    [super dealloc];
}

@end
