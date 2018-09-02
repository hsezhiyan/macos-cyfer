//
//  IdleTime.h
//  objectivec-cyfer
//
//  Created by Hariharan Sezhiyan on 7/22/18.
//  Copyright © 2018 Cyfer. All rights reserved.
//

#include <IOKit/IOKitLib.h>

@interface IdleTime : NSObject
{
@protected
    
    mach_port_t   _ioPort;
    io_iterator_t _ioIterator;
    io_object_t   _ioObject;
    
@private
    
    id r1;
    id r2;
}

@property( readonly ) uint64_t   timeIdle;
@property( readonly ) NSUInteger secondsIdle;

@end
