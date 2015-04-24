//
//  AdmissionRecordsViewController.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/1.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "AdmissionRecordsViewController.h"
#import "AdmissionRecordCell.h"
#import "ShowTemplateViewControllerTwo.h"
#import "Constants.h"
#import "CoreDataStack.h"
#import "ParentNode.h"
#import "Node.h"
#import "Template.h"
#import "WriteMedicalRecordVCViewController.h"

@interface AdmissionRecordsViewController () <UITableViewDataSource,UITableViewDelegate,AdmissionRecordCellDelegate,ShowTemplateViewControllerTwo,NSFetchedResultsControllerDelegate,WriteMedicalRecordVCViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLable;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *admissionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedNLabel;

@property (nonatomic,strong) CoreDataStack *coreDataStack;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic) CGFloat keyboardOverlap;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic,strong) UITextView *currentTextView;

@property (nonatomic) BOOL keyboardShow;

@property (nonatomic,strong) NSString *selectedStr;

@property (nonatomic,strong) NSFetchedResultsController *fetchResultController;

@end

@implementation AdmissionRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabelView.autoresizesSubviews = NO;
    [self setUpTableView];
    [self addKeyboardObserver];
    
    [self setUpFetchViewController];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didDisappearTheCurrentViewController"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"referenceTemplateString"];


}
-(NSManagedObjectContext *)managedObjectContext
{
    return self.coreDataStack.managedObjectContext;
}
-(CoreDataStack *)coreDataStack
{
    _coreDataStack = [[CoreDataStack alloc] init];
    return _coreDataStack;
}

