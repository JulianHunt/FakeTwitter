//
//  TweetListTableViewController.m
//  FakeTwitter
//
//  Created by Julian Hunt on 2017-06-03.
//  Copyright © 2017 Julian Hunt. All rights reserved.
//

#import "TweetListTableViewController.h"
#import "TweetTableViewCell.h"
#import "TweetModel.h"
#import <Realm/Realm.h>
#import "NetworkEngine.h"

@interface TweetListTableViewController ()

@property (nonatomic, strong) RLMResults *array;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

@implementation TweetListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweetCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
    
    //SETUP REALM DATA
    
    // Load local data and then make an async call to load new data
    self.array = [[TweetModel allObjects] sortedResultsUsingKeyPath:@"postDate" ascending:YES];
    
    
    
    // Set realm notification block
    __weak typeof(self) weakSelf = self;
    self.notification = [self.array addNotificationBlock:^(RLMResults *data, RLMCollectionChange *changes, NSError *error) {
        if (error) {
            NSLog(@"Failed to open Realm on background worker: %@", error);
            return;
        }
        
        UITableView *tv = weakSelf.tableView;
        // Initial run of the query will pass nil for the change information
        if (!changes) {
            [tv reloadData];
            return;
        }
        
        // changes is non-nil, so we just need to update the tableview
        [tv beginUpdates];
        [tv deleteRowsAtIndexPaths:[changes deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tv insertRowsAtIndexPaths:[changes insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tv reloadRowsAtIndexPaths:[changes modificationsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tv endUpdates];
    }];
    
    
}
- (void)refreshData{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
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
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    
    TweetModel *tweet = self.array[indexPath.row];
    cell.accountName.text = tweet.account;
    cell.accountHandle.text = tweet.handle;
    cell.tweetContent.text = tweet.tweetContent;
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
