//
//  SystemMonitor.h
//  objectivec-cyfer
//
//  Created by Zhongyu Chen on 2018/9/16.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#ifndef SystemMonitor_h
#define SystemMonitor_h
#import <Foundation/Foundation.h>
//#import <UIKit>

typedef struct {
    unsigned int system;
    unsigned int user;
    unsigned int nice;
    unsigned int idle;
} CPUUsage;

@interface SystemMonitor: NSObject {
@private
    int num_clicks;
    int num_tabchanges;

}
- (double)cpuPercentage;
- (double)cpuSpeed;
- (void)resetNumsOfClicks;
- (int)getNumsOfClicks;
- (void)increNumsOfClicks;

- (void)resetNumsOfChangeTabs;
- (int)getNumsOfChangeTabs;
- (void)increNumsOfChangeTabs;

@end

#endif /* SystemMonitor_h */
