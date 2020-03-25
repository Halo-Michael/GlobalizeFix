TARGET = GlobalizeFix
VERSION = 0.2.0
CC = xcrun -sdk iphoneos clang -arch arm64 -arch arm64e -miphoneos-version-min=9.0
LDID = ldid

.PHONY: all clean

all: clean postinst globalizefix
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	cp control com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	mv postinst com.michael.globalizefix_$(VERSION)_iphoneos-arm/DEBIAN
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc
	mkdir com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc/rc.d
	mv globalizefix/.theos/obj/globalizefix com.michael.globalizefix_$(VERSION)_iphoneos-arm/etc/rc.d
	dpkg -b com.michael.globalizefix_$(VERSION)_iphoneos-arm

postinst: clean
	$(CC) postinst.c -o postinst
	strip postinst
	$(LDID) -Sentitlements.xml postinst

globalizefix: clean
	sh make-globalizefix.sh

clean:
	rm -rf com.michael.globalizefix_* postinst globalizefix/.theos