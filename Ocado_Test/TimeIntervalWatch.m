//
//  TimeintervalWatch.m
//  Ocado_Test
//
//  Created by Vladimir Marinov on 29.05.16.
//  Copyright © 2016 Vladimir Marinov. All rights reserved.
//

#import "TimeintervalWatch.h"

@interface TimeintervalWatch()

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) NSTimeInterval pauseInterval;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TimeintervalWatch


@synthesize currentState = _currentState;

- (instancetype)init{
    if(self = [super init]){
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"HH:mm:ss"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        _currentState = Stopped;
        return self;
    }
    return nil;
}

/*!
 * @discussion Sets startDate
 */
- (void)start{
    _currentState = Started;
    self.startDate = [NSDate date];
}

/*!
 * @discussion Clear startDate
 */
- (void)stop{
    _currentState = Stopped;
    self.startDate = nil;
}

/*!
 * @discussion pause startDate
 */
- (void)pause{
    _currentState = Paused;
    self.pauseInterval = [self getTimeInterval];
}

/*!
 * @discussion resume startDate
 */
- (void)resume{
    _currentState = Started;
    NSTimeInterval interval = self.pauseInterval*-1;
    self.startDate = [[NSDate date] dateByAddingTimeInterval: interval];
}

/*!
 * @discussion Calculate interval since last start
 * @return interval since last start
 */
- (NSTimeInterval)getTimeInterval{
    if(self.startDate != nil){
        return [[NSDate date] timeIntervalSinceDate:self.startDate];
    }
    return 0;
}
/*!
 * @discussion convert interval to string with format 00:00:00
 * @return formated interval
 */
- (NSString*)intervalStringValue{
    NSTimeInterval timeInterval = [self getTimeInterval];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self.dateFormatter stringFromDate:timerDate];
}

@end
