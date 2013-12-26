//
//  CGScence.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CGScence.h"
#import "CCVideoPlayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "TigerLayer.h"
#import "CoinLayer.h"

@implementation CGScence

-(id)init
{
    self = [super init];
    if(self)
    {
        [CCVideoPlayer setNoSkip:true];
        [CCVideoPlayer playMovieWithFile:OC("Render_for_phonegame_Christ.mov")];
//        [CoinLayer sharedAnimation];
        [self performSelector:@selector(GoMenuLayer) withObject:nil afterDelay:3.0f];
    }
    return self;
}

-(void)GoMenuLayer
{
    [SceneManager GoMenu];
}


-(void)dealloc
{
    [super dealloc];
}

@end
