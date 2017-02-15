//
//  AcronymConnectionManager.h
//  AcronymsTest
//
//  Created by Orlando Hiram Banuelos on 2/10/17.
//  Copyright © 2017 Orlando Bañuelos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AcronymConnectionManager : NSObject

+ (AcronymConnectionManager *) sharedInstance;
+ (void)getInfoForAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
