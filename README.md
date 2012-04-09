#NMPaginator

NMPaginator is a simple Objective-C class that handles pagination for you. 

It makes it easy to display results from API webservices that take `page` and `per_page` parameters.

e.g. Flickr API :

	http://api.flickr.com/services/rest/?method=flickr.photos.search&text=beach&per_page=20&page=2

In this test project, we use the paginator to display the results in a UITableView that automatically loads the next page of results as you scroll down.

##How to use it

You need to sublass NMPaginator and implement the following method : 

	// MyPaginator.m
	- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize { ... }

Once you receive the results from the API, you just need to call `[self receivedResults:results total:total]` and NMPaginator takes care of the rest.

In your ViewController, you instantiate the paginator like this :

	// ViewController.m
	self.myPaginator = [[MyPaginator alloc] initWithPageSize:10 delegate:self];

And ask for results like this :

    // ViewController.m
    [self.myPaginator fetchNextPage];
    
You will get the results through the delegate method :

	// ViewController.m
	- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results 
	{
		// handle new results
	}

##Screenshots

![NMPaginator with Flickr API](http://cl.ly/1p1R3Z0C1j2L3R411R1D) 

##Credits

My name is Nicolas Mondollot, you can follow me on [twitter](http://www.twitter.com/nmondollot).

To demonstrate NMPaginator, I used the FlickFetcher class from the great
[Stanford CS193P course](http://www.stanford.edu/class/cs193p/cgi-bin/drupal/downloads-2010-fall).

##License

Do whatever you want with this piece of code (commercially or free). Attribution would be nice though.
