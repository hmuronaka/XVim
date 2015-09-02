//
//  HMStopWatch.m
//  HMStopWatch
//
//  Created by MuronakaHiroaki on 2015/09/02.
//  Copyright © 2015年 hmu. All rights reserved.
//
#import <sys/time.h>
#import "HMStopWatch.h"
#import "HMStopWatchHelper.h"

@interface HMStopWatch()
{
    struct timeval _beginTime;
    struct timeval _endTime;
}

@property(nonatomic, assign) double time;

@end

@implementation HMStopWatch

-(instancetype)init {
    self = [super init];
    if ( self ) {
        [self reset];
    }
    return self;
}

-(void)start {
    gettimeofday(&_beginTime, NULL);
}

-(void)stop {
    gettimeofday(&_endTime, NULL);
    self.time += hm_getDifferenceTimeVal(&_beginTime, &_endTime);
}

-(void)reset {
    _time = 0;
    bzero(&_beginTime, 0);
    bzero(&_endTime, 0);
}

-(void)startWithRunner:(HMStopWatchRunner)runner {
    if( !runner ) {
        return;
    }
    
    [self start];
    runner(self);
    [self stop];
}

@end
