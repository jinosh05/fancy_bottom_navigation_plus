# FancyBottomNavigationPlus


[![Pub](https://img.shields.io/pub/v/fancy_bottom_navigation_plus.svg)](https://pub.dartlang.org/packages/fancy_bottom_navigation_plus) 
[![License](https://img.shields.io/badge/licence-MIT-orange.svg)](https://github.com/jinosh05/fancy_bottom_navigation_plus/blob/master/LICENSE)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/jinosh05/fancy_bottom_navigation_plus.svg)](https://github.com/jinosh05/fancy_bottom_navigation_plus)
[![GitHub stars](https://img.shields.io/github/stars/jinosh05/fancy_bottom_navigation_plus.svg?style=social)](https://github.com/jinosh05/fancy_bottom_navigation_plus)


<p align="center" >
  <br />
  <br />
<a href="https://www.buymeacoffee.com/jinosh" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</p>

<br />

![Fancy Gif](https://github.com/jinosh05/fancy_bottom_navigation_plus/blob/master/fancy.gif "Fancy Gif")



## Getting Started


Add the plugin (pub coming soon):

```yaml
dependencies:
  ...
  fancy_bottom_navigation_plus: ^1.0.3
```


## Limitations
For now this is limited to more than 1 tab, and less than 6. So 2-5 tabs.

## Basic Usage

Adding the widget
```dart
bottomNavigationBar: FancyBottomNavigation(
    tabs: [
            TabData(icon: const Icon(Icons.home), title: "Home"),
            TabData(icon: const Icon(Icons.history), title: "History"),
            TabData(icon: const Icon(Icons.search), title: "Search"),
            TabData(icon: const Icon(Icons.phone), title: "Phone"),
            TabData(icon: const Icon(Icons.settings), title: "Settings"),
    ],
    onTabChangedListener: (position) {
        setState(() {
        currentPage = position;
        });
    },
)
```

## TabData
**icon** -> Widget to be used for the tab<br/>
**title** -> String to be used for the tab<br/>
**onClick** -> Optional function to be used when the circle itself is clicked, on an active tab


### optional
**initialSelection** -> Defaults to 0<br/>
**circleColor** -> Defaults to null, derives from `Theme`<br/>
**textColor** -> Defaults to null, derives from `Theme`<br/>
**barBackgroundColor** -> Defaults to null, derives from `Theme`<br/>
**barheight** -> Default to 60<br/>
**circleRadius** -> Default to 60<br/>
**shadowRadius** -> Default to 10<br/>
**circleOutline** -> Default to 10<br/>
**titleStyle** -> Default value already given<br/>
**key** -> Defaults to null<br/>


## Theming

The bar will attempt to use your current theme out of the box, however you may want to theme it.


## Showcase
Using this package in a live app, let me know and I'll add you app here.


## Inspiration

This package was inspired by a previous version 
- fancy_bottom_navigation(https://pub.dev/packages/fancy_bottom_navigation)

## Raise issues 
Kindly try the package and let me know for improvement and bug fixes.


## Contributing

Contributions are welcome, please submit a PR :)







