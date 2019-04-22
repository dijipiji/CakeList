//
//  CakeData.h
//  Cake List
//
//  Created by Jamie Lemon on 19/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CakeData : NSObject 

//@property (strong, nonatomic) NSArray *listObjects;

+(void)setListObjects:(NSArray*)listObjects;
+(NSArray*)listObjects;
+(NSMutableArray*)sourcedCellImages;
+(void)setSourcedCellImages:(NSMutableArray*)images;
+(NSData *)getData;
+(id)parseData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
