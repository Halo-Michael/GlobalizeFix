TARGET = GlobalizeFix
VERSION = 0.3.2
CC = xcrun -sdk iphoneos clang -arch arm64 -arch arm64e -miphoneos-version-min=9.0
LDID = ldid

.PHONY: all clean

all: clean postinst globalizefix springboard-hook
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	cp control com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	mv postinst com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc/rc.d
	cp etc/rc.d/.theos/obj/globalizefix com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc/rc.d
	chmod 0755 com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc/rc.d/globalizefix
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/Library
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/Library/MobileSubstrate
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/Library/MobileSubstrate/DynamicLibraries
	cp SpringBoard-Hook/.theos/obj/GlobalizeFix.dylib SpringBoard-Hook/GlobalizeFix.plist com.michael.globalizefix_$(VERSION)_iphoneos-arm/Library/MobileSubstrate/DynamicLibraries
	touch com.michael.globalizefix_$(VERSION)_iphoneos-arm/Library/MobileSubstrate/DynamicLibraries/GlobalizeFix.disabled
	dpkg -b com.michael.globalizefix_$(VERSION)_iphoneos-arm

postinst: clean
	$(CC) postinst.c -o postinst
	strip postinst
	$(LDID) -Sentitlements.xml postinst

globalizefix: clean
	bash make-globalizefix.sh

springboard-hook: clean
	bash make-springboard-hook.sh

clean:
	rm -rf com.michael.globalizefix_* SpringBoard-Hook/.theos etc/rc.d/.theos