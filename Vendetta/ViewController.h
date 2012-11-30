//
//  ViewController.h
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTResource.h"

@interface ViewController : UITableViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong) VTResource * resource;
@property (strong, nonatomic) IBOutlet UITableViewCell *searchBarCell;
@end
