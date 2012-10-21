
// BSD License. Created by jano@jano.com.es

@interface PullView : UIView

@property (nonatomic,strong) UIView  *topView;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UIImageView *topArrow;
@property (nonatomic,strong) UIImageView *bottomArrow;

@property (nonatomic,strong) UIView  *bottomView;
@property (nonatomic,strong) UILabel *bottomLabel;

@end
