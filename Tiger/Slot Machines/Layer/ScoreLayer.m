//
//  ScoreLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreLayer.h"
#import "GameConfig.h"
#import "DataSys.h"
#import "MusicCenter.h"


@implementation ScoreLayer

-(id)init
{
    self = [super init];
    if(self){
        debtNum = winNum = 0;
        reDebt = true;
        [self InitCoinHeap];
        [self InitSlide];
        [self InitLabel];
        [self Refresh];
        [self schedule:@selector(MinusTime) interval:1.0f];
    }
    return self;
}

-(void)InitCoinHeap
{
    small = [CCSprite spriteWithFile:OC("tc_gi_single_pr_jinbi1_174 46.png")];
    small.position = ccp(89, 31);
    [self addChild:small];
    middle = [CCSprite spriteWithFile:OC("tc_gi_single_pr_jinbi2_167 67.png")];
    middle.position = ccp(89, 45);
    [self addChild:middle];
    large = [CCSprite spriteWithFile:OC("tc_gi_single_pr_jinbi3_182 208.png")];
    large.position = ccp(85, 57);
    [self addChild:large];
    small.visible = middle.visible = large.visible = false;
    
}

-(void)SetDrawer:(NSString *)name
{
    CCSprite * drawer = [CCSprite spriteWithFile:name];
    drawer.position = ccp(89,16);
    [self addChild:drawer z:1];
}

-(void)InitSlide
{
    
    //slide background
    CCSprite * slide1 = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiaodise.png")];
    slide1.position = ccp(172, 305);
    [self addChild:slide1];
    
    CCSprite * slide2 = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiaodise.png")];
    slide2.position = ccp(305, 305);
    [self addChild:slide2];
    
    itemL = [CCSprite spriteWithFile:OC("tc_gi_single_pr_lv_57 57.png")];
    itemL.position = ccp(115, 305);
    [self addChild:itemL];
    itemR = [CCSprite spriteWithFile:OC("tc_gi_single_pr_lingdangup_57 57.png")];
    itemR.position = ccp(363, 305);
    [self addChild:itemR];
    
    //exp slide up
    expSpl = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao3.png")];
    expSpl.position = ccp(134, 305);
    [self addChild:expSpl];    
    
    expSpr = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao1.png")];
    expSpr.position = ccp(211, 305);
    [self addChild:expSpr];
    
    for(int i = 0; i < 72; i++)
    {
        expSp[i] = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao2.png")];
        expSp[i].position = ccp(208 - i, 305);
        [self addChild:expSp[i]];
    }
    
    //eng slide up
    engSpl = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao3.png")];
    engSpl.position = ccp(266, 305);
    [self addChild:engSpl];
    for(int i = 0; i < 72; i++)
    {
        engSp[i] = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao2.png")];
        engSp[i].position = ccp(269 + i, 305);
        [self addChild:engSp[i]];
    }
    engSpr = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiao1.png")];
    engSpr.position = ccp(344, 305);
    [self addChild:engSpr];
}

-(void)InitLabel
{
    scoreNum = [DataSys GetScore];
    scoreLabel = [CCLabelTTF labelWithString: [NSString stringWithFormat:OC("%07d "), scoreNum]
                               fontName:OC("lcdd.ttf") fontSize:12];
    scoreLabel.position = ccp(150, 273);
    [scoreLabel setColor:ccYELLOW];
    [self addChild:scoreLabel];

    winLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:OC("%04d "), winNum] 
                             fontName:OC("lcdd.ttf") fontSize:12];
    winLabel.position = ccp(320, 273);
    [winLabel setColor:ccYELLOW];
    [self addChild:winLabel];

    debtLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:OC("%03d "), debtNum]
                              fontName:OC("lcdd.ttf") fontSize:12];
    debtLabel.position = ccp(367, 273);
    [debtLabel setColor:ccYELLOW];
    [self addChild:debtLabel];
    
    levelLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:OC("%d"),[DataSys GetLevel]]
                                    fontName:OC("DFPSHAONVW5-GB.TTF") fontSize:15];
    levelLabel.position = ccp(170, 304);
    ccColor3B ccColor = {71,118,148};
    [levelLabel setColor:ccColor];
    [self addChild:levelLabel];
    
    coundDownTime = 60;
    downLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:OC("%02d "),coundDownTime]
                                    fontName:OC("lcdd.ttf") fontSize:15];
    downLabel.position = ccp(70, 17);
    [downLabel setColor:ccYELLOW];
    [self addChild:downLabel z:2] ;

    coinShow = [CCSprite spriteWithFile:OC("tc_loading_coin.png")];
    coinShow.scale = 0.3;
    [coinShow runAction:[CCFadeOut actionWithDuration:0.0]];
    [self addChild:coinShow];
}

