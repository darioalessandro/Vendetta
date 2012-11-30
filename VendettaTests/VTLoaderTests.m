//
//  VTLoaderTests.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTLoaderTests.h"
#import "VTLoader.h"
static NSString * const kPresidenciaDeMexico= @"http://www.presidencia.gob.mx/";

@implementation VTLoaderTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testShouldGetANilPointerWhenTryingToInitializeWithNilURL
{
    VTLoader * loader=[VTLoader loaderWithURL:nil];
    STAssertEqualObjects(loader, nil, @"Got a valid instance %@ instead of a nil pointer", loader);
}

-(void)testShouldGetAValidInstanceForPresidenciaDeMexico{
    NSURL * url= [NSURL URLWithString:kPresidenciaDeMexico];
    VTLoader * loader=[VTLoader loaderWithURL:url];
    STAssertTrue(loader!=nil, @"got an invalid instance %@ even when the url %@ is valid.", loader, url);
}

-(void)testShouldThrowAnExceptionIfTryingToInitializeThroughTheInitRawMethod{
    VTLoader * loader=[VTLoader alloc];
    STAssertThrows(loader=[loader init], @"The init initializer is supposed to be prohibited but this one went through.");
}

-(void)testShouldGetAnNSDataObjectAfterLoadingPresidenciaDeMexico{
    NSURL * url= [[self bundle] URLForResource:@"presidencia.html" withExtension:nil];
    VTLoader * loader=[VTLoader loaderWithURL:url];
    [loader loadURLContentsWithHandler:^(VTResource * resource, NSError *error) {
        STAssertTrue(resource!=nil, @"Unable to get resource %@", resource);
        STAssertEqualObjects(error, nil, @"Got an unexpected error %@", error);
        NSLog(@"nodes %@", [resource allURL]);
    }];
    while ([loader status]!=VTLoaderStatusDone) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeInterval:1 sinceDate:[NSDate date]]];
    }
}

-(NSBundle *)bundle{
    return [NSBundle bundleWithIdentifier:@"BFA.VendettaTests"];
}

@end
