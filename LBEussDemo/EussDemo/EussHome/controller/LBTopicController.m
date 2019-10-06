//
//  LBTopicController.m
//  EussDemo
//
//  Created by mc on 2019/10/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBTopicController.h"

#import "LBTopicModel.h"
#import "LBTopicCell.h"

#import "LBCommentController.h"

@interface LBTopicController ()

@property (nonatomic,strong) NSMutableArray *topics;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *maxtime;

@property (nonatomic,strong)NSDictionary *params;

@end

@implementation LBTopicController

static NSString *topicID = @"topic";


- (NSString*)type{
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topics = [NSMutableArray array];
    
    self.view.backgroundColor = SystemGlobaBG;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 49, 0);
    
    [self setUPRefirsh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LBTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}



- (void)setUPRefirsh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadJsonWeatherData2)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTops)];
    
    
}

- (void)loadMoreTops{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    self.currentPage++;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    parameters[@"page"] = @(self.currentPage);
    parameters[@"maxtime"] = self.maxtime;
    self.params = parameters;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",responseObject);
        
        if(self.params != parameters){
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        NSArray * topicnewList = [LBTopicModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"list"]];
        self.maxtime = [[responseObject objectForKey:@"info"]objectForKey:@"maxtime"];
        
        [self.topics addObjectsFromArray:topicnewList];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        self.currentPage-- ;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
}

-(void)loadJsonWeatherData2
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = self.type;
    
    self.params = parameters;
    
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(self.params != parameters){
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        self.currentPage = 0;
        self.topics = [LBTopicModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"list"]];
        
       // NSLog(@"%@",responseObject);
        //        [self.topics removeAllObjects];
        //        [self.topics addObjectsFromArray:topicnewList];
        
        self.maxtime = [[responseObject objectForKey:@"info"]objectForKey:@"maxtime"];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LBCommentController *VC  = [[LBCommentController alloc]init];
    VC.topicModel = self.topics[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //图片高度
    //CGFloat textY = 55;
    //文字的高度
    LBTopicModel *topic = self.topics[indexPath.row];
//    CGFloat textH = [topic.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
//   // CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size].height;
//
//   CGFloat textH = [topic.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//    //10 指的是底部工具条的间距 第二个10指的是减去的间距
//    CGFloat cellH = textY + textH + 44 + 10 + 10;
    
    
    return topic.cellHeight;
}


@end
