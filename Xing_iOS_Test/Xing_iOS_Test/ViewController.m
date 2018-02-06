//
//  ViewController.m
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//

#import "ViewController.h"
#import "RepoCell.h"
#import "ApiRequest.h"
#import "XingRepository.h"
#import "MBProgressHUD.h"
@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,ApiRequestingDelegate> {
    UICollectionView *_collectionView;
    NSMutableArray *xingRepositories;
    ApiRequest *apiRequest;
    NSInteger currentPageNumber;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    xingRepositories = [[NSMutableArray alloc]init];
    apiRequest = [[ApiRequest alloc]init];
    apiRequest.delegate = self;
    currentPageNumber = 1;
    [apiRequest fetchXingRepositoryInfoFrom:currentPageNumber];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[RepoCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_collectionView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showProgressView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD HUDForView:self.view];
}

#pragma mark -
#pragma -UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [xingRepositories count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RepoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    XingRepository *repo = [xingRepositories objectAtIndex:indexPath.item];
    [cell setRepositoryName:repo.repoName];
    [cell setRespositoryDescription:repo.repoDescription];
    [cell setOwner:repo.repoOwner];
    if(repo.isForked)
        cell.backgroundColor=[UIColor greenColor];
    else
        cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 4.0f; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}
//- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10.0f;
//}
#pragma mark-
#pragma ApiRequestingDelegate

-(void)repositoryFetchCompleted:(NSArray*)response{
    dispatch_async(dispatch_get_main_queue(), ^{
        for(NSDictionary *dic in response){
            XingRepository *repo = [[XingRepository alloc]init];
            NSString *name = [dic valueForKey:@"name"];
            if([name isKindOfClass:[NSNull class] ]|| [name length]==0)
                repo.repoName = @"No Name Available";
            else
                repo.repoName = name;
            NSString*owner = [[dic valueForKey:@"owner"] valueForKey:@"login"];
            if([owner isKindOfClass:[NSNull class] ]|| [owner length]==0)
                repo.repoOwner = @"No Owner Available";
            else
                repo.repoOwner = owner;
            NSString *description = [dic valueForKey:@"description"];
            if([description isKindOfClass:[NSNull class] ]|| [description length]==0)
                repo.repoDescription = @"No Description Available";
            else
                repo.repoDescription = description;
            repo.isForked = [[dic valueForKey:@"fork"]boolValue];
            [xingRepositories addObject:repo];
        }
        [self hideProgressView];
        [_collectionView reloadData];
    });
}

- (void)internetConnectivityError {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView];
        currentPageNumber--;
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:NSLocalizedString(@"Network_error",nil)
                                     message:NSLocalizedString(@"Please check internet connectivity",nil)
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:NSLocalizedString(@"OK",nil)
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

-(void)failedToLoadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView];
        currentPageNumber--;
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:NSLocalizedString(@"Error",nil)
                                     message:NSLocalizedString(@"Failed To Fetch Data",nil)
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:NSLocalizedString(@"OK",nil)
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark -
#pragma -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(_collectionView.contentOffset.y >= (_collectionView.contentSize.height - _collectionView.bounds.size.height)) {
        
        //NSLog(@" scroll to bottom!");
      //  if(isPageRefresing == NO){ // no need to worry about threads because this is always on main thread.
            
         //   isPageRefresing = YES;
//            [self showMBProfressHUDOnView:self.view withText:@"Please wait..."];
            currentPageNumber = currentPageNumber +1;
            [apiRequest fetchXingRepositoryInfoFrom:currentPageNumber];
        }
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
