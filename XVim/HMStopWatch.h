//
//  HMStopWatch.h
//  HMStopWatch
//
//  Created by MuronakaHiroaki on 2015/09/02.
//  Copyright © 2015年 hmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMStopWatch : NSObject

typedef void (^HMStopWatchRunner)(HMStopWatch* stopwatch);

@property(nonatomic, readonly) double time;

-(instancetype)init;

-(void)start;
-(void)stop;
-(void)reset;

-(void)startWithRunner:(HMStopWatchRunner)runner;

@end
