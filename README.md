# iOS-ClassSchedule 北商課表App

## API
[https://github.com/arthurc0102/ntub-class-table-api](https://github.com/arthurc0102/ntub-class-table-api)

## Tools

* Swift 4.2
* Xcode 10.1
* MVVM
* Moya/RxSwift
* fastlane

## Setup env

1. Install gem

2. Install cocoapods

```
sudo gem install cocoapods
```

3. Install packages

```
pod install
```

4. Install fastlane

```
xcode-select --install

sudo gem install fastlane -NV
```

5. Get fastlane file

```
git submodule init

git submodule update
```

6. Setup development

```
fastlane match development
```
