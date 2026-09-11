# TheCakeList

A native SwiftUI app that fetches, displays, refreshes, and de-duplicates a list of cakes.

## Features

- Loads cakes from the supplied remote API.
- De-duplicates and alphabetically sorts the list by title.
- Supports pull-to-refresh while preserving the last successful list if a refresh fails.
- Shows retry and refresh-error states.
- Presents a cake detail sheet with image and description.
- Uses accessible image fallbacks for unavailable images.

## Architecture

The app uses a small feature-based MVVM structure:

```text
CakeListView
    └── CakeListViewModel
            └── CakeService
                    └── RemoteCakeService
                            └── APIClient
                                    └── URLSessionAPIClient
```

- `Features/` contains views and lightweight view models.
- `Networking/` owns request construction, transport, response validation, and decoding.
- `Models/` contains API-facing value types.
- `Strings/` centralizes user-visible strings.
- Dependencies are injected at the composition root in `TheCakeListApp`.

## Concurrency

The app target uses Swift 6 with MainActor as its default isolation for UI code. Networking protocols and implementations explicitly opt into concurrent execution, so URL requests and JSON decoding do not run on the UI actor.

Transport models conform to `Sendable`, and test doubles use actors to protect mutable state while exercising the same concurrency contracts as production code.

## Configuration

The API base URL is stored in `TheCakeList/Configuration/Base.xcconfig` and passed into the app bundle through `Info.plist`:

```text
API_BASE_URL = https://raw.githubusercontent.com/Waracle/mobile-coding-test-api/refs/heads/main
```

At launch, `AppConfiguration` reads `API_BASE_URL`. The app stops early if that value is absent or invalid, avoiding requests with an invalid endpoint.

## Requirements

- Xcode with Swift 6 support
- iOS 17.6 or later

## Running the app

1. Open `TheCakeList.xcodeproj` in Xcode.
2. Select the `TheCakeList` scheme.
3. Choose an iOS simulator or device running iOS 17.6 or later.
4. Build and run.

## Tests

The test suite covers:

- API-service success and error forwarding.
- Cake-list loading, sorting, and duplicate removal.
- Refresh success and refresh-failure state preservation.

Run the tests with **Product → Test** in Xcode, or from the command line:

```sh
xcodebuild test \
  -project TheCakeList.xcodeproj \
  -scheme TheCakeList \
  -destination 'platform=iOS Simulator,name=<simulator name>'
```

Replace `<simulator name>` with an installed simulator name.
