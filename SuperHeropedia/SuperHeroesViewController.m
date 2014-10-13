//
//  ViewController.m
//  SuperHeropedia
//
//  Created by Eduardo Alvarado Díaz on 10/13/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "SuperHeroesViewController.h"

@interface SuperHeroesViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *superHeroes;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SuperHeroesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);

        NSError *jsonError = nil;
        self.superHeroes = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        [self.tableView reloadData];

        NSLog(@"Connection error: %@", connectionError);
        NSLog(@"JSON error: %@", jsonError);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.superHeroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID" forIndexPath:indexPath];

    NSDictionary *superHero = [self.superHeroes objectAtIndex:indexPath.row];

    cell.textLabel.text = [superHero objectForKey:@"name"];
    cell.detailTextLabel.text = [superHero objectForKey:@"description"];

    return cell;
}

@end
