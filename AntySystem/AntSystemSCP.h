//
//  AntySystemSCP.h
//  AntySystem
//
//  Created by walterfernandes on 16/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AntSystemSCP : NSObject

@property (assign)              NSInteger n;                    //numero de linhas
@property (assign)              NSInteger m;                    //numero de colunas
@property (assign)              NSInteger num_ants;             // numero de formigas
@property (assign)              float alfa;                     //parametros
@property (assign)              float beta;                     //
@property (assign)              float ro;                       //
@property (assign)              NSInteger Q;                    //
@property (assign)              NSInteger num_iter;             //numero maximo de iteracoes
@property (nonatomic, retain)   NSMutableArray *colony;         //lista de formigas
@property (nonatomic, retain)   NSMutableArray *columns;        //lista de colunas
@property (nonatomic, retain)   NSMutableArray *pheromone;      //array [1...m]
@property (nonatomic, retain)   NSMutableArray *bestSolution;   //melhor solucao
@property (nonatomic, retain)   NSMutableArray *costs;          //todos os custos intermediarios

@property (readonly, getter = getBestSolutionCost) double bestSolutionCost; //custo da melhor solução

-(id)initWithAlfa:(float)alfa beta:(float)beta ro:(float)ro q:(NSInteger)q num_iter:(NSInteger)num_iter num_ants:(float)num_ants filePath:(NSString*)filePath;
-(void)refreshPheromone;
-(void)execute;
-(NSArray*)getSolution;
-(double)getBestSolutionCost;

-(void)openFile:(NSString*)path readLine:(void(^)(NSString *line))lineCallback;

@end
