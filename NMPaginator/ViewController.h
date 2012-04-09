//
//  ViewController.h
//  NMPaginator
//
//  Created by Nicolas Mondollot on 08/04/12.
//

#import <UIKit/UIKit.h>
#import "FlickrPaginator.h"

@interface ViewController : UIViewController<NMPaginatorDelegate, UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FlickrPaginator *flickrPaginator;

@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
