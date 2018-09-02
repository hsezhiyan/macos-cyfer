//
//  timerMethods.m
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/7/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "timerMethods.h"
#include <Cocoa/Cocoa.h>

@implementation timerMethods

-(CFTimeInterval) getCurrentTime {
    CFTimeInterval currentTime = CACurrentMediaTime();
    return currentTime;
}

-(CFTimeInterval) getElapsedTime:(CFTimeInterval) startTime andTime2:(CFTimeInterval) endTime {
    CFTimeInterval elapsedTime = endTime - startTime;
    return elapsedTime;
}

@end

