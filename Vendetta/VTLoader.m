/* ====================================================================
 * Copyright (c) 2012 Dario Alessandro Lencina Talarico.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution,
 *    if any, must include the following acknowledgment:
 *    "This product includes software developed by
 *    Dario Alessandro Lencina Talarico: darioalessandrolencina@gmail.com"
 *
 *    Alternately, this acknowledgment SHOULD be included in the software itself,
 *    usually where such third-party acknowledgments normally appear,
 *
 *
 * 5. Products derived from this software may not be called "Designed by Dario",
 *    nor may "Designed by Dario" appear in their name, without prior written
 *    permission of the Author.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL DARIO ALESSANDRO LENCINA TALARICO OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 */

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
