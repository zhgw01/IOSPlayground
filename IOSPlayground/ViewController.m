//
//  ViewController.m
//  IOSPlayground
//
//  Created by Gongwei on 15/3/18.
//  Copyright (c) 2015年 Gongwei. All rights reserved.
//

#import "ViewController.h"
#import "SectionModel.h"
#import "ItemModel.h"
#import <STCollapseTableView.h>
#import <Mantle.h>

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
    
    self.data = [[NSMutableArray alloc] init];
    self.headers = [[NSMutableArray alloc] init];
    
    [self loadJsonFile];
    
    for (int i = 0 ; i < [self.data count] ; i++)
    {
        SectionModel* sectionModel = [self.data objectAtIndex:i];
        UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        header.text = sectionModel.section;
        header.textAlignment = NSTextAlignmentCenter;
        
        [self.headers addObject:header];
    }
}

- (void) loadJsonFile
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"examples" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:filePath];
    if (jsonData) {
        NSError* error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"Couldn't deserealize app info data into JSON from NSData: %@", error);
            return;
        }
        
        NSArray* sections = [MTLJSONAdapter modelsOfClass:[SectionModel class] fromJSONArray:jsonArray error:&error];
        if (error) {
            NSLog(@"Couldn't deserializing sections from NSData: %@", error);
            return;
        }
        
        [self.data addObjectsFromArray:sections];
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
    SectionModel* sectionModel = [self.data objectAtIndex: section];
    return [sectionModel.items count];
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
    
    SectionModel* sectionModel = [self.data objectAtIndex: indexPath.section];
    ItemModel* itemModel = [sectionModel.items objectAtIndex:indexPath.row];
    
    NSString* text = itemModel.name;
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel* sectionModel = [self.data objectAtIndex: indexPath.section];
    ItemModel* itemModel = [sectionModel.items objectAtIndex:indexPath.row];
    
    UIViewController* controller = [NSClassFromString(itemModel.controller) new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}

@end
