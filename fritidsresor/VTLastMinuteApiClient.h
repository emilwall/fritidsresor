//
//  VTLastMinuteApiClient.h
//  fritidsresor
//
//  Created by Emil Wall on 4/16/13.
//  Copyright (c) 2013 William Lundin Forssén. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface VTLastMinuteApiClient : AFHTTPClient

+ (VTLastMinuteApiClient *)sharedClient;

@end
