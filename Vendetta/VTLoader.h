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

@property(nonatomic, assign) VTLoaderStatus status;
@property(atomic, strong) NSURL * url;
@property(nonatomic, strong) NSOperationQueue * operationQueue;
@property(nonatomic, copy) VTLoaderOnLoadURLHandler onLoadHandler;
+(VTLoader *)loaderWithURL:(NSURL *)url;
-(void)loadURLContentsWithHandler:(VTLoaderOnLoadURLHandler)handler;

@end
