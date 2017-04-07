#import "NavControllerAppDelegate.h"
#import "CompanyVC.h"

@interface NavControllerAppDelegate ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation NavControllerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // Override point for customization after application launch.
    CompanyVC *rootController = [[[CompanyVC alloc]init] autorelease];
    self.navigationController = [[UINavigationController alloc]
                            initWithRootViewController:rootController];
    
    // Set nav controller text color and nav controller bar color.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.49 green:0.70 blue:0.22 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    self.dataManager = [DAO sharedInstance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    [self.dataManager saveCoreData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 
    [self.dataManager saveCoreData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self.dataManager saveCoreData];
}

- (void) dealloc {
    [_navigationController release];
    [_dataManager release];
    [_window release];
    [super dealloc];
}

@end
