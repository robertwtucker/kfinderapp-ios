#!/bin/sh
#
# Use the current git commit count to set the build number.
# Adapted from:
#   http://blog.jaredsinclair.com/post/97193356620/the-best-of-all-possible-xcode-automated-build
#

git=`sh /etc/profile; which git`
appBuild=`"$git" rev-list HEAD --count`
if [ $CONFIGURATION = "Debug" ]; then
branchName=`"$git" rev-parse --abbrev-ref HEAD`
  echo "Setting build number to $appBuild-$branchName"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild-$branchName" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild-$branchName" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
else
  echo "Setting build number to $appBuild"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
fi
echo "Incremented the build number ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
