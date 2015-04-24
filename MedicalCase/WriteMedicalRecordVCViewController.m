//
//  WriteMedicalRecordVCViewController.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/21.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "WriteMedicalRecordVCViewController.h"
#import "AutoHeightTextView.h"
#import "RawDataProcess.h"
#import "WLKCaseNode.h"
#import "HUDSubViewController.h"

@interface WriteMedicalRecordVCViewController ()<UITableViewDataSource,UITableViewDelegate,HUDSubViewControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightContraints;
@property (weak, nonatomic) IBOutlet AutoHeightTextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) WLKCaseNode *sourceNode;

@property (nonatomic,strong) WLKCaseNode *selectedNode;

@property (nonatomic,strong) NSMutableDictionary *nodeChildDic;
@property (nonatomic,strong) NSArray *nodeChildArray;
@end

@implementation WriteMedicalRecordVCViewController
@synthesize labelString = _labelString;
#pragma mask - property
-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}
-(NSArray *)nodeChildArray
{
    if (!_nodeChildArray) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (WLKCaseNode *tempNode in self.sourceNode.childNodes) {
            [tempArray addObject:tempNode.nodeName];
        }
        _nodeChildArray = [NSArray arrayWithArray:tempArray];
    }
    return _nodeChildArray;
}
-(NSMutableDictionary *)nodeChildDic
{
    if (!_nodeChildDic) {
        _nodeChildDic = [[NSMutableDictionary alloc] init];
        for (int i=0; i< self.sourceNode.childNodes.count; i++) {
            NSString *tempStr = [self.nodeChildArray objectAtIndex:i];
            [_nodeChildDic setObject:@"" forKey:tempStr];
        }
    }
    return _nodeChildDic;
}
-(void)setLabelString:(NSString *)labelString
{
    _labelString = labelString;
    
    RawDataProcess *rawData = [RawDataProcess sharedRawData];
    self.sourceNode = [WLKCaseNode getSubNodeFromNode:rawData.rootNode withNodeName:_labelString resultNode:nil];
    
}
#pragma mask - view controller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.labelString) {
        self.titleLabel.text = self.labelString;
    }else {
        abort();
    }
}
#pragma mask - table view delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceNode.childNodes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"navagationCell"];
    UILabel *cellLabel =(UILabel*) [cell viewWithTag:1001];
    WLKCaseNode *tempNode = [self.sourceNode.childNodes objectAtIndex:indexPath.row];
    cellLabel.text = tempNode.nodeName;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNode = [self.sourceNode.childNodes objectAtIndex:indexPath.row];
    //[self performSegueWithIdentifier:@"containerToSub" sender:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"containerToSub" object:self.selectedNode];
    
}



-(WLKCaseNode*)getSelectedNodeWithNodeName:(NSString*)nodeName
{
    RawDataProcess *rawData = [RawDataProcess sharedRawData];
    WLKCaseNode *node = [WLKCaseNode getSubNodeFromNode:rawData.rootNode withNodeName:nodeName resultNode:nil];
    
    return node;
}

#pragma mask - HUDSubViewControllerDelegate
-(void)didSelectedNodesString:(NSString *)nodesString withParentNodeName:(NSString *)nodeName
{
    NSString *t = [NSString stringWithFormat:@"%@: ",nodeName];
    NSString *nodeST = [t stringByAppendingString: nodesString];
    
    if ([self.nodeChildDic.allKeys containsObject:nodeName]) {
        [self.nodeChildDic setObject:nodeST forKey:nodeName];
    }
    
    self.textView.text = @"";
    NSString *tempString = @"";
    for (NSString *temp in self.nodeChildArray) {
        NSString *tempSt = self.nodeChildDic[temp];
        if (![tempSt isEqualToString:@""]) {
          //  NSString *returnStr = [tempSt stringByAppendingString:@"\n"];
            tempString = [tempString stringByAppendingString:tempSt];
        }
    }
    self.textView.text = tempString;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"containerToSub"]) {
        HUDSubViewController *hubVC = (HUDSubViewController*)segue.destinationViewController;
        hubVC.detailCaseNode = [self getSelectedNodeWithNodeName:self.selectedNode.nodeName];
        hubVC.isInContainerView = YES;
        hubVC.subDelegate = self;
      //  hubVC.title = self.labelString;

        
    }
}

@end
