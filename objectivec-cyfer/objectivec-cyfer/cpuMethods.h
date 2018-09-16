//
//  cpuMethods.h
//  objectivec-cyfer
//
//  Created by Zhongyu Chen on 2018/9/16.
//  Copyright © 2018 Cyfer. All rights reserved.
//
#import <Foundation/Foundation.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>

@interface cpuMethods : NSObject
processor_info_array_t cpuInfo, prevCpuInfo;
mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
unsigned numCPUs;
NSTimer *updateTimer;
NSLock *CPUUsageLock;
@end
