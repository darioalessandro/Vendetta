//
//  VTResourceViewer.m
//  Vendetta
//
//  Created by Dario Lencina on 11/30/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "VTResourceViewer.h"

@interface VTResourceViewer ()

@end

@implementation VTResourceViewer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.resource){
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.resource]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
