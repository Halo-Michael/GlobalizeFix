int main()
{
    if (getuid() != 0) {
        printf("Run this as root!\n");
        return 1;
    }

    if (access("/Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.disabled", F_OK) == 0 && access("/Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.dylib", F_OK) != 0){
        system("mv /Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.disabled /Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.dylib");
    }
    return 0;
}
