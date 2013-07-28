//
//  main.m
//  AntSystem
//
//  Created by walterfernandes on 24/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntSystemSCP.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        // insert code here...
        NSString *filePath = nil;
        if (argc > 1)
            filePath = [[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        //teste
        filePath = @"./Teste_05.dat";
        
        printf("Configuração 1\n");
        AntSystemSCP *antSystem = [[AntSystemSCP alloc] initWithAlfa:0.5
                                                                beta:0.5
                                                                  ro:0.1
                                                                   q:1
                                                            num_iter:10
                                                            num_ants:100
                                                            filePath:filePath];

        [antSystem execute];
        [antSystem getSolution];
        
        printf("\nConfiguração 2\n");
        antSystem = [[AntSystemSCP alloc] initWithAlfa:0.2
                                                  beta:0.8
                                                    ro:0.1
                                                     q:1
                                              num_iter:10
                                              num_ants:100
                                              filePath:filePath];
        [antSystem execute];
        [antSystem getSolution];

        printf("\nConfiguração 3\n");
        antSystem = [[AntSystemSCP alloc] initWithAlfa:0.8
                                                  beta:0.2
                                                    ro:0.1
                                                     q:1
                                              num_iter:10
                                              num_ants:100
                                              filePath:filePath];

        [antSystem execute];
        [antSystem getSolution];

//        printf("Parametrização 4\n");
//        antSystem = [[AntSystemSCP alloc] initWithAlfa:0.8
//                                                  beta:0.2
//                                                    ro:0.1
//                                                     q:1
//                                                  nMax:100
//                                              filePath:filePath];
//        
//        [antSystem execute];
//        [antSystem getSolution];
//        
//        printf("Parametrização 5\n");
//        antSystem = [[AntSystemSCP alloc] initWithAlfa:0.8
//                                                  beta:0.2
//                                                    ro:0.1
//                                                     q:1
//                                                  nMax:100
//                                              filePath:filePath];
//        
//        [antSystem execute];
//        [antSystem getSolution];
    }
    return 0;
}
