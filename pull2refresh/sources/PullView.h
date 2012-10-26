
// BSD License. Created by jano@jano.com.es

@interface PullView : UIView

@property (nonatomic,weak) IBOutlet UIView *topView;
@property (nonatomic,weak) IBOutlet UILabel *topLabel;
@property (nonatomic,weak) IBOutlet UIImageView *topArrow;

@property (nonatomic,weak) IBOutlet UIView *bottomView;
@property (nonatomic,weak) IBOutlet UILabel *bottomLabel;
@property (nonatomic,weak) IBOutlet UIImageView *bottomArrow;

@end
