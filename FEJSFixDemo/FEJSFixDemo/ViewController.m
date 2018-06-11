//
//  ViewController.m
//  FEJSFixDemo
//
//  Created by FlyElephant on 2018/6/11.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIButton *jsButtton;
@property (strong, nonatomic) UIButton *ocButtton;
@property (strong, nonatomic) UIButton *crashButtton;
@property (strong, nonatomic) UIButton *beforeButtton;
@property (strong, nonatomic) UIButton *afterButtton;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    self.context = [[JSContext alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
//    [self testAspects];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewController viewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testAspects {
    [self aspect_hookSelector:@selector(ocCallJSAction:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"AspectPositionBefore ocCallJSAction---%@: %@", aspectInfo.instance, aspectInfo.arguments);
    } error:NULL];
    [self aspect_hookSelector:@selector(ocCallJSAction:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"AspectPositionAfter ocCallJSAction---%@: %@", aspectInfo.instance, aspectInfo.arguments);
    } error:NULL];
}

- (void)ocCallJSAction:(UIButton *)button {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"ocCallJS" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:jsString];
    JSValue *res = [self.context[@"add"] callWithArguments:@[@7, @25]];
    NSLog(@"ocCallJSAction add result---%@", @([res toInt32]));
}

- (void)jsCallOCAction:(UIButton *)button {
    self.context[@"addNumber"] = ^(NSInteger a, NSInteger b) {
        NSLog(@"jsCallOCAction  res---%@", @(a + b));
    };
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"jsCallOC" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:jsString];
}

- (void)crashAction:(UIButton *)button {
    [self mightCrashMethod:nil];
    [self mightCrashMethod:@"data"];
}

- (void)mightCrashMethod:(NSString *)str {
    [self.dataSource addObject:str];
}

- (void)beforeInstanceMethod:(NSString *)str num:(int)num {
    NSLog(@"beforeInstanceMethod: str=%@, param=%i",str,num);
}

- (void)beforeAction:(UIButton *)button {
     NSLog(@"viewcontroller beforeAction");
}

- (void)afterAction:(UIButton *)button {
    NSLog(@"viewcontroller afterAction");
}

- (void)afterInstanceMethod:(NSString *)str num:(int)num {
    NSLog(@"afterInstanceMethod: str=%@, param=%i",str,num);
}

- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return button;
}

- (void)setupUI {
    self.jsButtton = [self createButton];
    self.jsButtton.frame = CGRectMake(50, 80, 300, 50);
    [self.jsButtton setTitle:@"oc callback js" forState:UIControlStateNormal];
    [self.jsButtton addTarget:self action:@selector(ocCallJSAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.jsButtton];
    
    self.ocButtton = [self createButton];
    self.ocButtton.frame = CGRectMake(50, 150, 300, 50);
    [self.ocButtton setTitle:@"js callback oc" forState:UIControlStateNormal];
    [self.ocButtton addTarget:self action:@selector(jsCallOCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ocButtton];
    
    self.crashButtton = [self createButton];
    self.crashButtton.frame = CGRectMake(50, 220, 300, 50);
    [self.crashButtton setTitle:@"crash demo" forState:UIControlStateNormal];
    [self.crashButtton addTarget:self action:@selector(crashAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.crashButtton];
    
    self.beforeButtton = [self createButton];
    self.beforeButtton.frame = CGRectMake(50, 290, 300, 50);
    [self.beforeButtton setTitle:@"before jsCallOCAction" forState:UIControlStateNormal];
    [self.beforeButtton addTarget:self action:@selector(beforeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beforeButtton];
    
    self.afterButtton = [self createButton];
    self.afterButtton.frame = CGRectMake(50, 350, 300, 50);
    [self.afterButtton setTitle:@"after jsCallOCAction" forState:UIControlStateNormal];
    [self.afterButtton addTarget:self action:@selector(afterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.afterButtton];
}


@end
