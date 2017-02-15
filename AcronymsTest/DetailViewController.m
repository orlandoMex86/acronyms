//
//  DetailViewController.m
//  AcronymsTest
//
//  Created by Orlando Hiram Banuelos on 2/10/17.
//  Copyright © 2017 Orlando Bañuelos. All rights reserved.
//

#import "DetailViewController.h"
#import "VarTableViewController.h"

@interface DetailViewController ()

@property (nonatomic, assign) NSInteger iIndex;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Results";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arrDetail[indexPath.row][@"lf"];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *container = [UIView new];
    UILabel *label = [UILabel new];
    container.backgroundColor = [UIColor blueColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:label];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[label]-(10)-|" options:0 metrics:nil  views:@{@"label" : label }]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(15)-[label]-(3)-|" options:0 metrics:nil   views:@{@"label" : label}]];
    
    label.text = [NSString stringWithFormat:@"Results for %@", self.strSearch];
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    return container;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.iIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"showVar" sender:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showVar"]) {
        //NSIndexPath *indexPath = [self.acronymTableView indexPathForSelectedRow];
        VarTableViewController *varViewController = [segue destinationViewController];
        varViewController.arrVar = self.arrDetail[self.iIndex][@"vars"];
    }
}


@end