-(void)setUpFetchViewController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[Node entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentNode.nodeName = %@",@"入院记录"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nodeIndex" ascending:YES];
  //  NSSortDescriptor *sortDescriptor = nil;
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    self.fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchResultController.delegate = self;
    NSError *error = nil;
    if (![self.fetchResultController performFetch:&error]) {
        NSLog(@"error: %@",error.description);
        abort();
    }else {
        // Template *template = [self.fetchResultController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        // NSLog(@"template condition : %@",template.condition);
        [self.tabelView reloadData];
        
    }
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL didDix = [[NSUserDefaults standardUserDefaults] objectForKey:@"didDisappearTheCurrentViewController"];
    if (didDix) {
        [self setUpFetchViewController];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didDisappearTheCurrentViewController"];

}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@"我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将"];
        [_dataArray addObject:@"cell2"];
        [_dataArray addObject:@"我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将"];
        [_dataArray addObject:@"我是一个肺腧将"];
        [_dataArray addObject:@"我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将"];
        [_dataArray addObject:@"我是说姐姐家啊啊时间即可开始快速开始上课"];

        [_dataArray addObject:@"我是说姐姐家啊啊时间即可开始快速开始上课我是说姐姐家啊啊时间即可开始快速开始上课"];
        [_dataArray addObject:@"cell2"];
        [_dataArray addObject:@"我是说姐姐家啊啊时间即可开始快速开始上课我是说姐姐家啊啊时间即可开始快速开始上课我是说姐姐家啊啊时间即可开始快速开始上课我是说姐姐家啊啊时间即可开始快速开始上课"];
        [_dataArray addObject:@"我是说姐姐家啊啊时间即可开始快速开始上课"];
        [_dataArray addObject:@"我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是一个肺腧将我是说姐姐家啊啊时间即可开始快速开始上课我是说姐姐家啊啊时间即可开始快速开始上课"];
        [_dataArray addObject:@"cell6"];

    }
    return _dataArray;
}
-(void)addKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillShow:(NSNotification*)notificationInfo
{
    
    if (self.keyboardShow) {
        return;
    }
    self.keyboardShow = YES;
    // Get the keyboard size
    UIScrollView *tableView;
    if([self.tabelView.superview isKindOfClass:[UIScrollView class]])
        tableView = (UIScrollView *)self.tabelView.superview;
    else
        tableView = self.tabelView;
    
    NSDictionary *userInfo = [notificationInfo userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //[self.delegate keyboardShow:[aValue CGRectValue].size.height];
    CGRect keyboardRect = [tableView.superview convertRect:[aValue CGRectValue] fromView:nil];
    
    
    // [self.delegate keyboardShow:keyboardRect.size.height];
    // Get the keyboard's animation details
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    // Determine how much overlap exists between tableView and the keyboard
    CGRect tableFrame = tableView.frame;
    CGFloat tableLowerYCoord = tableFrame.origin.y + tableFrame.size.height;
    self.keyboardOverlap = tableLowerYCoord - keyboardRect.origin.y;
    if(self.currentTextView && self.keyboardOverlap>0)
    {
        CGFloat accessoryHeight = self.currentTextView.frame.size.height;
        self.keyboardOverlap -= accessoryHeight;
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, accessoryHeight, 0);
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, accessoryHeight, 0);
    }

    if(self.keyboardOverlap < 0)
        self.keyboardOverlap = 0;
    
    if(self.keyboardOverlap != 0)
    {
        tableFrame.size.height -= self.keyboardOverlap;
        
        NSTimeInterval delay = 0;
        if(keyboardRect.size.height)
        {
            delay = (1 - self.keyboardOverlap/keyboardRect.size.height)*animationDuration;
            animationDuration = animationDuration * self.keyboardOverlap/keyboardRect.size.height;
        }
        
        [UIView animateWithDuration:animationDuration delay:delay
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ tableView.frame = tableFrame; }
                         completion:^(BOOL finished){ [self tableAnimationEnded:nil finished:nil contextInfo:nil]; }];
    }

}
-(void)keyboardWillHide:(NSNotification*)notificationInfo
{
    
    [self.coreDataStack saveContext];
    
    self.keyboardShow = NO;

    UIScrollView *tableView;
    if([self.tabelView.superview isKindOfClass:[UIScrollView class]])
        tableView = (UIScrollView *)self.tabelView.superview;
    else
        tableView = self.tabelView;
    if(self.currentTextView)
    {
        tableView.contentInset = UIEdgeInsetsZero;
        tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
    
    if(self.keyboardOverlap == 0)
        return;
    
    // Get the size & animation details of the keyboard
    NSDictionary *userInfo = [notificationInfo userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [tableView.superview convertRect:[aValue CGRectValue] fromView:nil];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    CGRect tableFrame = tableView.frame;
    tableFrame.size.height += self.keyboardOverlap;
    
    //  tableFrame.size = CGSizeMake(678, 497);
    if(keyboardRect.size.height)
        animationDuration = animationDuration * self.keyboardOverlap/keyboardRect.size.height;
    
    [UIView animateWithDuration:animationDuration delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ tableView.frame = tableFrame; }
                     completion:^(BOOL finished){ [self tableAnimationEnded:nil finished:nil contextInfo:nil]; }];
    

}
- (void) tableAnimationEnded:(NSString*)animationID finished:(NSNumber *)finished contextInfo:(void *)context
{
    // Scroll to the active cell
    UITableView *tableView = self.tabelView;
    if(self.currentIndexPath)
    {
        [tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [tableView selectRowAtIndexPath:self.currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    }
}

-(void)removeKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillHideNotification];
}
-(void)setUpTableView
{
    self.tabelView.layer.shadowOffset = CGSizeMake(15, 13);
    self.tabelView.layer.shadowOpacity = 1;
    self.tabelView.layer.shadowRadius = 20;
    self.tabelView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    self.tabelView.layer.borderWidth = 1;
   // self.tabelView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.tabelView.estimatedRowHeight = 55;
    self.tabelView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mask - table view delegate && data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section count %@", @(self.fetchResultController.sections.count));
    return self.fetchResultController.sections.count ;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return self.dataArray.count;
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchResultController.sections[section];
    
    return [sectionInfo numberOfObjects];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdmissionRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"admissionRecordCell"];
    cell.autoresizesSubviews = NO;
    [self configureCell:cell AtIndexPath:indexPath];
    
    return cell;
}
-(void)configureCell:(AdmissionRecordCell*)cell AtIndexPath:(NSIndexPath*)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    Node *tempNode = [self.fetchResultController objectAtIndexPath:indexPath];
    cell.textViewDelegate = self;
    UILabel *cellLabel = (UILabel*)[cell viewWithTag:1001];
    UITextView *textView = (UITextView*)[cell viewWithTag:1002];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    cellLabel.text = tempNode.nodeName;
    textView.text = ([tempNode.nodeContent isEqualToString:tempNode.nodeName]) ? @" ": tempNode.nodeContent;
