//
//  ViewController.m
//  MasonryDemo
//
//  Created by dengtao on 2017/7/17.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#define MasonryTableViewCellIdentifier @"MasonryTableViewCell"

@interface MasonryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (void)configDataWithModel:(NSDictionary *)model;

@end


@implementation MasonryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(15, 20, 15, 15));
        }];
        
    }
    return self;
}

- (void)configDataWithModel:(NSDictionary *)model{

    self.titleLabel.text = @"实现代码：";
}

@end



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *yellowView;
@property (strong, nonatomic) UIView *blueView;

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UITableView  *tableView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MasonryDemo";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.yellowView];
    [self.view addSubview:self.redView];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
    
//    [self subViewsEqualHeight];
//    [self subViewsAlignmentCenter];
    
//    [self setUpTableView];
    [self setUpScrollView];
//    [self setupUI];
}


//子视图等高
- (void)subViewsEqualHeight{

    
    
    /**
     下面的例子是通过给equalTo()方法传入一个数组，设置数组中子视图及当前make对应的视图之间等高。
     
     需要注意的是，下面block中设置边距的时候，应该用insets来设置，而不是用offset。
     因为用offset设置right和bottom的边距时，这两个值应该是负数，所以如果通过offset来统一设置值会有问题。
     */
    CGFloat padding = 10;
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(64 + 10, padding, 0, padding));
        make.bottom.equalTo(self.blueView.mas_top).offset(-padding);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
        make.bottom.equalTo(self.yellowView.mas_top).offset(-padding);
    }];
    
    /**
     下面设置make.height的数组是关键，通过这个数组可以设置这三个视图高度相等。其他例如宽度之类的，也是类似的方式。
     */
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
        make.height.equalTo(@[self.blueView, self.redView]);
    }];
}

//子视图垂直居中
- (void)subViewsAlignmentCenter{

    /**
     要求：(这个例子是在其他人博客里看到的，然后按照要求自己写了下面这段代码)
     两个视图相对于父视图垂直居中，并且两个视图以及父视图之间的边距均为10，高度为150，两个视图宽度相等。
     */
    CGFloat padding = 10.f;
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(padding);
        make.right.equalTo(self.redView.mas_left).mas_offset(-padding);
        make.width.equalTo(self.redView);
        make.height.mas_equalTo(150);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).mas_offset(-padding);
        make.width.equalTo(self.blueView);
        make.height.mas_equalTo(150);
    }];
}

- (void)setupUI{

    
    
    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {

        //方法一：
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(10 + 64, 10, 10, 10));
        
        //方法二：
        
//        make.left.equalTo(self.view).with.offset(10);
//        make.top.equalTo(self.view).with.offset(10 + 64);
//        make.right.equalTo(self.view).with.offset(-10);
//        make.bottom.equalTo(self.view).with.offset(-10);
        
    }];
    
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    [self.view addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // 设置宽度小于等于200
        make.width.lessThanOrEqualTo(@200);
        // 设置高度大于等于10
        make.height.greaterThanOrEqualTo(@(10));
    }];
    
    self.textLabel.text = @"这是测试的字符串。能看到1、2、3个步骤，第一步当然是上传照片了，要上传正面近照哦。上传后，网站会自动识别你的面部，如果觉得识别的不准，你还可以手动修改一下。左边可以看到16项修改参数，最上面是整体修改，你也可以根据自己的意愿单独修改某项，将鼠标放到选项上面，右边的预览图会显示相应的位置。";
    [self.textLabel layoutIfNeeded];
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    // 设置当前约束值乘以多少，例如这个例子是redView的宽度是self.view宽度的0.2倍。
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.view).multipliedBy(0.2);
    }];

    
}

//更新约束
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // 设置greenView的center和size，这样就可以达到简单进行约束的目的
    [self.blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // 这里通过mas_equalTo给size设置了基础数据类型的参数，参数为CGSize的结构体
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    // 为了更清楚的看出约束变化的效果，在显示两秒后更新约束。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.blueView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).offset(100);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    });
}

//添加tableView约束
- (void)setUpTableView{

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64 + 10, 10, 10, 10));
    }];
}

//添加ScrollView约束
- (void)setUpScrollView{

    // 提前设置好UIScrollView的contentSize，并设置UIScrollView自身的约束
    self.scrollView.contentSize = CGSizeMake(1000, 1000);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64 + 10, 10, 10, 10));
    }];
    
    // 虽然redView的get方法内部已经执行过addSubview操作，但是UIView始终以最后一次添加的父视图为准，也就是redView始终是在最后一次添加的父视图上。
    [self.scrollView addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.width.height.mas_equalTo(200);
    }];
    
    [self.scrollView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right);
        make.top.equalTo(self.scrollView);
        make.width.height.equalTo(self.redView);
    }];
    
    [self.scrollView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.redView.mas_bottom);
        make.width.height.equalTo(self.redView);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (MasonryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasonryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MasonryTableViewCellIdentifier];
    [cell configDataWithModel:nil];
    return cell;
}

// 需要注意的是，这个代理方法和直接返回当前Cell高度的代理方法并不一样。
// 这个代理方法会将当前所有Cell的高度都预估出来，而不是只计算显示的Cell，所以这种方式对性能消耗还是很大的。
// 所以通过设置estimatedRowHeight属性的方式，和这种代理方法的方式，最后性能消耗都是一样的。
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}


#pragma mark - Setter/Getter

- (UIScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor greenColor];
    }
    return _scrollView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置tableView自动高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[MasonryTableViewCell class] forCellReuseIdentifier:MasonryTableViewCellIdentifier];
        
    }
    return _tableView;
}


- (UIView *)blueView{

    if (_blueView == nil) {
        
        _blueView = [UIView new];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)redView{
    
    if (_redView == nil) {
        
        _redView = [UIView new];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)yellowView{
    
    if (_yellowView == nil) {
        
        _yellowView = [UIView new];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

