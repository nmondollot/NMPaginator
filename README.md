# NMPaginator

NMPaginator is a simple Objective-C class that handles pagination for you. 
It makes it easy to display results from API webservices that take `page` and `per_page` parameters.

e.g. Flickr API :

```
http://api.flickr.com/services/rest/?method=flickr.photos.search&text=beach&per_page=20&page=2
```

The demo project also includes a UITableView that automatically loads the next page of results as you scroll down.

## Example

![NMPaginator with Flickr API](http://f.cl.ly/items/2E0i403V403n1j2y1C1Z/NMPaginator_screenshot.png) 

## How to install

### With Cocoapods

Add this to your Podfile:
```
pod 'NMPaginator', '~> 1.0.0'
```

For more information on how to set up Cocoapods, check out the [official site](http://cocoapods.org/#get_started).

### Manually

Copy `NMPaginator.h` and `NMPaginator.m` to your project. That's it.

## How to use

### Custom Paginator Class

You need to sublass NMPaginator and implement the `fetchResultsWithPage:pageSize:` method : 

```objective-c
// MyPaginator.h
#import <Foundation/Foundation.h>
#import "NMPaginator.h"
@interface MyPaginator : NMPaginator
@end

// MyPaginator.m
#import "MyPaginator.h"
@implementation MyPaginator
- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    // you code goes here
    // once you receive the results for the current page, just call [self receivedResults:results total:total];
}
@end
```

### ViewController

In your ViewController header file, conform to `NMPaginatorDelegate` protocol and add a property for the paginator :
```objective-c
// ViewController.h
@interface ViewController () <NMPaginatorDelegate>
@property (nonatomic, strong) MyPaginator *paginator;
@end
```

In your ViewController implementation file, instantiate the paginator in viewDidLoad (for instance) :

```objective-c
// ViewController.m
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPaginator = [[MyPaginator alloc] initWithPageSize:10 delegate:self];
}
```

And ask for results like this :

```objective-c
// ViewController.m
[self.myPaginator fetchNextPage];
```
    
You will get the results through the delegate method :

```objective-c
// ViewController.m
- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results 
{
    // handle new results
}
```

To make the UITableView work, please have a look at the demo project.

## Credits

My name is Nicolas Mondollot, you can follow me on [twitter](http://www.twitter.com/nmondollot).

To demonstrate NMPaginator, I used the FlickFetcher class from the great
[Stanford CS193P course](http://www.stanford.edu/class/cs193p/cgi-bin/drupal/downloads-2010-fall).

## License

Do whatever you want with this piece of code (commercially or free). Attribution would be nice though.
