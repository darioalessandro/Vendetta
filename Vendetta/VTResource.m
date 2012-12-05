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
