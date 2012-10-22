
// BSD License. Created by jano@jano.com.es

#import "PullToRefreshVC.h"


@interface PullToRefreshVC()
@property (nonatomic, assign) BOOL isRefreshing;       // true when the table is refreshing
@property (nonatomic, strong) UIView *backgroundView;  // background behind the table
@end


@implementation PullToRefreshVC


// Change the arrow and text of the "pull to refresh" view when the user pulls down.
-(void) didPullToVisibility:(CGFloat)visibility
{
    static bool wasFullyVisible = false;
    bool isFullyVisible = floorf(visibility);
    bool valueChanged = wasFullyVisible ^ isFullyVisible;
    if (valueChanged){
        
        // rotate the arrow up if the view is fully visible, or down otherwise
        wasFullyVisible = isFullyVisible;
        [UIView animateWithDuration:0.2 animations:^{
            CGFloat angle = (int)wasFullyVisible * M_PI; // value is 0 or PI
            [_pullView.bottomArrow layer].transform = CATransform3DMakeRotation(angle, 0, 0, 1);
        }];
        
        // update the text
        _pullView.topLabel.text = isFullyVisible ? NSLocalizedString(@"release.to.refresh", nil) : NSLocalizedString(@"pull.to.refresh", nil);
    }
}


// Refresh the data
-(void) refresh {
    
    self.isRefreshing = TRUE;
    
    // change text, show the refreshing arrow, hide the "pull up/down" arrow
    _pullView.topLabel.text = NSLocalizedString(@"refreshing",nil);
    _pullView.topArrow.hidden = false;
    _pullView.bottomArrow.hidden = true;
    
    // add an inset on top so the pullView above the table stays visible
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setContentInset:UIEdgeInsetsMake(kPullViewHeight, 0, 0, 0)];
    }];
    
    // infinite rotation
    CATransform3D rotationTransform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1.0);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    rotationAnimation.duration = 0.15f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [_pullView.topArrow.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    // 3 seconds delay to simulate a refresh
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        
        // set the refresh date 
        static dispatch_once_t onceToken;
        static NSDateFormatter *dateFormatter;
        dispatch_once(&onceToken, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dateFormatter setLocale:usLocale];
        });
        _pullView.bottomLabel.text = [NSString stringWithFormat:@"%@: %@.",
                                      NSLocalizedString(@"last.updated",nil),
                                      [dateFormatter stringFromDate:[NSDate date]]];
        
        // hide top arrow, remove animation, and restore angle
        _pullView.topArrow.hidden = true;
        [_pullView.topArrow.layer removeAllAnimations];
        [_pullView.topArrow layer].transform = CATransform3DMakeRotation(0, 0, 0, 1);
        
        self.isRefreshing = FALSE;
        
        // hide the inset
        [UIView animateWithDuration:0.3 animations:^{
            [self.tableView setContentInset:UIEdgeInsetsZero];
        }completion:^(BOOL finished) {
            _pullView.bottomArrow.hidden = false;
        }];
        
    });
}


#pragma mark - UIViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    // add the "pull to refresh" view above the table
    CGRect rect = CGRectMake(0, -kPullViewHeight, self.view.frame.size.width, kPullViewHeight);
    _pullView = [[PullView alloc] initWithFrame:rect];
    _pullView.bottomLabel.text = [NSString stringWithFormat:@"%@: %@.", NSLocalizedString(@"last.updated",nil), NSLocalizedString(@"never",nil)];
    _pullView.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:_pullView];
    
    // table background
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.backgroundView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self.tableView insertSubview:self.backgroundView belowSubview:_pullView];
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // update the "pull to refresh" view if it is visible and not already refreshing
    bool isVisible = scrollView.contentOffset.y<0;
    if (isVisible && !self.isRefreshing) {
        CGFloat visibility = MIN(1.0, scrollView.contentOffset.y/-kPullViewHeight);
        [self didPullToVisibility:visibility];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // refresh if the user dragged all the way down, unless it is already refreshing
    bool isFullyVisible = scrollView.contentOffset.y < -kPullViewHeight;
    if (isFullyVisible && !self.isRefreshing){
        [self refresh];
    }
}


@end
