//
//  HMStopWatchHelper.c
//  HMStopWatch
//
//  Created by MuronakaHiroaki on 2015/09/02.
//  Copyright © 2015年 hmu. All rights reserved.
//

#import <string.h>
#import "HMStopWatchHelper.h"

double hm_getDifferenceTimeVal(const struct timeval* beginTime, const struct timeval* endTime) {
    
    double begin_ms = (double)beginTime->tv_sec * 1000000 + (double)beginTime->tv_usec;
    double end_ms = (double)endTime->tv_sec * 1000000 + (double)endTime->tv_usec;
    
    return end_ms - begin_ms;
}

