//
//  Ant.h
//  AntSystem
//
//  Created by walterfernandes on 25/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Column;
@class AntSystemSCP;

@interface Ant : NSObject

@property(nonatomic, strong) AntSystemSCP *antSystem;
@property(nonatomic, strong) NSMutableArray *solution;
@property(readonly, getter = getCost) double cost;
@property(nonatomic, strong) NSMutableSet *uncoveredLines;
@property(nonatomic, strong) NSMutableDictionary *probability;

- (id)initWithSystem:(AntSystemSCP*)system;
- (NSArray*)buildSolution;
- (double)getCost;

@end
