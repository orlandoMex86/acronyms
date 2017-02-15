//
//  ViewController.m
//  AcronymsTest
//
//  Created by Orlando Hiram Banuelos on 2/10/17.
//  Copyright © 2017 Orlando Bañuelos. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "AcronymConnectionManager.h"
#import "AcronymResults.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *arrResponse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchAcronym:(id)sender{
    __weak ViewController *weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"Loading acronym", @"HUD loading title");
    
    [AcronymConnectionManager getInfoForAcronym:self.txtSearch.text
                       success:^(NSURLSessionDataTask *task, id response) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               //response is always a single item array so we get the first element
                               [hud hideAnimated:YES];
                               
                               if(((NSArray*)response).count > 0) {
                                   AcronymResults *searchResult = [[AcronymResults alloc] initWithDictionary:response[0]];
                                   weakSelf.arrResponse = [searchResult.results mutableCopy];
                                   
                                   [self performSegueWithIdentifier:@"showDetail" sender:nil];
                               } else {
                                   
                                   UIAlertController * alert = [UIAlertController
                                                                alertControllerWithTitle:@"Acronym"
                                                                message:@"Acronym does not found info for your term."
                                                                preferredStyle:UIAlertControllerStyleAlert];
                                   
                                   
                                   
                                   UIAlertAction* okButton = [UIAlertAction
                                                               actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                               }];
                                   
                                  [alert addAction:okButton];
                                   
                                   [self presentViewController:alert animated:YES completion:nil];
                                   
                                   
                               }
                           });
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [hud hideAnimated:YES];
                           });
                       }
     ];
}


#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.acronymTableView indexPathForSelectedRow];
        DetailViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.arrDetail = self.arrResponse;
        destinationViewController.strSearch = self.txtSearch.text;
        self.txtSearch.text = @"";
    }
    
}

@end
