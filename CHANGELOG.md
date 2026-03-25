# Changelog

All notable changes to this project will be documented in this file.

## [1.0.4] - 2026-03-25

### Added
- New `activeIconColor` and `inactiveIconColor` properties in `TabData` for granular icon color control.
- Integrated **Haptic Feedback** (`selectionClick`) to tab selection for a tactile user experience.
- Added **Razorpay Donate** button and support links to README.
- Included a detailed **Contribution Guide** in README to streamline community involvement.
- Added comprehensive **DartDoc** comments for all public APIs across the library.

### Changed
- Implemented `RepaintBoundary` for the navigation bar background and moving arc to significantly reduce paint workloads.
- Optimized `HalfPainter` and `HalfClipper` to eliminate redundant repaints/reclips.
- Refined animation curves to `Curves.easeInOut` for smoother, more organic transitions.
- Redesigned `README.md` for improved SEO and overall readability.
- Applied `const` constructor optimizations throughout the codebase.

## [1.0.3] - 2024-03-20

### Changed
- Updated package to support Dart 2.12 (Null Safety).

## [1.0.2] - 2023-11-15

### Fixed
- Added necessary `mounted` checks to `setState` calls to prevent crashes after disposal.

## [1.0.1] - 2023-06-10

### Changed
- Updated for full Dart 3.0 compatibility.

## [1.0.0] - 2023-01-05

### Added
- Initial stable release of `fancy_bottom_navigation_plus`.

## [0.1.1] - 2022-10-12

### Changed
- Updated preview GIF in the project documentation.

## [0.1.0] - 2022-08-15

### Changed
- Improved Arc UI rendering for smoother visuals.

## [0.0.1] - 2022-05-01

### Added
- Initial project creation with core animated bottom navigation functionality.