#.SILENT: all update-modules

buildPlist=../native-ios-framework/src/SpilResources/SpilResources-Info.plist
newVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$(buildPlist)"`
	
all: update-modules ios android unity
	#update ios stuff
	echo "done"
	
update-modules:
	#make a pull of the submodule in apis
	git submodule foreach git pull
	
ios:
	cp ../native-ios-framework/dist/$(newVersion).zip apis/ios/spil_ios_framework.zip
	rm -rf apis/ios/latest
	unzip apis/ios/spil_ios_framework.zip -d apis/ios/
	mv apis/ios/$(newVersion) apis/ios/latest
	
android:
	cp ../native-unity-plugin/libs/android-api/dist/spil_android_framework.zip apis/android/spil_android_framework.zip
	unzip -o apis/android/spil_android_framework.zip -d apis/android/latest/

unity:
	cp ../native-unity-plugin/dist/$(newVersion).zip apis/unity/spil_unity_framework.zip
	rm -rf apis/unity/latest
	unzip apis/unity/spil_unity_framework.zip -d apis/unity/
	mv apis/unity/$(newVersion) apis/unity/latest


