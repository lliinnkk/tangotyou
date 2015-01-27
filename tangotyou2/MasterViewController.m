//
//  MasterViewController.m
//  tangotyou2
//
//  Created by Link Kato on 2014/12/16.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    insertmode = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender




{
    if (insertmode==YES) {
        blackView = [[UIView alloc] initWithFrame:CGRectMake(0,200,320,320)];
        blackView.backgroundColor = [UIColor blackColor];
        textFired= [[UITextField alloc]initWithFrame:CGRectMake(25, 25, 270, 40)];
        textFired.backgroundColor= [UIColor whiteColor];
        textFired.delegate = self;
        [blackView addSubview:textFired];
        [self.view addSubview:blackView];
        insertmode=NO;
        
    }else{
        NSLog(@"insertmodeになっていません。");
        
    }

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
    
 -(BOOL)textFiredShouldReturn:(UITextField *)tf
   {
       insertmode = YES;
       
       if(!_objects) {
           _objects = [[NSMutableArray alloc]init];
       }
       if([textFired.text length]>0) {
           [_objects insertObject:textFired.text atIndex:0];
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0
                                                       inSection:0];
           [self.tableView  insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
       }else{
           UIAlertView *alert= [[UIAlertView alloc]
                                initWithTitle:@"未記入"message:@"何も書かれていません"
                                delegate:self cancelButtonTitle:@"OK"
                                otherButtonTitles:nil, nil];
           [alert show];
           
       }
       
       if(blackView) {
           [blackView removeFromSuperview];
           
       }
       
       
       
       [textFired resignFirstResponder];
       return YES;
       }
   

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

@end
