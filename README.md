# LiveCastr

## Motivation

My lovely partner enjoys watching live streams and wanted a way to cast their live stream to our ChromeCast™.
After some research, it seems not possible to stream a tab from the Chrome iOS app and it's up to the website to support casting.

I thought this would be a fun weekend project to test whether given the live stream source url, could I enable casting it through my own application?

## Why Objective-C?

It's been a while since I've had to write Objective-C and I was curious to see if I could still develop with it.
I much prefer Swift though :)

## Google Cast Developer Setup

Before you can run this project, you'll need to complete the following:
- Register an account on [Google Cast SDK Developer Console](https://cast.google.com/publish)
- Create an application that is of type: `Styled Media Receiver` and remember the `Application ID`
- Register your ChromeCast for development
  - ChromeCast development setup docs [here](https://developers.google.com/cast/docs/registration#RegisterDevice)
  - This will take about 10 minutes and you'll need to restart the ChromeCast
- The full registration docs can be found [here](https://developers.google.com/cast/docs/registration) but I've outlined the crucial steps above.

## Project Setup

After you've completed the above, you'll need to clone this repo and install the dependencies.

This project uses [Cocoapods](http://cocoapods.org) which can be installed in your terminal of choice via the command:
```
pod install
```

After this, you'll only need to open the `LiveCastr.xcworkspace` and navigate to the file `Constants.h`.
You'll need to replace the text `"INSERT_YOUR_APP_ID_HERE"` with the `Application ID` that you registered with:

```Objective-C
// Constants.h
#define APP_ID  @"INSERT_YOUR_APP_ID_HERE"
```

Test it out with this stream of Steve Jobs and Tim Cook from back in the day:
http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8

## Why is my Live Stream not working?

Unfortunately, not every live streaming url is meant for easy sharing outside of their source website.
Some websites ensure that their streams can only be run on their sites and for those cases, you're out of luck.

You can dig into more on the why in this StackOverflow [post](https://stackoverflow.com/questions/33895802/streaming-live-m3u8-from-ios-to-chromecast).

## Using the App

The app itself has a very simple interface and if you have a ChromeCast device on the same Wifi as your simulator/device, you should see the Cast™️ icon in the top right:

<img src="https://user-images.githubusercontent.com/3321592/44952259-57949100-ae49-11e8-933d-e4affe2dd955.png" width=60% height=60%>


> If you don't have a ChromeCast device or it's not on the same Wifi, you'll likely see no icon in the top right.

When you tap on the Cast button, you should see a list of all available ChromeCasts on your Wifi:

<img src="https://user-images.githubusercontent.com/3321592/44952257-56fbfa80-ae49-11e8-8645-9118623d37b2.png" width=60% height=60%>

Lastly, the `"Start"` button won't be enabled until you've entered text AND a ChromeCast has been connected:

<img src="https://user-images.githubusercontent.com/3321592/44952256-56fbfa80-ae49-11e8-8eb8-bb649d7debe0.png" width=60% height=60%>
