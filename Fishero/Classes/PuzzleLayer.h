//
//  PuzzleLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfig.h"
#import "SceneManager.h"

@interface PuzzleLayer : CCLayer {
	CCSprite* complete;
	CCSprite* block[puzzleRow][puzzleLine];
	CCSprite* frame[puzzleRow][puzzleLine];
	CGPoint show[puzzleRow][puzzleLine];       //the point where the blocks show
	
	int num[puzzleRow][puzzleLine];
	bool isUsed[puzzleRow * puzzleLine];
	
	CGPoint begin, move, end;
	int x1, y1, x2, y2;
	
	int touchStatu;
	int viewStatu;

}


@end
