# set aliases
source $OMF_CONFIG/aliases.fish

set -gx EDITOR vim

# Android
set -g --export JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home
set -g --export ANDROID $HOME/Library/Android
set -g --export ANDROID_HOME $ANDROID/sdk/
set -g --export GOPATH $HOME/go/
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH /Users/yingbaihe/.cargo/bin $PATH
set -gx PATH $GOPATH/bin $PATH
set -x PATH $HOME/.fastlane/bin $PATH
