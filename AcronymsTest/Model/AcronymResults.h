//
//  AcronymResults.h
//  AcronymsTest
//
//  Created by Orlando Hiram Banuelos on 2/10/17.
//  Copyright © 2017 Orlando Bañuelos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymResults : NSObject

- (id)initWithDictionary:(NSDictionary *)data;

@property (nonatomic, strong) NSArray *results;

@end
