#include <Cocoa/Cocoa.h>
#import "collectionMethods.h"
#import "timerMethods.h"

// Add observer to register when the frontmostApplication changes
// [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(nsworkspaceNotification:) name:nil object:nil];
static collectionMethods *collectionMethod;
int main() {
    collectionMethod = [[collectionMethods alloc] init];
    //timerMethods *timerMethod = [[timerMethods alloc] init];
    NSRunningApplication *output = [[NSRunningApplication alloc] init];
    //NSMutableArray *output = [[NSMutableArray alloc] init];
    //CFTimeInterval startTime;
    //CFTimeInterval endTime;
    //CFTimeInterval elapsedTime;
    @autoreleasepool
    {
        NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
        collectionMethods *cm = [[collectionMethods alloc] init];
        while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]]);
    };
//    for (int i = 1; i <= 10; i--) {
//        usleep(2000000);
//        output = [collectionMethod frontmostApplication];
//        //output = [collectionMethod allRunningApplications];
//        //startTime = [timerMethod getCurrentTime];
//        //endTime = [timerMethod getCurrentTime];
//        //elapsedTime = [timerMethod getElapsedTime: startTime andTime2:endTime];
//        //NSLog(@"Frontmost app or list of running apps: %@\n", output);
//        //NSLog(@"Elapsed time: %f seconds.", elapsedTime);
//    }
    return 0;
}
