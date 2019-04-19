//
//  CakeData.m
//  Cake List
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

#import "CakeData.h"

@implementation CakeData



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
