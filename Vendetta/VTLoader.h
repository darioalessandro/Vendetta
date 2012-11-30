//
//  VTLoader.h
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTResource.h"

typedef void(^VTLoaderOnLoadURLHandler)(VTResource * resource, NSError *error);
typedef enum VTLoaderStatus{
    VTLoaderStatusUnknown=0,
    VTLoaderStatusIdle,
    VTLoaderStatusInProgress,
    VTLoaderStatusDone
} VTLoaderStatus;

@interface VTLoader : NSObject

@property(nonatomic, copy) VTLoaderOnLoadURLHandler onLoadHandler;
@property(atomic,  strong) NSURLRequest * request;
@property(nonatomic, assign) VTLoaderStatus status;
@property(nonatomic, strong) NSOperationQueue * operationQueue;

+(VTLoader *)loaderWithRequest:(NSURLRequest *)request;
-(void)loadURLContentsWithHandler:(VTLoaderOnLoadURLHandler)handler;

@end
