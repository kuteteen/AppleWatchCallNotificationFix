#import "spawn.h"

@interface TUCall
  @property (nonatomic,readonly) int callStatus;
@end

@interface AVExternalDevice
  +(id)currentCarPlayExternalDevice;
@end

static BOOL shouldKillCallService = NO;
static BOOL isCallInProgress = NO;

static void killCallService()
{
  if (isCallInProgress)
    return;

  pid_t pid;
  const char* args[] = {"AppleWatchCallNotificationFix", NULL};
  posix_spawn(&pid, "/usr/bin/AppleWatchCallNotificationFix", NULL, NULL, (char* const*)args, NULL);
  shouldKillCallService = NO;
}

%hook TUCall

  -(void)_handleStatusChange
  {
    int callStat = self.callStatus;

    if (callStat == 1)
      isCallInProgress = YES;

  	if (callStat == 6)
    {
      isCallInProgress = NO;
      if (shouldKillCallService)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
          killCallService();
        });
     }
  }

%end



%hook SpringBoard

  - (void)applicationDidFinishLaunching:(id)arg1
  {
    //Credits to Ethan for CarplayEnable - https://github.com/EthanArbuckle/carplay-cast/blob/696bc72bfd0df9bea80a333e7c3307cd410f6156/src/hooks/SpringBoard.xm#L89
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carplayIsConnectedChanged) name:@"CarPlayIsConnectedDidChange" object:nil];
   %orig;
  }

  %new
  - (void)carplayIsConnectedChanged
  {
    id carplayAVDisplay = [%c(AVExternalDevice) currentCarPlayExternalDevice];

    if (!carplayAVDisplay)
    {
      shouldKillCallService = YES;
      killCallService();
    }
  }

%end
