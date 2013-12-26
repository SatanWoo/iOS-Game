//
//  MenuScence.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "MenuScence.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "MusicCenter.h"
#import "SysConf.h"

@implementation MenuScence

-(id)init
{
    self = [super init];
    if(self)
    {   
        [self LoadImage];
        [self LoadMenu];
        [self InitPopLayer];
        [MusicCenter playModeBackgroundMusic:menuMain];
    }
    return self;
}


-(void)LoadImage
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_ch_mi_bk.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage z:0];
    
    _goSticker = [TigerCoinGo sharedAnimation];
    [self addChild:_goSticker z:0];

    _arrow = [Arrow node];
    [_arrow ActionBegin];
    [self addChild:_arrow z:0];
    
    _snowLayer = [SnowLayer node];
    [self addChild:_snowLayer z:0];
}

-(void)LoadMenu
{
    CCMenuItem* settingItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_setup.png")] 
                                                      selectedSprite:nil target:self 
                                                            selector:@selector(DisplayMenu)];
    CCMenu* cSettingMenu = [CCMenu menuWithItems:settingItem,nil];
    cSettingMenu.position = ccp(35,35);
    [self addChild:cSettingMenu z:1];
}

-(void)InitPopLayer
{
    control = [CCLayer node];
    soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(SwitchMusic)
                                                               items:
                                     [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_voiceoff.png")] 
                                                                    selectedSprite:nil],
                                     [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_voiceon.png")] 
                                                             selectedSprite:nil],
                                     nil];
    [soundToggle setSelectedIndex:[SysConf IsBkMusic]];
    CCMenu* cSoundMenu=[CCMenu menuWithItems:soundToggle, nil];
    cSoundMenu.position=ccp(35,118);
    [control addChild:cSoundMenu z:1 tag:1];
    
    
    CCMenuItem* infoItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_i.png")] 
                                                   selectedSprite:nil target:self 
                                                         selector:@selector(ShowInfo)];
    CCMenu* cInfoMenu = [CCMenu menuWithItems:infoItem,nil];
    cInfoMenu.position = ccp(35,81);
    [control addChild:cInfoMenu z:1 tag:2];
    
    
    CCMenuItem* sinaItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_sweibo.png")] 
                                                   selectedSprite:nil target:self
                                                         selector:@selector(OpenWeibo)];
    CCMenu* cSinaMenu = [CCMenu menuWithItems:sinaItem,nil];
    cSinaMenu.position = ccp(81,35);
    [control addChild:cSinaMenu z:1 tag:3];
    
    CCMenuItem* crownItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_mi_button_paiming.png")] 
                                                    selectedSprite:nil target:self 
                                                          selector:nil];
    CCMenu* cCrownMenu = [CCMenu menuWithItems:crownItem,nil];
    cCrownMenu.position = ccp(118,35);
    [control addChild:cCrownMenu z:1 tag:4];
    
    CCSprite * verticalBar = [CCSprite spriteWithFile:OC("tc_mi_button_shanghuatiao.png")];
    verticalBar.position = ccp(35,95);
    [control addChild:verticalBar z:0 tag:5];
    
    CCSprite * horizontalBar = [CCSprite spriteWithFile:OC("tc_mi_button_cehuatiao.png")];
    horizontalBar.position = ccp(94,35);
    [control addChild:horizontalBar z:0 tag:6];        
    control.visible = false;
    isPop = true;
    [self addChild:control];
}

-(void)DisplayMenu
{
    [MusicCenter playSoundEffect:leftButton];
    control.visible = isPop;
    isPop ^= 1;
}

-(void)SwitchMusic
{
    [SysConf SetBkMusic:![SysConf IsBkMusic]];
    if ([SysConf IsBkMusic]){
        [MusicCenter playBackgroundMusic];
        [SysConf SetSoundEffect:true];
    }
    else{
        [MusicCenter stopBackgroundMusic];
        [SysConf SetSoundEffect:false];
    }
    [MusicCenter playSoundEffect:leftButton];
    [soundToggle setSelectedIndex:[SysConf IsBkMusic]];
}

-(void)ShowInfo
{
    [MusicCenter playSoundEffect:leftButton];
    AboutLayer * _aboutLayer = [AboutLayer node];
    [self addChild:_aboutLayer z:2];
}

-(void)OpenWeibo
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/teamtig"]]; 
}

- (void) dealloc{
    [super dealloc];
}

@end
