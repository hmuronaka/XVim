//
//  HMStopWatchHelper.h
//  HMStopWatch
//
//  Created by MuronakaHiroaki on 2015/09/02.
//  Copyright © 2015年 hmu. All rights reserved.
//

#import <sys/time.h>

double hm_getDifferenceTimeVal(const struct timeval* beginTime, const struct timeval* endTime);

