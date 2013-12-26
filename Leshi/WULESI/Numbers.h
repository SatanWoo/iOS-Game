//
//  Numbers.h
//  WULESI
//
//  Created by M.K.Rain on 12-5-30.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Numbers : NSManagedObject{
}

@property (nonatomic, retain) NSString* number;
@property (nonatomic, retain) NSDate* time;

@end
