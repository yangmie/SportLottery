//
//  DetailViewController.m
//  SportLottery
//
//  Created by Yu-Chung, Yang on 12/12/22.
//  Copyright (c) 2012年 Yu-Chung, Yang. All rights reserved.
//

#import "DetailViewController.h"
#import "DataCenterViewController.h"
#import "Connector.h"
#import "SBJson.h"


@interface DetailViewController () {
    NSMutableArray *games;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
@synthesize refreshHeaderView;
@synthesize timer;
@synthesize reloading;
@synthesize indicator;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        
        // Each element in statuses is a single status
        // represented as a NSDictionary
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}


- (void)showDetailBK:(BasketballCell *)cell atSection:(int)section at:(int)row
{
  //  cell.textLabel.text = [[heroicaArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    NSDictionary *gameInfo = [[games objectAtIndex:section] objectAtIndex:row];
    //NSLog(@"%@", [gameInfo objectForKey:@"g_threshold"]);
    float run = [[gameInfo objectForKey:@"g_run_line"] floatValue];
    NSString *runline = (run > 0 ? [[NSString alloc] initWithFormat:@"+%.1f", run] : [[NSString alloc] initWithFormat:@"%.1f", run]);
    cell.odds1.text = [[NSString alloc] initWithFormat:@"%@客勝%@", runline, [gameInfo objectForKey:@"g_away_run_odds"]];
    run = -1 * [[gameInfo objectForKey:@"g_run_line"] floatValue];
    runline = (run > 0 ? [[NSString alloc] initWithFormat:@"+%.1f", run] : [[NSString alloc] initWithFormat:@"%.1f", run]);
    cell.odds2.text = [[NSString alloc] initWithFormat:@"%@主勝%@", runline, [gameInfo objectForKey:@"g_home_run_odds"]];
    cell.odds.text = (run > 0 ? [[NSString alloc] initWithFormat:@"主受讓%.1f", run] : [[NSString alloc] initWithFormat:@"主讓%.1f", -1*run]);
    NSString *threshold = [gameInfo objectForKey:@"g_threshold"];
    cell.gid.text = [gameInfo objectForKey:@"g_lottery_id"];
    cell.over.text = [[NSString alloc] initWithFormat:@"大小 %@", threshold];
    cell.pk1.text = [gameInfo objectForKey:@"g_away_odds"];
    cell.pk2.text = [gameInfo objectForKey:@"g_home_odds"];
    cell.teamName1.text = [[gameInfo objectForKey:@"away"] objectForKey:@"t_name"];
    cell.teamName2.text = [[gameInfo objectForKey:@"home"] objectForKey:@"t_name"];
    cell.over1.text = [[NSString alloc] initWithFormat:@"大%@", [gameInfo objectForKey:@"g_over"]];
    cell.over2.text = [[NSString alloc] initWithFormat:@"小%@", [gameInfo objectForKey:@"g_under"]];
    
    cell.home_score.text = [[gameInfo objectForKey:@"score"] objectForKey:@"g_h_score"];
    cell.away_score.text = [[gameInfo objectForKey:@"score"] objectForKey:@"g_a_score"];
    cell.lotteryDate.text = [gameInfo objectForKey:@"g_deadline"];
    
    NSString *period = [[gameInfo objectForKey:@"score"] objectForKey:@"g_period"];
    NSString *periodClock = [[gameInfo objectForKey:@"score"] objectForKey:@"g_period_clock"];
    NSString *status = [[gameInfo objectForKey:@"score"] objectForKey:@"g_status"];
    if ([status isEqualToString:@"FINAL"])
    {
        cell.gameStatus.text = @"FINAL";
    }
    else{
        cell.gameStatus.text = [[NSString alloc] initWithFormat:@"Q%@ %@", period, periodClock];
    }
    
}

- (void)showDetailFB:(BasketballCell *)cell atSection:(int)section at:(int)row
{
    NSDictionary *gameInfo = [[games objectAtIndex:section] objectAtIndex:row];
    
    NSString *threshold = [gameInfo objectForKey:@"g_threshold"];
    cell.gid.text = [gameInfo objectForKey:@"g_lottery_id"];
    cell.threshold.text = [[NSString alloc] initWithFormat:@"大小 %@", threshold];
    cell.teamName1.text = [[gameInfo objectForKey:@"home"] objectForKey:@"t_name"];
    cell.teamName2.text = [[gameInfo objectForKey:@"away"] objectForKey:@"t_name"];
    cell.home.text = [gameInfo objectForKey:@"g_home_odds"];
    cell.away.text = [gameInfo objectForKey:@"g_away_odds"];
    cell.tie.text = [gameInfo objectForKey:@"g_draw_odds"];
    cell.large.text = [gameInfo objectForKey:@"g_over"];
    cell.little.text = [gameInfo objectForKey:@"g_under"];
    cell.lotteryDate.text = [gameInfo objectForKey:@"g_deadline"];

    cell.odds.text = @"";
    cell.over.text = [[NSString alloc] initWithFormat:@"大小 %@", threshold];
    if ([gameInfo objectForKey:@"score"])
    {
        cell.home_score.text = [[gameInfo objectForKey:@"score"] objectForKey:@"g_h_score"];
        cell.away_score.text = [[gameInfo objectForKey:@"score"] objectForKey:@"g_a_score"];
    }
    else {
        cell.gameStatus.text = @"本賽事未支援";
    }
    
    return;
}

- (void)showDetailBB:(BasketballCell *)cell atSection:(int)section at:(int)row
{
    return;
}


