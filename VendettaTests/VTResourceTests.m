//
//  VTResourceTests.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTResourceTests.h"
#import "VTResource.h"

@implementation VTResourceTests

-(void)testShouldGetNilInstanceAndErrorWithNilData{
    NSError * error;
    VTResource * resource=[VTResource resourceWithData:nil error:&error];
    STAssertEqualObjects(nil, resource, @"Should be nil but it's not %@", resource);
    STAssertTrue(error!=nil, @"should get an error but got a nil pointer");
}


@end
