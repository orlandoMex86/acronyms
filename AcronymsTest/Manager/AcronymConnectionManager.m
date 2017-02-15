//
//  AcronymConnectionManager.m
//  AcronymsTest
//
//  Created by Orlando Hiram Banuelos on 2/10/17.
//  Copyright © 2017 Orlando Bañuelos. All rights reserved.
//

#import "AcronymConnectionManager.h"

@interface AcronymConnectionManager()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation AcronymConnectionManager

static NSString *BASE_URL = @"http://www.nactem.ac.uk/software/acromine/";

+ (AcronymConnectionManager *)sharedInstance {
    static AcronymConnectionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Setup a general API manager
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: BASE_URL]];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain"]];
        
        
    }
    return self;
}

+ (void)getInfoForAcronym:(NSString *)acronym success:(void (^)(NSURLSessionDataTask *task, id response))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *parameters = @{@"sf": acronym, @"lf": @""};
    [[self sharedInstance].manager GET:@"dictionary.py" parameters:parameters success:success failure:failure];
}

@end
