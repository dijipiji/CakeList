//
//  CakeData.m
//  Cake List
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

#import "CakeData.h"

static NSMutableArray *_SOURCED_CELL_IMAGES;
static NSArray *_LIST_OBJECTS;

@implementation CakeData

/**
 *
 */
+(NSArray*)listObjects {
    return _LIST_OBJECTS;
}

/**
 *
 */
+(void)setListObjects:(NSArray*)listObjects {
    _LIST_OBJECTS = listObjects;
}

/**
 *
 */
+(NSMutableArray*)sourcedCellImages {
    return _SOURCED_CELL_IMAGES;
}

/**
 *
 */
+(void)setSourcedCellImages:(NSMutableArray*)images {
    _SOURCED_CELL_IMAGES = images;
}

/**
 *
 */
+(NSData *)getData {
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

/**
 *
 */
+(id)parseData:(NSData *)data {
    NSError *jsonError;
    NSArray *responseData = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:kNilOptions
                       error:&jsonError];
    
    if (!jsonError) {
        return responseData;
    } else {
        return jsonError;
    }
    
}


@end
