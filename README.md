# Fancy Bottom Navigation Plus

[![Pub](https://img.shields.io/pub/v/fancy_bottom_navigation_plus.svg?logo=dart&logoColor=white)](https://pub.dev/packages/fancy_bottom_navigation_plus)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jinosh05/fancy_bottom_navigation_plus/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/jinosh05/fancy_bottom_navigation_plus.svg?style=social)](https://github.com/jinosh05/fancy_bottom_navigation_plus)
[![Donate](https://img.shields.io/badge/Donate-Razorpay-blue?style=for-the-badge&logoColor=white&logo=razorpay)](https://razorpay.me/@devasundarjinosh)

A highly customizable, smooth, and animated bottom navigation bar for Flutter. The icon animates elegantly into place when selected, providing a premium feel to your application UI.

---

## 🚀 Key Features

- **Smooth Animation**: Iconic "bubble-up" animation for active tabs.
- **Highly Customizable**: Change colors, sizes, and styles to match your brand.
- **Easy Theming**: Inherits from your app's `ThemeData` automatically.
- **Lightweight**: Minimal dependencies, focus on performance.
- **Responsive**: Adapts perfectly to different screen sizes.

---

## 📸 Preview

![Fancy Animation](https://github.com/jinosh05/fancy_bottom_navigation_plus/blob/master/fancy.gif)

---

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```bash
flutter pub add fancy_bottom_navigation_plus
```

Or manually:

```yaml
dependencies:
  fancy_bottom_navigation_plus: ^1.0.3
```

---

## 🛠️ Basic Usage

```dart
import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';

// ... inside your Scaffold
bottomNavigationBar: FancyBottomNavigationPlus(
    tabs: [
        TabData(icon: Icon(Icons.home), title: "Home"),
        TabData(icon: Icon(Icons.history), title: "History"),
        TabData(icon: Icon(Icons.search), title: "Search"),
        TabData(icon: Icon(Icons.settings), title: "Settings"),
    ],
    onTabChangedListener: (position) {
        setState(() {
            currentPage = position;
        });
    },
)
```

---

## ⚙️ Properties & Customization

### FancyBottomNavigationPlus

| Property | Description | Default |
| :--- | :--- | :--- |
| `tabs` | List of `TabData` objects (Required) | - |
| `onTabChangedListener` | Callback function when active tab changes (Required) | - |
| `initialSelection` | The index of the initially selected tab | `0` |
| `circleColor` | Color of the floating circle | `Theme.primaryColor` |
| `activeIconColor` | Color of the icon when active | `Theme.canvasColor` |
| `inactiveIconColor` | Color of the icon when inactive | `Theme.primaryColor` |
| `textColor` | Color of the tab title text | `Theme.primaryColor` |
| `barBackgroundColor` | Background color of the navigation bar | `Theme.canvasColor` |
| `barHeight` | Total height of the navigation bar | `60.0` |
| `circleRadius` | Radius of the animated circle | `60.0` |
| `shadowRadius` | Radius of the shadow behind the bar | `10.0` |
| `circleOutline` | Width of the circle's outline | `10.0` |
| `titleStyle` | `TextStyle` for the tab titles | - |

### TabData

| Property | Description |
| :--- | :--- |
| `icon` | The icon `Widget` to display (Required) |
| `title` | The label `String` for the tab (Required) |
| `onClick` | Optional callback when the *active* tab circle is clicked |
| `activeIconColor` | Optional color for the icon when the tab is active |
| `inactiveIconColor` | Optional color for the icon when the tab is inactive |

---

## 🎨 Theming

The bar attempts to use your current `ThemeData` out of the box. You can override specific colors globally using your theme or locally via the widget's properties.

```dart
ThemeData(
  primaryColor: Colors.deepPurple,
  canvasColor: Colors.white,
)
```

---

## ☕ Support the Project

If you find this package helpful, consider supporting the development!

<p align="left">
<a href="https://razorpay.me/@devasundarjinosh" target="_blank">
  <img src="https://img.shields.io/badge/Donate-Razorpay-blue?style=for-the-badge&logo=razorpay" alt="Donate with Razorpay">
</a>
<a href="https://www.buymeacoffee.com/jinosh" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="40">
</a>
</p>

---

## 💡 Inspiration

This package is an enhanced version of the original [fancy_bottom_navigation](https://pub.dev/packages/fancy_bottom_navigation).

## 🐛 Issues & Contributing

Found a bug or have a feature request? Please [raise an issue](https://github.com/jinosh05/fancy_bottom_navigation_plus/issues).
Contributions are welcome! If you'd like to help improve the package, please follow the steps below.

---

## 🤝 How to Contribute

1. **Fork** the repository:
   Click the **Fork** button at the top right of the [GitHub page](https://github.com/jinosh05/fancy_bottom_navigation_plus).

2. **Clone** your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/fancy_bottom_navigation_plus.git
   ```

3. **Create a new branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**:
   Ensure your code is well-documented (using DartDoc) and follows the project's style.

5. **Commit your changes**:
   ```bash
   git commit -m "Add some feature"
   ```

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Submit a Pull Request**:
   Go to the original repository and click **New Pull Request**. Describe your changes clearly!
