NSString *const MobileGestaltPlist = @"/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist";
NSDictionary *const MobileGestalt = [NSDictionary dictionaryWithContentsOfFile:MobileGestaltPlist];
NSString *const GlobalizeModels = @"^(X/)[A-Z]$";
NSPredicate *const predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", GlobalizeModels];

%hook CSCoverSheetViewController
-(void) setAuthenticated:(BOOL)authenticated {
    %orig;
    if (authenticated) {
        if (MobileGestaltPlist != nil){
            if (![predicate evaluateWithObject:MobileGestalt[@"CacheExtra"][@"zHeENZu+wbg7PUprwNwBWg"]] || ![MobileGestalt[@"CacheExtra"][@"h63QSdBCiT/z0WU6rdQv6Q"] isEqualToString:@"X"]) {
                remove("/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist");
            }
        }
    }
}
%end
