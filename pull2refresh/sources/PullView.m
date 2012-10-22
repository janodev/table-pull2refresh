
// BSD License. Created by jano@jano.com.es

#import "PullView.h"

@implementation PullView


- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectIntegral(frame);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat halfHeight = frame.size.height/2;
        
        frame = CGRectMake(0, 0, frame.size.width, halfHeight);
        _topLabel = [[UILabel alloc] initWithFrame:frame];
        _topLabel.backgroundColor = [UIColor colorWithRed:0.877 green:0.684 blue:1.000 alpha:1.000];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        frame = CGRectMake(0, halfHeight, frame.size.width, halfHeight);
        _bottomLabel = [[UILabel alloc] initWithFrame:frame];
        _bottomLabel.backgroundColor = [UIColor colorWithRed:0.675 green:0.862 blue:0.518 alpha:1.000];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        UIImage *icon = [UIImage imageNamed:@"refresh-arrow"];
        _topArrow = [[UIImageView alloc] initWithImage:icon];
        CGFloat padding = floorf((frame.size.height-icon.size.height)/2);
        _topArrow.frame = CGRectMake(padding, padding, icon.size.width, icon.size.height);
        _topArrow.hidden = true;
        [_topLabel addSubview:_topArrow];
        
        icon = [UIImage imageNamed:@"down-arrow"];
        _bottomArrow = [[UIImageView alloc] initWithImage:icon];
        padding = floorf((frame.size.height-icon.size.height)/2);
        _bottomArrow.frame = CGRectMake(padding, padding, icon.size.width, icon.size.height);
        [_bottomLabel addSubview:_bottomArrow];
        
        [self addSubview:_topLabel];
        [self addSubview:_bottomLabel];
    }
    
    return self;
}

@end
