//
//  loadingLayer.h
//  tapat
//
//  Created by 吴 wuziqi on 11-2-27.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "GameCenterManager.h"
#import "cocos2d.h"


@interface loadingLayer : CCLayer<GameCenterManagerDelegate> {
    GameCenterManager* gameCenterManager;
    CCSprite* loadingBar;
    int index;
}

@property(nonatomic,retain)GameCenterManager* gameCenterManager;

//+(id)scene;
-(void)gameCenterFunction;
-(void)loadingBar;


@end
