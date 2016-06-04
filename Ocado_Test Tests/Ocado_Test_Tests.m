//
//  Ocado_Test_Tests.m
//  Ocado_Test Tests
//
//  Created by Vladimir Marinov on 29.05.16.
//  Copyright © 2016 Vladimir Marinov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TimeIntervalWatch.h"

@interface Ocado_Test_Tests : XCTestCase

@end

@implementation Ocado_Test_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/*!
 * @discussion Test initialization of the Watch
 */
- (void)testInitTimeIntervalWatch {
    TimeintervalWatch *timeWatch = [[TimeintervalWatch alloc] init];
    XCTAssertEqual(timeWatch.timeInterval, 0, @"Init Failed");
    XCTAssertEqual(timeWatch.currentState, Stopped, @"Init Failed");
}
/*!
 * @discussion Test that Start method runs the Watch
 */
- (void)testStartTimeIntervalWatch {
    TimeintervalWatch *timeWatch = [[TimeintervalWatch alloc] init];
    [timeWatch start];
    int64_t timeToRun = 3;
    XCTestExpectation *exp = [self expectationWithDescription:@"Start Watch"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeToRun * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
        
    });
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        XCTAssert(timeWatch.timeInterval >= timeToRun, @"Time Interval Run Failed");
        XCTAssertNotEqual(timeWatch.currentState, Stopped, @"Time Interval Run Failed");
    }];
}
/*!
 * @discussion Validate string format
 */
- (void)testStringFormat {
    TimeintervalWatch *timeWatch = [[TimeintervalWatch alloc] init];
    XCTAssertEqual(timeWatch.timeInterval, 0, @"Init Failed");
}
@end
