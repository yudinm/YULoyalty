# YULoyalty

## What is it?

**YULoyalty** is a module for calculating and handling User Loyalty. Needs to get more stars in AppStore. Ask for review only active and happy users. Don't ask for review low active or angry users. Track user and App actions with points:

	+1 app started
	+3 user added bookmark
	+5 user watched video 10 minutes
	+2 user shared content
	-5 app crashed
	-1 app error 404

When loyalty points achieve some level – we can try to ask for review our App.


## How to use?

In YULoyalty concepts:

- **CurrentLoaylty** – variable that represents current value of user loyalty
- **LoyaltyLevels** – enum of all mailstone points that handling when **CurrentLoaylty** reaches them
- **LoyaltyWeights** – enum of all possible values that can increment **CurrentLoaylty** 

#### Installation

Copy _YULoyalty.swift_ in project. For Objective-C needs to update _…-Bridging-Header.h_ like _YULoyalty-Swift.h_.

#### Init and configure
```Swift

	// Load startLoyalty and startLevel from DB or settings
    let startLoyalty = 1
    let startLevel:YULoyalty.LoyaltyLevels = .starter
    YULoyalty.instance.configure(currentLoyalty: startLoyalty, currentLevel: startLevel)
    // Configure level achieved callback
	YULoyalty.instance.levelAchievedBlock = { level in
	    print("Level Achived: \(level.text)")
	    // Ask for review here
	}
	// Configure current loyalty incremented callback
	YULoyalty.instance.syncCurrentStateBlock = { loyalty, level in
		print("Sync Current Loyalty: \(loyalty) Level: \(level.text)")
	    // Save current loyalty point and current level in DB or settings here
	}
```

```Objective-C
    NSInteger loyaltyCurrentLevel = LoyaltyLevelsStarter;
    NSInteger loyaltyCurrentPoints = 1;
    [[YULoyalty instance] configureWithCurrentLoyalty:loyaltyCurrentPoints currentLevel:loyaltyCurrentLevel];
    [YULoyalty instance].syncCurrentStateBlock = ^(NSInteger points, LoyaltyLevels level) {
    	NSString *strLevel = [[YULoyalty instance] loyaltyLevelText:level];
		// Ask for review here
    };
    [YULoyalty instance].levelAchievedBlock = ^(LoyaltyLevels level) {
        // Save current loyalty point and current level in DB or settings here
    };
```

#### Usage

```Swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        YULoyalty.instance.incrementLoyalty(weight: .startApp)
        return true
    }
    
```

```Objective-C
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    [[YULoyalty instance] incrementLoyaltyWithWeight:LoyaltyWeightsStartApp];
	    return YES;
	}
```

## TODO

[] Add interface for configuring Levels and Weights
