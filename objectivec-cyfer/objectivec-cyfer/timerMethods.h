//
//  timerMethods.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/7/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface timerMethods : NSObject

-(CFTimeInterval) getCurrentTime;
-(CFTimeInterval) getElapsedTime: (CFTimeInterval) startTime andTime2:(CFTimeInterval) endTime;

@end
