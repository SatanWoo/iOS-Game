//
//  GameConfig.h
//  tapat
//
//  Created by 吴 wuziqi on 10-10-28.
//  Copyright 同济大学 2010. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2
//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationUIViewController


#pragma mark -
#pragma mark WindowSize

#define ipadWidth 1024
#define ipadLength 768

#define _MICE 1
#define _PROP 2

int Level;
int tempScore;
int tempWinScore;

#pragma mark -
#pragma mark ourOwnPrefix

#define scoreTag 7
#define timeTag 8

#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180




#endif // __GAME_CONFIG_H