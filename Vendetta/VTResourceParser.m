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

-(NSArray *)URLsFromData:(NSData *)data{
    NSString * xPathQuery= @"//*[@src]/@src | //*[@href]/@href";
    NSArray * nodes= PerformHTMLXPathQuery(data, xPathQuery);
    NSMutableArray * array=[NSMutableArray array];
    [nodes enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        NSURL * url=[NSURL URLWithString:[obj objectForKey:@"nodeContent"]];
        if([[url scheme] isEqualToString:@"http"])
            [array addObject:url];
    }];
    return array;
}

@end
