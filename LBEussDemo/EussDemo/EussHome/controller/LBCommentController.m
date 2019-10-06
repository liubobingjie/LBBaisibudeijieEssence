//
//  LBCommentController.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBCommentController.h"
#import "LBTopicCell.h"
#import "LBCommentModel.h"
#import "LBCommentHeaderView.h"

#import "LBComentViewCell.h"

@interface LBCommentController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonSpace;

/** 保存帖子的top_cmt */
@property (nonatomic, strong)  LBCommentModel*saved_top_cmt;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *maxtime;

@property (nonatomic,strong)NSDictionary *params;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;


@end

 static NSString * commentID = @"comment";

@implementation LBCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
   
    self.latestComments = [NSMutableArray array];
    self.view.backgroundColor = SystemGlobaBG;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
  
    
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setupHead];
    [self setupRefresh];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LBComentViewCell class ]) bundle:nil] forCellReuseIdentifier:commentID];
    
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadMoreComment{
    NSInteger page = self.currentPage + 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicModel.ID;
     parameters[@"page"] = @(page);
    LBCommentModel *com = self.latestComments.lastObject;
    
     parameters[@"lastcid"] =  com.ID;
    self.params = parameters;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
       // NSLog(@"%@",responseObject);
        
        if(self.params != parameters){
            return ;
        }
        self.currentPage = self.currentPage + 1;
       // self.hotComments = [LBCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        NSArray *dic = responseObject;
        if(dic.count == 0||[responseObject objectForKey:@"data"] == nil){
             self.tableView.mj_footer.hidden = YES;
            return;
        }
        NSArray *arr = responseObject[@"data"];
        if(arr.count>0){
            NSArray *newComet = [LBCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            [self.latestComments addObjectsFromArray:newComet];
        }
        
        [self.tableView reloadData];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if(self.latestComments.count>= total){
            self.tableView.mj_footer.hidden = YES;
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
     
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)loadNewComment{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
 
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicModel.ID;
    parameters[@"hot"] = @"1";
    self.params = parameters;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
       // NSLog(@"%@",responseObject);
        
        if(self.params != parameters){
            return ;
        }
        self.currentPage = 1;
        self.hotComments = [LBCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latestComments = [LBCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if(self.latestComments.count>= total){
            self.tableView.mj_footer.hidden = YES;
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);

        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}

- (void)setupHead{
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topicModel.top_cmt) {
        self.saved_top_cmt = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        [self.topicModel setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    LBTopicCell *topicCell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LBTopicCell class]) owner:nil options:nil].lastObject;
    topicCell.topic = self.topicModel;
     topicCell.size = CGSizeMake(LBScreenW, self.topicModel.cellHeight);
    //topicCell.height = self.topicModel.height;
     [header addSubview:topicCell];
    header.height = self.topicModel.cellHeight + 10;
    //header.y = -10;
    
    self.tableView.tableHeaderView = header;
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottonSpace.constant = LBScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.latestComments.count;
    if(hotCount)return 2;
    if(lastCount) return 1;
    return 0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.latestComments.count;
    
    tableView.mj_footer.hidden = (lastCount == 0);
    if(section == 0){
        return hotCount ? hotCount : lastCount;
    }
    if(section == 1){
        return lastCount;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 先从缓存池中找header
    LBCommentHeaderView *header = [LBCommentHeaderView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if(section == 0){
        header.title = hotCount ? @"最热评论" : @"最新评论" ;
    }else{
          header.title = @"最新评论";
    }
   
    
    return header;
    
}



- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (LBCommentModel *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBComentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

-(void)dealloc{
    if (self.saved_top_cmt) {
        self.topicModel.top_cmt = self.saved_top_cmt;
        [self.topicModel setValue:@0 forKeyPath:@"cellHeight"];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}





@end
