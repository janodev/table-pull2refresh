
// BSD License. Created by jano@jano.com.es

#import "TableVC.h"

@interface TableVC ()
@property (nonatomic, strong) NSArray *objects;
@end


@implementation TableVC

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath
{
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.1*NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    });
}

#pragma mark - UIViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.objects = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
}


@end























