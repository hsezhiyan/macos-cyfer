#include <Cocoa/Cocoa.h>
#import "collectionMethods.h"
#import "timerMethods.h"
#import "runLoop.h"

static runLoop *cyferProgram;
int main() {
    cyferProgram = [[runLoop alloc] init];
    [cyferProgram runProgram];
}
