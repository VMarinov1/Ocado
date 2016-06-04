//
//  ViewController.m
//  Ocado_Test
//
//  Created by Vladimir Marinov on 29.05.16.
//  Copyright © 2016 Vladimir Marinov. All rights reserved.
//

#import "ViewController.h"
#import "TimeIntervalWatch.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *watchTimer;
@property (nonatomic, strong) TimeintervalWatch *timeintervalWatch;
@property (nonatomic, weak) IBOutlet UILabel *intervalValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *pauseLabel;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (nonatomic, weak) IBOutlet UIButton *pauseButton;
@property (nonatomic, weak) IBOutlet UIButton *resumeButton;

@end

@implementation ViewController

#pragma mark- View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeintervalWatch = [[TimeintervalWatch alloc] init];
    self.pauseLabel.alpha = 0;
    [UIView animateWithDuration:1.5 delay:0.2 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        self.pauseLabel.alpha = 1;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.pauseLabel.layer removeAllAnimations];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateUIElements];
}
#pragma mark- IBActions

- (IBAction)startButtonPressed:(id)sender{
    [self.timeintervalWatch start];
    self.watchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerUpdate:) userInfo:nil repeats:YES];
    [self updateUIElements];
}

- (IBAction)stopButtonPressed:(id)sender{
    [self.timeintervalWatch stop];
    [self.watchTimer invalidate];
    [self updateUIElements];
}

- (IBAction)pauseButtonPressed:(id)sender{
    [self.timeintervalWatch pause];
    [self.watchTimer invalidate];
    [self updateUIElements];
   
}

- (IBAction)resumeButtonPressed:(id)sender{
    self.watchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerUpdate:) userInfo:nil repeats:YES];
    [self.timeintervalWatch resume];
    [self updateUIElements];
}
#pragma mark- Actions

/*!
 * @discussion Update timeinterval value in UI
 * @param sender WatchTimer
 */
- (void)timerUpdate:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.intervalValueLabel setText:[self.timeintervalWatch intervalStringValue]];
    });
}
/*!
 * @discussion Update UI elements based on watch status
 */
- (void)updateUIElements{
    [self.intervalValueLabel setText:[self.timeintervalWatch intervalStringValue]];
    switch (self.timeintervalWatch.currentState ) {
        case Stopped:{
            [self.pauseButton setHidden:YES];
            [self.resumeButton setHidden:YES];
            [self.startButton setHidden:NO];
            [self.stopButton setHidden:YES];
            [self.pauseLabel setHidden:YES];
        }
        break;
        case Started:{
            [self.pauseButton setHidden:NO];
            [self.resumeButton setHidden:YES];
            [self.startButton setHidden:YES];
            [self.stopButton setHidden:NO];
            [self.pauseLabel setHidden:YES];
        }
            break;
        case Paused:{
            [self.pauseButton setHidden:YES];
            [self.resumeButton setHidden:NO];
            [self.startButton setHidden:YES];
            [self.stopButton setHidden:NO];
            [self.pauseLabel setHidden:NO];
        }
        break;
        default:
            break;
    }
}
@end