-(void)MinusTime
{
    coundDownTime--; 
    if(coundDownTime == -1) coundDownTime = 60;
    [downLabel setString:[NSString stringWithFormat:OC("%02d "), coundDownTime]];
    if (coundDownTime == 0 && [DataSys GetScore] < 200) {
        CCSequence * action = [CCSequence actions:
                               [CCFadeIn actionWithDuration:0.0f],
                               [CCMoveTo actionWithDuration:0.0f position:ccp(450, 50)],
                               [CCJumpTo actionWithDuration:2.0f position:ccp(70, 55) height:20 jumps:4],
                               [CCFadeOut actionWithDuration:0.0f],
                               nil];
 
        [coinShow runAction:action];
        [DataSys ScoreAdd:1];
        [self Refresh];
    }
}

-(void)Refresh
{
    scoreNum = [DataSys GetScore];
    [scoreLabel setString:[NSString stringWithFormat:OC("%07d "), scoreNum]];
    [winLabel setString:[NSString stringWithFormat:OC("%04d "), winNum]];
    [debtLabel setString:[NSString stringWithFormat:OC("%03d "), debtNum]];        
    [levelLabel setString:[NSString stringWithFormat:OC("%d"), [DataSys GetLevel]]];

    small.visible = middle.visible = large.visible = false;
    
    if(0 <= scoreNum && scoreNum < 50000) small.visible = true;
    if(50000 <= scoreNum && scoreNum < 1000000) middle.visible = true;
    if(1000000 <= scoreNum ) large.visible = true;
    
    for(int i = 0; i < 72; i++) expSp[i].visible = false;
    expSpl.visible = expSpr.visible = false;
    for(int i = 0; i < 72; i++) engSp[i].visible = false;
    engSpl.visible = engSpr.visible = false;
    
    if((expNum = [DataSys GetExp]) != 0)
    {
        expSpr.visible = expSpl.visible = true;
        for(int i = 0; i < (int)(expNum * 0.72); i++)
            expSp[i].visible = true;
        expSpl.position = ccp(207 - (int)(expNum * 0.72), 305);
        
    }
    if((engNum = [DataSys GetEng]) != 0)
    {
        engSpl.visible = engSpr.visible = true;
        for(int i = 0; i < (int)(engNum * 0.72); i++)
            engSp[i].visible = true;
        engSpr.position = ccp(271 + (int)(engNum * 0.72), 305);
    }
}

-(void)MinusDebt:(int)pourNum
{
    [DataSys ScoreMinus:debtNum * pourNum];
    [self Refresh];
}

-(void)AddDebtWithLimit:(int)limit WithPourNum:(int)pourNum
{
    winNum = 0;
    if(reDebt){
        debtNum = 0;
        reDebt = false;
    }
    if(debtNum < limit && debtNum * pourNum<[DataSys GetScore])
    {
        InsertCoin * insertCoin = [InsertCoin node];
        [self addChild:insertCoin];
        [insertCoin ActionBegin];
        debtNum++;
    }
    [self Refresh];
}

-(void)SetDebtZero
{
    winNum = 0;
    debtNum = 0;
    [self Refresh];
}

-(int)GetDebt
{
    return debtNum;
    
}

-(void)AddScoreWithScore:(int)score
{
    [DataSys ScoreAdd:score];
    [self Refresh];
}

-(void)AddScoreWithRate:(int)rate
{
    if (rate <= 0){
        winNum = 0;
        [self Refresh];
        reDebt = true;
        
    }else{
        winNum = debtNum * rate;
        [DataSys ScoreAdd:winNum];
        [self Refresh];
        reDebt = true;
    }
}

-(bool)AddExp:(int)exp
{
    [DataSys ExpAdd:exp];
    [self Refresh];
    if([DataSys GetExp] == 100) return true;
    else return false;
}

-(bool)AddEng:(int)eng
{
    [DataSys EngAdd:eng];
    [self Refresh];
    if([DataSys GetEng] == 100){
        [MusicCenter playSoundEffect:powerSlot];
        
        [itemR runAction:[CCBlink actionWithDuration:2.0f blinks:4]];
        return true;
    }
    return false;
}

-(int)GetEng
{
    return [DataSys GetEng];
}

-(void)EngReset
{
    [DataSys EngReset];
    [self Refresh];
}

-(void)LevelUp
{
    [DataSys LevelAdd];
    [DataSys ExpReset];
    [self Refresh];
}

-(int)GetLevel
{
    return [DataSys GetLevel];
}

-(void)dealloc
{
    [super dealloc];
}

@end