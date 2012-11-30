//
//  ViewController.m
//  Vendetta
//
//  Created by Dario Lencina on 11/29/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "ViewController.h"
#import "VTLoader.h"
#import "VTResourceViewer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest * req=[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"presidencia.html" withExtension:nil]];
    VTLoader * loader= [VTLoader loaderWithRequest:req];
    [loader loadURLContentsWithHandler:^(VTResource *resource, NSError *error) {
        self.resource=resource;
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
       });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.resource allURLs]){
    return [[self.resource allURLs] count]-1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
        return self.searchBarCell;
    
    static NSString * reuseIdentifier=@"VTResourceViewer";
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
//    [NSURLRequest requestWithURL:[self.resource allURLs][indexPath.row]]
    NSString * string= [[self.resource allURLs][indexPath.row] absoluteString];
    [[cell textLabel] setText:string];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    VTResourceViewer * viewer= [VTResourceViewer new];
    [viewer setResource:[self.resource allURLs][indexPath.row]];
    [self.navigationController pushViewController:viewer animated:YES];
}

#pragma mark -
#pragma mark searchbar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:searchBar.text]];
    VTLoader * loader= [VTLoader loaderWithRequest:req];
    [loader loadURLContentsWithHandler:^(VTResource *resource, NSError *error) {
        if(!error){
            self.resource=resource;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }];
}// called when keyboard search button presse

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
}// called when cancel button pressed

@end
