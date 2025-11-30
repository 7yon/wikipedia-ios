# Branch Summary: feature/deeplinking-places-with-coordinates


## Overview
This branch implements deep linking functionality for the **Places** tab, allowing the app to open directly to the Places view centered on specific geographic coordinates.

## Key Changes

### Deep Link Parsing
- **`NSUserActivity+WMFExtensions`**: Updated to parse `latitude` and `longitude` query parameters from the `wikipedia://places` URL scheme.

### View Controller Updates
- **`WMFAppViewController`**: Updated to handle the `.places` deep link type with associated parameters and propagate them to the navigation stack.
- **`PlacesViewController`**: Enhanced to accept an optional `CLLocationCoordinate2D`. If provided, the map will center on these coordinates upon loading.

### Documentation & Testing
- **`docs/url_schemes.md`**: Added documentation for the new URL format: `wikipedia://places?latitude=...&longitude=...`.
- **Unit Tests**: Added tests to verify that the deep link parser correctly extracts coordinate parameters.

## How to Test

You can test this feature using the iOS Simulator.

1.  **Build and Run** the app on a simulator.
2.  **Open a Deep Link** using the terminal:

```bash
xcrun simctl openurl booted "wikipedia://places?latitude=52.3676&longitude=4.9041"
```

This command should open the app, navigate to the Places tab, and center the map on Amsterdam (or the coordinates provided).
