//
//  Column.m
//  AntySystem
//
//  Created by walterfernandes on 23/05/13.
//  Copyright (c) 2013 walter. All rights reserved.
//

#import "Column.h"

@implementation Column

-(NSString *)description{
    return [NSString stringWithFormat:@"%@, %@ , %@",
            _columnId, _cost, [[_lines allObjects] componentsJoinedByString:@"; "]];
}

@end
