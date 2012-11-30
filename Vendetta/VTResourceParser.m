//
//  VTResourceParser.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTResourceParser.h"
#import "XPathQuery.h"

@implementation VTResourceParser

#pragma mark -
#pragma mark Public

-(NSArray *)URLsFromData:(NSData *)data{
    NSString * xPathQuery= @"//*[@src]/@src | //*[@href]/@href";
    NSDate * start=[NSDate date];
    NSArray * nodes= PerformHTMLXPathQuery(data, xPathQuery);
    NSDate * end=[NSDate date];
    NSLog(@"parsing time %lf", [end timeIntervalSinceDate:start]);
    NSArray * urls=[self URLsFromRawXPathQueryResponse:nodes];
    return urls;
}

#pragma mark -
#pragma mark Private

-(NSArray *) URLsFromRawXPathQueryResponse:(NSArray *)nodes{
    NSMutableArray * array=[NSMutableArray array];
    [nodes enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        NSURL * url=[NSURL URLWithString:[obj objectForKey:@"nodeContent"]];
        if([[url scheme] isEqualToString:@"http"])
            [array addObject:url];
    }];
    return array;
}


@end
