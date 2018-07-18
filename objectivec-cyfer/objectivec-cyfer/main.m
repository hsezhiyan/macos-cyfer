#include <Cocoa/Cocoa.h>
#import "collectionMethods.h"
#import "timerMethods.h"

// Add observer to register when the frontmostApplication changes
// [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(nsworkspaceNotification:) name:nil object:nil];
static collectionMethods *collectionMethod;
int main() {
    collectionMethod = [[collectionMethods alloc] init];
    @autoreleasepool
    {
        NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
        //collectionMethods *cm = [[collectionMethods alloc] init];
        while ([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]]);
    };
    return 0;
}
