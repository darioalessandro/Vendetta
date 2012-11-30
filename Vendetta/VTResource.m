//
//  VTResource.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTResource.h"
#import "VTResourceParser.h"

@implementation VTResource{
    __strong NSArray * _allURLs;
}

#pragma mark -
#pragma mark Public API

+(VTResource *)resourceWithData:(NSData *)data  error:(NSError **)error{
    VTResource * resource;
    if(data){
        resource=[[VTResource alloc] _init];
        resource.data=data;
    }else{
        *error=[NSError errorWithDomain:@"Attempted to create VTResource instance without data." code:1 userInfo:nil];
    }
    return resource;
}

-(NSArray *)allURLs{
    if(!_allURLs){
         _allURLs=[[VTResourceParser new] URLsFromData:self.data];
        
    }

    return _allURLs;
}

#pragma mark -
#pragma mark Private API

-(NSString *)description{
    NSString * description=[super description];
    if (self.data) {
        description= [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    }
    return description;
}

-(id)init{
    NSException * e=[NSException exceptionWithName:@"API Policy exception" reason:@"You should call resourceWithData:error: in order to instantiate this." userInfo:nil];
    [e raise];
    return nil;
}

-(id)_init{
    self=[super init];
    return self;
}

@end
