//
//  VTResource.h
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPathQuery.h"

@interface VTResource : NSObject

@property(nonatomic, strong) NSData * data;
+(VTResource *)resourceWithData:(NSData *)data error:(NSError **)error;
-(NSArray *)allURL;
@end
