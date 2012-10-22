
// BSD License. Created by jano@jano.com.es

#import "PullToRefreshFoldVC.h"

@implementation PullToRefreshFoldVC


// as the content offset goes from 0...-kRefreshViewHeight we call here with visibility 0...1
- (void)foldToVisibility:(CGFloat)visibility
{
    // Rotating 90º-arcsin(visibility) when visibility is 0...1 means we rotate 90º...0º, because arcsin(0)=0º and arcsin(1)=90º.
    // We are rotating in the x-axis because x,y,z is 1,0,0.
    // To imagine an object rotating in the x-axis, imagine the axis physically going through the object.
    // The end result is that the view starts rotated 90º in the x-axis, therefore not visible (assuming the edge shows as height 0),
    // and rotates to 0º where there is no change from what it would be a normal view.
    [_pullView.bottomLabel.layer setTransform:CATransform3DMakeRotation((M_PI / 2) - asinf(visibility), 1, 0, 0)];
    
    // this is rotating from 0º...90º + 270º, (270 is 180º*3/2) so that's 270º...360º, which is going to 0º in the opposite direction.
    [_pullView.topLabel.layer setTransform:CATransform3DMakeRotation(asinf(visibility) + (((M_PI) * 3) / 2) , 1, 0, 0)];
    
    // decrease the origin.y from kRefreshViewHeight to 0
    [_pullView.topLabel setFrame:CGRectMake(0, kPullViewHeight * (1 - visibility), self.view.bounds.size.width, kPullViewHeight / 2)];
    
    [_pullView.bottomLabel setFrame:CGRectMake(0, kPullViewHeight/2, self.view.bounds.size.width, kPullViewHeight / 2)];
}


-(void) didPullToVisibility:(CGFloat)visibility {
    [super didPullToVisibility:visibility];
    [self foldToVisibility:visibility];
}


-(void) viewDidLoad {
    [super viewDidLoad];
    
    // Set the points where we apply the transformation
    // See http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/CoreAnimation_guide/Articles/Layers.html#//apple_ref/doc/uid/TP40006082-SW9
    _pullView.topLabel.layer.anchorPoint = CGPointMake(0.5, 0.0);    // middle top
    _pullView.bottomLabel.layer.anchorPoint = CGPointMake(0.5, 1.0); // middle bottom
    
    // Add perspective to every sublayer.
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    [_pullView.layer setSublayerTransform:transform];
    
    // About m34:
    //   http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/CoreAnimation_guide/Articles/Layers.html#//apple_ref/doc/uid/TP40006082-SW9
    //   http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/CoreAnimation_guide/Articles/Layers.html#//apple_ref/doc/uid/TP40006082-SW1
    //   https://itunes.apple.com/us/app/perspectivetest/id481006743
    //   http://milen.me/technical/core-animation-3d-model/
    //   http://www.songho.ca/opengl/gl_transform.html
    // enjoy!
}


@end
