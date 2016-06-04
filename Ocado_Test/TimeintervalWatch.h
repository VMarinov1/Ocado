//
//  TimeintervalWatch.h
//  Ocado_Test
//
//  Created by Vladimir Marinov on 29.05.16.
//  Copyright © 2016 Vladimir Marinov. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    Started,
    Stopped,
    Paused
}WatchStateEnum;

@interface TimeintervalWatch : NSObject

@property (nonatomic, readonly, getter = getTimeInterval) NSTimeInterval timeInterval;
@property (nonatomic, readonly) WatchStateEnum currentState;


- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;
- (NSString*)intervalStringValue;


@end
