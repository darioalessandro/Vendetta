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

#import "ViewController.h"
#import "VTLoader.h"
#import "VTResourceViewer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!self.request){
        self.request=[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"presidencia.html" withExtension:nil]];
    }
        VTLoader * loader= [VTLoader loaderWithRequest:self.request];
        [loader loadURLContentsWithHandler:^(VTResource *resource, NSError *error) {
            self.resource=resource;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
        }];
    self.title=self.request.URL.absoluteString;
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
        [[cell textLabel] setAdjustsFontSizeToFitWidth:TRUE];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
//    [NSURLRequest requestWithURL:[self.resource allURLs][indexPath.row]]
    NSString * string= [[self.resource allURLs][indexPath.row] absoluteString];
    [[cell textLabel] setText:string];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ViewController * viewController= [ViewController new];
    [viewController setRequest:[NSURLRequest requestWithURL:[self.resource allURLs][indexPath.row]]];
    [self.navigationController pushViewController:viewController animated:TRUE];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
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
