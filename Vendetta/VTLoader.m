//
//  VTLoader.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTLoader.h"

@interface VTLoader (Private)

@end

@implementation VTLoader

+(VTLoader *)loaderWithRequest:(NSURLRequest *)request{
    VTLoader * loader;
    if(request!=nil){
        loader=[[VTLoader alloc] _init];
        [loader setValue:request forKey:@"request"];
        loader.operationQueue=[NSOperationQueue new]; //TODO: refactor to a global backgrounding queue.
    }
    return loader;
}


-(void)loadURLContentsWithHandler:(VTLoaderOnLoadURLHandler)handler{
    if(!handler){
        [NSException raise:@"API Policy exception" format:@"Attempted to load url %@ from %@ with nil handler.", self, self.request];
    }
    self.onLoadHandler=handler;
    [NSURLConnection sendAsynchronousRequest:self.request queue:[self operationQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        VTResource * resource=[VTResource resourceWithData:data error:&error];
        self.onLoadHandler(resource, error);
        self.status=VTLoaderStatusDone;
    }];
    self.status=VTLoaderStatusInProgress;
}

#pragma mark -
#pragma mark Private API

-(id)init{
    NSException * e=[NSException exceptionWithName:@"API Policy exception" reason:@"You should call loaderWithURL in order to instantiate this." userInfo:nil];
    [e raise];
    return nil;
}

-(id)_init{
    self=[super init];
    self.status=VTLoaderStatusIdle;
    return self;
}

@end
