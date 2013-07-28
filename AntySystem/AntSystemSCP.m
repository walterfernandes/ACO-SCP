//
//  AntySystemSCP.m
//  AntySystem
//
//  Created by walterfernandes on 16/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import "AntSystemSCP.h"
#import "Column.h"
#import "Ant.h"

@implementation AntSystemSCP

@synthesize alfa = _alfa;
@synthesize beta = _beta;
@synthesize ro = _ro;
@synthesize Q = _Q;
@synthesize num_iter = _num_iter;
@synthesize num_ants = _num_ants;
@synthesize colony = _colony;
@synthesize columns = _columns;
@synthesize pheromone = _pheromone;
@synthesize bestSolution = _bestSolution;
@synthesize costs = _costs;
@synthesize n = _n;
@synthesize m = _m;

-(id)initWithAlfa:(float)alfa beta:(float)beta ro:(float)ro q:(NSInteger)q num_iter:(NSInteger)num_iter num_ants:(float)num_ants filePath:(NSString *)filePath{
    
    if ((self = [super init])){
        _alfa = alfa;
        _beta = beta;
        _ro = ro;
        _Q = q;
        _num_iter = num_iter;
        
        _num_ants = num_ants;

        _colony = [NSMutableArray new];
        for (int i = 0; i < num_ants; i++)
            [_colony addObject:[[Ant alloc] initWithSystem:self]];
        
        
        _columns = [NSMutableArray new];
        _pheromone = [NSMutableArray new];
        _bestSolution = [NSMutableArray new];
        _costs = [NSMutableArray new];
        
        //get all lines from instace file 
        [self openFile:filePath readLine:^(NSString *line) {
            NSScanner *scanner = [NSScanner scannerWithString:line];
            NSMutableArray *arrayColumn = [NSMutableArray new];
            BOOL validLine = YES;
            
            if ([scanner scanString:@"LINHAS" intoString:nil]){
                //get the number of lines
                [scanner scanInteger:&(_n)];
            } else if ([scanner scanString:@"COLUNAS" intoString:nil]){
                //get the number os colomns
                [scanner scanInteger:&(_m)];
            } else {
                while (![scanner isAtEnd] && validLine) {
                    double value = 0;
                    if ([scanner scanDouble:&value])
                        [arrayColumn addObject:[NSNumber numberWithFloat:value]];
                    else
                        validLine = NO;
                }
                if (validLine){
                    Column *col = [Column new];
                    
                    col.columnId = arrayColumn[0];
                    col.cost = arrayColumn[1];
                    col.pheromone = @0.5;
                    col.lines =  [NSSet setWithArray:[arrayColumn subarrayWithRange:NSMakeRange(2, [arrayColumn count]-2)]];
                    
                    [_columns addObject:col];
                }
            }
        }];
        
        //NSLog(@"columns: %@", _columns);
    }
    return self;
}

-(void)refreshPheromone{
    for(Column *col in _columns){
        double acc = 0;
        for (Ant *ant in _colony)
            acc += [ant getCost];
        
        double pheromone = _ro * col.pheromone.doubleValue + acc;
        col.pheromone = @(pheromone);
    }
}


-(void)execute{
    for (int i = 0; i < _num_iter; i++){
        
        for (Ant *ant in _colony){
            NSArray *solution = [ant buildSolution];
            
            [_costs addObject:@([ant getCost])];
            if ([ant getCost] < [self getBestSolutionCost])
                _bestSolution = [NSArray arrayWithArray:solution];

            //atualizacao local de feromonio
            for (Column *col in solution){
                float pheromone = col.pheromone.floatValue + (_Q / [ant getCost]);
                col.pheromone = @(pheromone);
            }
        }
        //atualizacao externa de feromonio
//        for (Column *col in _bestSolution){
//            float pheromone = col.pheromone.floatValue + (_Q / [self getBestSolutionCost]);
//            col.pheromone = @(pheromone);
//        }

        [self refreshPheromone];
    }
}


-(NSArray*)getSolution{
//    printf("\nCustos:\n");
//    for (NSNumber *number in _costs)
//        printf("%.3f, ", [number doubleValue]);
    
    printf("alfa: %.1f; beta: %.1f; rô: %.1f; Q: %ld num_iter: %ld; num_ant: %ld\n", self.alfa, self.beta, self.ro, self.Q, self.num_iter, self.num_ants);
    printf("Colunas da solução:[");
    for (Column *col in _bestSolution)
        printf("%ld, ", [col.columnId integerValue]);
    
    printf("]\nMelhor Custo: %.3f\n", [self getBestSolutionCost]);
    return _bestSolution;
}

-(double)getBestSolutionCost{
    if ([_bestSolution count] == 0) return MAXFLOAT;
    double cust = 0.0f;
    for(Column *col in _bestSolution)
        cust += col.cost.floatValue;
    return cust;
}

#pragma mark - Read file function

#define BUFFER_SIZE 1024

-(void)openFile:(NSString*)path readLine:(void(^)(NSString *line))lineCallback{
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:path];
    uint8_t buffer[BUFFER_SIZE];
    NSInteger len;
    NSMutableString *_line = [NSMutableString new];
    
    [stream open];
    
    while ((len = [stream read:buffer maxLength:BUFFER_SIZE]) > 0) {
        for (int i = 0; i < len; i++){
            if (buffer[i] != '\n'){
                [_line appendFormat:@"%c", buffer[i]];
            } else {
                lineCallback(_line);
                _line = [NSMutableString new];
            }
        }
    }
    
    [stream close];

    stream = nil;
    _line = nil;
    lineCallback = nil;
}

@end