- (void)getGameInfo
{
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];

    NSLog(@"reload");
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [self sportType], @"SportType", nil];
	
	Connector *connector = [[Connector alloc] initWithCommand:@"LIST"
													 andParam:param];
    
    // Create new SBJSON parser object
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSData *response = [connector connect];
  //  NSLog(@"%@", response);
    if (response == nil) return;
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSArray *statuses = [parser objectWithString:json_string error:nil];
    
    NSMutableArray *coming = [[NSMutableArray alloc] init];
    NSMutableArray *playing = [[NSMutableArray alloc] init];
    
    if (!games) {
        games = [[NSMutableArray alloc] init];
        for (NSDictionary *status in statuses)
        {
           //        NSLog(@"%@", status);
            NSString *lotteryStatus = [status objectForKey:@"lottery_status"];
            if ([lotteryStatus isEqualToString:@"OPEN"])
            {
                [coming insertObject:status atIndex:coming.count];
            }
            else
            {
                [playing insertObject:status atIndex:playing.count];
            }
        }
        games = [[NSMutableArray alloc] initWithObjects:coming, playing, nil];
        //[games addObjectsFromArray:playing];
    }
    else {
        [games removeAllObjects];
        for (NSDictionary *status in statuses)
        {
            //        NSLog(@"%@", status);
            NSString *lotteryStatus = [status objectForKey:@"lottery_status"];
            if ([lotteryStatus isEqualToString:@"OPEN"])
            {
                [coming insertObject:status atIndex:coming.count];
            }
            else
            {
                [playing insertObject:status atIndex:playing.count];
            }
        }
        games = [[NSMutableArray alloc] initWithObjects:coming, playing, nil];
        //[games addObjectsFromArray:playing];
       // [self.tableView reloadData];
    }
    
    [indicator stopAnimating];
    [self.tableView reloadData];
    return;
}

- (NSString *)sportType
{
    if ([[self.detailItem description] isEqualToString: @"籃球"])
        return @"bk";
    else if([[self.detailItem description] isEqualToString: @"足球"])
        return @"fb";
    else return @"bb";
}


- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
     //   self.detailDescriptionLabel.text = [self.detailItem description];
        self.navigationItem.title = [self.detailItem description];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self getGameInfo];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
  //  [self getGameInfo];
	// Do any additional setup after loading the view, typically from a nib.
    
    //設置timer
    timer = [NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(getGameInfo)
                                         userInfo:nil
                                          repeats:YES];
    //設置更新動畫
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    // 下拉更新
    if (refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, self.view.frame.size.width, self.view.bounds.size.height)];
        view.delegate = self;
        [self.view addSubview:view];
        refreshHeaderView = view;
    }
    // 更新時間
    [refreshHeaderView refreshLastUpdatedDate];
    
    [self configureView];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    reloading = YES;
}

- (void)doneLoadingTableViewData
{
    [self getGameInfo];
    reloading = NO;
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.view];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
// 滾動
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
// 滾動結束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
// 開始更新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
   // NSLog(@"egoRefreshTableHeaderDidTriggerRefresh");
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}
// 下拉中
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
   // NSLog(@"egoRefreshTableHeaderDataSourceIsLoading");
    return reloading; // should return if data source model is reloading
}
// 上次更新時間
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    //NSLog(@"egoRefreshTableHeaderDataSourceLastUpdated");
    return [NSDate date]; // should return date data source was last changed
}



/*
- (void)initNewObject: (NSMutableDictionary *)content
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:games.count inSection:0];
    
    //  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [games count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[games objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"尚未開賽";
            break;
            
        case 1:
            return @"已封盤";
            break;
            
        default:
            return @"";
            break;
    }
}


// this class decide which type of cells we want to show(basketball, football, or instant score)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([[self sportType] isEqualToString:@"bk"])
    {
        
      //  NSDictionary *gameInfo = games[indexPath.row];
        NSDictionary *gameInfo = [[games objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *lotteryStatus = [gameInfo objectForKey:@"lottery_status"];
        if ([lotteryStatus isEqualToString:@"OPEN"])
        {
            static NSString *CellIdentifier = @"BasketballCell";
            BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [self showDetailBK: cell atSection:indexPath.section at:indexPath.row];
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"InstantCell";
            BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            //[self showDetailBK: cell at:indexPath.row];
            [self showDetailBK: cell atSection:indexPath.section at:indexPath.row];

            return cell;
        }
    }
    else if ([[self sportType] isEqualToString:@"fb"])
    {
        //NSDictionary *gameInfo = games[indexPath.row];
        NSDictionary *gameInfo = [[games objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *lotteryStatus = [gameInfo objectForKey:@"lottery_status"];
        if ([lotteryStatus isEqualToString:@"OPEN"])
        {
            static NSString *CellIdentifier = @"FootballCell";
            BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [self showDetailFB: cell atSection:indexPath.section at:indexPath.row];
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"InstantCell";
            BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [self showDetailFB: cell atSection:indexPath.section at:indexPath.row];
            return cell;
        }

    }
    else
    {
        static NSString *CellIdentifier = @"BaseballCell";
        BasketballCell *cell = (BasketballCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BasketballCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [self showDetailBB: cell atSection:indexPath.section at:indexPath.row];
        return cell;

    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   NSLog(@"%@", indexPath);
    //檢測網路連線
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkCheck" object:nil];
    
    NSDictionary *game = [[games objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.dataCenterViewController.detailItem = game;
    }
    else
    {
        //透過標簽取得目標實體
         self.dataCenterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DataCenter"];
        //傳遞參數
        [self.dataCenterViewController setDetailItem:game type:[self sportType]];
        //切換畫面
        [self.navigationController pushViewController:self.dataCenterViewController animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSLog(@"come on");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }*/
}



/*
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}*/

@end
