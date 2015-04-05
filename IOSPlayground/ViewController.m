//
//  ViewController.m
//  IOSPlayground
//
//  Created by Gongwei on 15/3/18.
//  Copyright (c) 2015年 Gongwei. All rights reserved.
//

#import "ViewController.h"
#import <STCollapseTableView.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet STCollapseTableView *tableView;

@property (strong, nonatomic) NSMutableArray* data;
@property (strong, nonatomic) NSMutableArray* headers;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupViewController];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViewController];
    }
    
    return self;
}

- (void)setupViewController
{
    NSArray* colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]];
    
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < 3 ; j++)
        {
            [section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
        }
        [self.data addObject:section];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [colors count] ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[colors objectAtIndex:i]];
        [self.headers addObject:header];
    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView reloadData];
    [self.tableView openSection:0 animated:NO];
}

#pragma mark - table view datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.data count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
}

#pragma mark - tablew view data delegate

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"collpaseCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}

@end
