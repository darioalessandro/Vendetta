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

+(VTLoader *)loaderWithURL:(NSURL *)url{
    VTLoader * loader;
    if(url!=nil){
        loader=[[VTLoader alloc] _init];
        [loader setValue:url forKey:@"url"];
        loader.operationQueue=[NSOperationQueue new]; //TODO: refactor to a global backgrounding queue.
    }
    return loader;
}


-(void)loadURLContentsWithHandler:(VTLoaderOnLoadURLHandler)handler{
    NSURLRequest * URLRequest=[self URLRequest];
    if(!handler){
        [NSException raise:@"API Policy exception" format:@"Attempted to load url %@ from %@ with nil handler.", self, self.url];
    }
    self.onLoadHandler=handler;
    [NSURLConnection sendAsynchronousRequest:URLRequest queue:[self operationQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        VTResource * resource=[VTResource resourceWithData:data error:&error];
        self.onLoadHandler(resource, error);
        self.status=VTLoaderStatusDone;
    }];
    self.status=VTLoaderStatusInProgress;
}

#pragma mark -
#pragma mark Private API

-( NSURLRequest *)URLRequest{
    if(!self.url){
        [NSException raise:@"API Policy exception" format:@"Attempted to load nil url from %@.", self];
    }
    return [NSURLRequest requestWithURL:self.url];
}

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
