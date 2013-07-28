//
//  Column.h
//  AntySystem
//
//  Created by walterfernandes on 23/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Column : NSObject

@property(nonatomic, strong) NSNumber *columnId;
@property(nonatomic, strong) NSNumber *cost;
@property(nonatomic, strong) NSNumber *pheromone;
@property(nonatomic, strong) NSSet *lines;

@end
