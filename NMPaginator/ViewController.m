//
//  ViewController.m
//  NMPaginator
//
//  Created by Nicolas Mondollot on 08/04/12.
//

#import "ViewController.h"
#import "YoutubeAPIKey.h"
#import "YoutubeFetcher.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize flickrPaginator = _flickPaginator;
@synthesize footerLabel = _footerLabel;
@synthesize activityIndicator = _activityIndicator;
@synthesize youtubePaginator = _youtubePaginator;


- (void)viewDidLoad
{
	[super viewDidLoad];

	// in case you don't read the readme file
	if ([YoutubeAPIKey length] == 0) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Empty API key" message:@"You need to set you Youtube API key in YoutubeAPIKey.h to test this app" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alertView show];
	}

	self.title = @"Youtube Videos";

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearButtonPressed:)];

	[self setupTableViewFooter];

	// set up the paginator
	self.youtubePaginator = [[YoutubePaginator alloc] initWithPageSize:15 delegate:self];
	[self.youtubePaginator fetchFirstPage];
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

#pragma mark - Actions

- (void)fetchNextPage
{
	[self.youtubePaginator fetchNextPage];
	[self.activityIndicator startAnimating];
}


- (void)setupTableViewFooter
{
	// set up label
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	footerView.backgroundColor = [UIColor clearColor];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	label.font = [UIFont boldSystemFontOfSize:16];
	label.textColor = [UIColor lightGrayColor];
	label.textAlignment = UITextAlignmentCenter;

	self.footerLabel = label;
	[footerView addSubview:label];

	// set up activity indicator
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(40, 22);
	activityIndicatorView.hidesWhenStopped = YES;

	self.activityIndicator = activityIndicatorView;
	[footerView addSubview:activityIndicatorView];

	self.tableView.tableFooterView = footerView;
}


- (void)updateTableViewFooter
{
	if ([self.youtubePaginator.results count] != 0) {
		self.footerLabel.text = [NSString stringWithFormat:@"%d results out of %d", [self.youtubePaginator.results count], self.youtubePaginator.total];
	} else {
		self.footerLabel.text = @"";
	}

	[self.footerLabel setNeedsDisplay];
}


- (void)clearButtonPressed:(id)sender
{
	[self.youtubePaginator fetchFirstPage];
}

#pragma mark - Paginator delegate methods

- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results
{
	// update tableview footer
	[self updateTableViewFooter];
	[self.activityIndicator stopAnimating];

	// update tableview content
	// easy way : call [tableView reloadData];
	// nicer way : use insertRowsAtIndexPaths:withAnimation:
	NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
	NSInteger i = [self.youtubePaginator.results count] - [results count];

	for (NSDictionary *result in results) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
		i++;
	}

	[self.tableView beginUpdates];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
	[self.tableView endUpdates];
}


- (void)paginatorDidReset:(id)paginator
{
	[self.tableView reloadData];
	[self updateTableViewFooter];
}


- (void)paginatorDidFailToRespond:(id)paginator
{
	// Todo
}

#pragma mark - TableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellId = @"CellID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
	}

	NSDictionary *youtubeInfo = [self.youtubePaginator.results objectAtIndex:(NSUInteger) indexPath.row][@"snippet"];
	NSString *title = [youtubeInfo objectForKey:YOUTUBE_VIDEO_TITLE];
	if ([title length] == 0) title = @"<no title>";
	cell.textLabel.text = title;

	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.youtubePaginator.results count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

	// when reaching bottom, load a new page
	if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height) {
		// ask next page only if we haven't reached last page
		if (![self.youtubePaginator reachedLastPage]) {
			// fetch next page of results
			[self fetchNextPage];
		}
	}
}

@end
