//
//  Ant.m
//  AntSystem
//
//  Created by walterfernandes on 25/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import "Ant.h"
#import "Column.h"
#import "AntSystemSCP.h"

@implementation Ant

-(id)initWithSystem:(AntSystemSCP*)system {
    if ((self = [super init])){
        _antSystem = system;
    }
    return self;
}

-(NSArray*)buildSolution{
    //start variables
    _solution = [NSMutableArray new];
    _probability = [NSMutableDictionary new];
    _uncoveredLines = [NSMutableSet new];
    
    for (int i = 1; i <= _antSystem.n; i++)
        [_uncoveredLines addObject:[NSNumber numberWithInt:i]];
    
    while ([_uncoveredLines count] > 0) {
        
        [_probability removeAllObjects];
        
        NSArray *arrayLines = [_uncoveredLines allObjects];
        NSUInteger randomLine = arc4random() % [arrayLines count];
        NSNumber *line = [arrayLines objectAtIndex:randomLine];
        
        //get all column that cover 'line'
        NSMutableArray *columnsCovering = [NSMutableArray new];
        for (Column *col in _antSystem.columns)
            if ([col.lines containsObject:line])
                [columnsCovering addObject:col];

        //calc probability for each column
        double countP = 0;
        for (Column *col in columnsCovering){
            double probabilty = [self calcProbability:col columnsCovering:columnsCovering];
            countP += probabilty;
            [_probability setObject:col forKey:@(countP)];
        }
        
        double randP = drand48();

        Column *chosenColumn = nil;//[columnsCovering lastObject];
        for (NSNumber *prob in [_probability allKeys]){
            if (randP <= [prob doubleValue]){
                chosenColumn = [_probability objectForKey:prob];
                break;
            }
        }

        for (NSNumber *line in chosenColumn.lines){
            [_uncoveredLines removeObject:line];
        }
        
        [_solution addObject:chosenColumn];
    }
    return _solution;
}

-(double)calcProbability:(Column*)column columnsCovering:(NSArray*)columnsCovering{
    double acc = 0;
    double probability = 0;

    for (Column *col in columnsCovering){
        double phero = powf(col.pheromone.doubleValue, _antSystem.alfa);
        double visib = powf([self calcVisibility:col], _antSystem.beta);
        acc += (phero * visib);
    }
    
    double phero = powf(column.pheromone.doubleValue, _antSystem.alfa);
    double visib = powf([self calcVisibility:column], _antSystem.beta);

    probability = (phero  * visib) / acc;

    return probability;
}

-(double)calcVisibility:(Column*)column {
    double acc = 0;
    double visibility = 0;
    
    for (NSNumber *Lin in column.lines)
        if ([_uncoveredLines containsObject:Lin])
            acc ++;
    
    visibility = acc/column.cost.floatValue;
    
    return visibility;
}

-(double)getCost{
    double cust = 0.0f;
    for(Column *col in _solution)
        cust += col.cost.floatValue;
    return cust;
}

@end
