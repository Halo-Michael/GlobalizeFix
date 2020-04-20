%hook CSCoverSheetViewController
-(void) setAuthenticated:(BOOL)authenticated {
    %orig;
    if (authenticated == true) {
        if (access("/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist", F_OK) == 0) {
            NSString *const MobileGestaltPlist = @"/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist";
            NSDictionary *const MobileGestalt = [NSDictionary dictionaryWithContentsOfFile:MobileGestaltPlist];
            NSString *const GlobalizeModels = @"^(X/)[A-Z]$";
            NSPredicate *const predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", GlobalizeModels];
            if (![predicate evaluateWithObject:MobileGestalt[@"CacheExtra"][@"zHeENZu+wbg7PUprwNwBWg"]] || ![MobileGestalt[@"CacheExtra"][@"h63QSdBCiT/z0WU6rdQv6Q"] isEqualToString:@"X"]) {
                remove("/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist");
                if (access("/Library/MobileSubstrate/DynamicLibraries/Globalize.dylib", F_OK) == 0) {
                    system("suer ldrestart");
                }
            } else {
                system("suer mv /Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.dylib /Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.disabled");
            }
        }
    }
}
%end
