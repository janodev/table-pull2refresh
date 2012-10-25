
// BSD License. Created by jano@jano.com.es

#import "PullView.h"
#import <QuartzCore/QuartzCore.h>

@interface PullToRefreshVC : UITableViewController {
    PullView *_pullView;  // "pull to refresh" view above the table
}

/* The user pulled down the "pull to refresh" view.
 * @param visibility Float going from 0 (not visible) to 1 (fully visible).
 */
-(void) didPullToVisibility:(CGFloat)visibility;

@end