//    if(indexPath.row == 0) {
//        cellLabel.text = @"主诉";
//      //  textView.text = [self.dataArray objectAtIndex:indexPath.row];
//        textView.text = tempNode.nodeName
//    }else {
//        cellLabel.text = @"现病史";
//        textView.text = [self.dataArray objectAtIndex:indexPath.row];
//    }
}

#pragma mask - AdmissionRecordCell  delegate
-(void)textViewCell:(AdmissionRecordCell *)cell didChangeText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];

    Node *tempNode = [self.fetchResultController objectAtIndexPath:indexPath];
    tempNode.nodeContent = text;
    [self.coreDataStack saveContext];
//    NSMutableArray *data = [self.dataArray mutableCopy];
//    data[indexPath.row]  = text;
//    self.dataArray = [data copy];
}
-(void)textViewDidBeginEditing:(UITextView *)textView withCellIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    self.currentTextView = textView;
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didDisappearTheCurrentViewController"];

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AdmissionRecordCell *cell =(AdmissionRecordCell*) [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label =(UILabel*) [cell viewWithTag:1001];
    self.selectedStr = label.text;
    
    self.currentIndexPath = indexPath;
    [self performSegueWithIdentifier:@"ToWirteMedicalCaseSegue" sender:nil];
}

///
-(void)didSelectedTemplate:(Template *)template
{
    //self.dataArray[self.currentIndexPath.row] = template.condition;
    Node *tempNode = [self.fetchResultController objectAtIndexPath:self.currentIndexPath];
    tempNode.nodeContent = template.content;
    [self.coreDataStack saveContext];
    //[self.tabelView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mask - fetch view controller delegate
/// fetch result controller delegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tabelView beginUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:{
            [self.tabelView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeDelete:{
            [self.tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeUpdate:{
           BOOL pop =  [[NSUserDefaults standardUserDefaults] objectForKey:@"referenceTemplateString"];
            BOOL didDis = [[NSUserDefaults standardUserDefaults] objectForKey:@"didDisappearTheCurrentViewController"];
            
            if (pop || didDis) {
                AdmissionRecordCell *cell =(AdmissionRecordCell*) [self.tabelView cellForRowAtIndexPath:indexPath];
                [self configureCell:cell AtIndexPath:indexPath];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"referenceTemplateString"];

                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didDisappearTheCurrentViewController"];

            }
        }
            
        default:
            break;
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tabelView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tabelView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tabelView endUpdates];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"popoverTemSegue"]) {
//        ShowTemplateViewControllerTwo *showVC = (ShowTemplateViewControllerTwo*)segue.destinationViewController;
//        showVC.fetchStr = self.selectedStr;
//        showVC.showTempDelegate  =self;
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"referenceTemplateString"];
//    }
    if ([segue.identifier isEqualToString:@"ToWirteMedicalCaseSegue"]){
        WriteMedicalRecordVCViewController *writeMedicalVC = (WriteMedicalRecordVCViewController*)segue.destinationViewController;
        writeMedicalVC.labelString = self.selectedStr;
        writeMedicalVC.WriteDelegate = self;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"referenceTemplateString"];
    }
}
#pragma mask - write delegate
-(void)didWriteStringToMedicalRecord:(NSString *)writeString
{
    Node *tempNode = [self.fetchResultController objectAtIndexPath:self.currentIndexPath];
    tempNode.nodeContent = writeString;
    [self.coreDataStack saveContext];

}
- (IBAction)unwindSegueFromCreateTemplateToAdmissioVC:(UIStoryboardSegue *)segue
{
    
}


-(void)dealloc
{
    [self removeKeyboardObserver];
}
@end
