//
//  VTTableViewController.m
//  fritidsresor
//
//  Created by Emil Wall on 4/15/13.
//  Copyright (c) 2013 William Lundin Forssén. All rights reserved.
//

#import "VTTableViewController.h"
#import "VTLastMinuteApiClient.h"
#import "VTCell.h"

@interface VTTableViewController ()

@property (nonatomic, strong) NSMutableArray *apiData;

@end

@implementation VTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self callApi:@"offers/from/stockholm/arlanda"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)callApi:(NSString *)selector
{
    [[VTLastMinuteApiClient sharedClient] getPath:selector parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.apiData = [[NSMutableArray alloc] initWithCapacity:[responseObject count]];
        for (NSDictionary *dict in responseObject) {
            [self.apiData addObject:dict];
            NSLog(@"%@ -> %@", [dict valueForKey:@"price"], [dict valueForKey:@"destination"]);
        }
        [self.tableView reloadData];
        NSLog(@"Success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fail");
    }];
}

- (NSString *)getDate:(NSString *)date:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *noColons = [date stringByReplacingOccurrencesOfString:@":" withString:@""];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HHmmss.SSSZZZ"];
    NSDate *dateObj = [dateFormatter dateFromString:noColons];
    [dateFormatter setDateFormat:format];
    NSString *newDate = [dateFormatter stringFromDate:dateObj];
    NSLog(@"%@: %@", format, newDate);
    return newDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    unsigned long numRows = (unsigned long)[self.apiData count];
    NSLog(@"%lu", numRows);
    return numRows;
}

- (VTCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dict = [self.apiData objectAtIndex:indexPath.row];
    
    // price
    cell.priceLabel.text = [NSString stringWithFormat:@"%@:-", [[dict valueForKey:@"price"] stringValue]];
    
    // room description
    cell.travelTypeLabel.text = [dict valueForKey:@"roomDesc"];
    
    // date (month)
    cell.monthLabel.text = [self getDate:[dict valueForKey:@"date"]:@"MMM"];
    
    // date (day)
    cell.dayLabel.text = [self getDate:[dict valueForKey:@"date"]:@"dd"];
    
    // destination
    cell.countryLabel.text = [dict valueForKey:@"destination"];
    
    // alert if less than 3 remaining
    if ([[dict valueForKey:@"remaining"] integerValue] > 2) {
        cell.alertLabel.text = @"";
        cell.alertImage.hidden = TRUE;
    } else {
        cell.alertLabel.text = [NSString stringWithFormat:@"%@ kvar", [[dict valueForKey:@"remaining"] stringValue]];
        cell.alertImage.hidden = FALSE;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
