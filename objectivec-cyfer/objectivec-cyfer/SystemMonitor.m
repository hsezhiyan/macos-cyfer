//
//  SystemMonitor.m
//  objectivec-cyfer
//
//  Created by Zhongyu Chen on 2018/9/16.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemMonitor.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <sys/stat.h>

#import <Foundation/Foundation.h>

@ implementation SystemMonitor
- (double)cpuUsage {
    kern_return_t kr;
    mach_msg_type_number_t count;
    static host_cpu_load_info_data_t previous_info = {0, 0, 0, 0};
    host_cpu_load_info_data_t info;
    
    CPUUsage usage = {0, 0, 0, 1};
    count = HOST_CPU_LOAD_INFO_COUNT;
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return 0.0;
        //return usage;
    }
    
    natural_t user   = info.cpu_ticks[CPU_STATE_USER] - previous_info.cpu_ticks[CPU_STATE_USER];
    natural_t nice   = info.cpu_ticks[CPU_STATE_NICE] - previous_info.cpu_ticks[CPU_STATE_NICE];
    natural_t system = info.cpu_ticks[CPU_STATE_SYSTEM] - previous_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle   = info.cpu_ticks[CPU_STATE_IDLE] - previous_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t total  = user + nice + system + idle;
    previous_info    = info;
    
    usage.user = user;
    usage.system = system;
    usage.nice = nice;
    usage.idle = idle;
    return (user + nice + system) * 100.0 / total;
    //return usage;
}

- (void)resetNumsOfClicks {
    num_clicks = 0;
}

- (int)getNumsOfClicks {
    return num_clicks;
}

- (void)increNumsOfClicks {
    num_clicks++;
}

- (void)resetNumsOfChangeTabs {
    num_tabchanges = 0;
}

- (int)getNumsOfChangeTabs {
    return num_tabchanges;
}

- (void)increNumsOfChangeTabs {
    num_tabchanges++;
}

@ end
