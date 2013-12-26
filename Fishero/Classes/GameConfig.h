//
//  GameConfig.h
//  Fishero
//
//  Created by  appleclub on 11-3-6.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
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

#define ipadWidth 1024
#define ipadLength 768

int level;
int selectLayer;

#define itouchWidth 480
#define itouchLength 320

#define picWidth 600
#define picLength 450

#define maxRow 11
#define maxLine 18
#define maxColor 9
#define maxProp 2

#define propsNum 4
#define beansNum 50

#define puzzleRow 5
#define puzzleLine 8

#define blockSize 100

#define picWidthPuz 800
#define picLengthPuz 500

bool isPause;






#endif // __GAME_CONFIG_H