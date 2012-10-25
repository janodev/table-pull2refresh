
// BSD License. Created by jano@jano.com.es

#import "PullView.h"

@implementation PullView

-(void) awakeFromNib {
    _topLabel.text = NSLocalizedString(@"pull2view.pull.to.refresh", nil);
    _bottomLabel.text = [NSString stringWithFormat:@"%@: %@",
                         NSLocalizedString(@"pull2view.last.updated", nil),
                         NSLocalizedString(@"pull2view.last.updated.never",nil)];
}

@end
