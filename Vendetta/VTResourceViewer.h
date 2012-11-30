//
//  VTResourceViewer.h
//  Vendetta
//
//  Created by Dario Lencina on 11/30/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTResourceViewer : UIViewController
@property(nonatomic, strong) NSURL * resource;
@property(nonatomic, weak) IBOutlet UIWebView * webView;
@end
