# Tab Bar Documentation

## Overview

The Divide AI app's tab bar is implemented using Flutter with `go_router` for navigation. It uses a `ShellRoute` that wraps all main app routes, allowing the tab bar to be displayed on all main screens.

## Current Structure

### Main Files

- **`lib/app_routes.dart`**: Defines routes and configures the `ShellRoute`
- **`lib/core/tab_bar/tab_bar_widget.dart`**: Implements the tab bar widget

### Current Tabs

1. **Account** (`/`) - Icon: `Icons.home`
2. **New Item** (`/add-item`) - Icon: `Icons.add`
3. **Profile** (`/profile`) - Icon: `Icons.person`

## How It Works

### 1. Route Configuration

The `ShellRoute` in the `app_routes.dart` file wraps all main routes:

```dart
ShellRoute(
  builder: (context, state, child) => TabBarWidget(
    child: child,
  ),
  routes: [
    // Individual routes here
  ],
)
```

#### 1.1. How ShellRoute Works

The `ShellRoute` is a special type of route that works as a **"wrapper"** or **"shell"** that envelops other routes. It allows maintaining a shared layout (like the tab bar) always visible while the internal content changes.

**Structure:**
- **Fixed layout**: The `TabBarWidget` is rendered once and remains visible
- **Dynamic content**: The `child` parameter contains the current route's content
- **Navigation**: When you navigate between routes, only the `child` changes, but the `TabBarWidget` remains visible

**Rendering flow:**
```
┌─────────────────────────────────────┐
│           TabBarWidget              │ ← Fixed layout (always visible)
├─────────────────────────────────────┤
│                                     │
│        child (content)              │ ← Changes according to route
│                                     │
│  - HomeScreen (/)                   │
│  - AddItemScreen (/add-item)        │
│  - ProfileScreen (/profile)         │
│                                     │
└─────────────────────────────────────┘
```

**Builder parameters:**
- **`context`**: Flutter context
- **`state`**: Current route state (URL, parameters, etc.)
- **`child`**: Child route widget that will be rendered inside the shell

**Important**: If you don't use the `child` parameter in the builder, the child routes' content won't be displayed, resulting in an empty tab bar without content.

### 2. Tab Bar Widget

The `TabBarWidget` is responsible for:
- Managing the selected tab state
- Navigating between routes using `go_router`
- Rendering the Flutter `NavigationBar`

### 3. Navigation

When a tab is selected:
1. The `_selectedIndex` state is updated
2. Navigation is executed using `context.goNamed(_routes[index])`
3. The `go_router` loads the corresponding screen

## How to Add a New Tab

### Step 1: Create the Screen

First, create the screen that will be displayed in the new tab. For example:

```dart
class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('New Screen'),
      ),
    );
  }
}
```

### Step 2: Add the Route

In the `lib/app_routes.dart` file, add a new `GoRoute` inside the `ShellRoute`:

```dart
GoRoute(
  path: '/new-screen',
  name: 'new-screen',
  builder: (context, state) => const NewScreen(),
),
```

### Step 3: Update the Tab Bar

In the `lib/core/tab_bar/tab_bar_widget.dart` file:

1. **Add the route to the `_routes` list**:
```dart
final List<String> _routes = [
  'home',
  'add-item',
  'profile',
  'new-screen', // New route
];
```

2. **Add the destination to the `NavigationBar`**:
```dart
destinations: [
  NavigationDestination(
    icon: Icon(Icons.home),
    label: 'Account',
  ),
  NavigationDestination(
    icon: Icon(Icons.add),
    label: 'New Item',
  ),
  NavigationDestination(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
  NavigationDestination(
    icon: Icon(Icons.new_icon), // Choose an appropriate icon
    label: 'New Screen',
  ),
],
```

### Step 4: Import the New Screen

In the `lib/app_routes.dart` file, add the import for the new screen:

```dart
import 'package:divide_ai/features/new_feature/new_screen.dart';
```

## Best Practices

1. **Naming**: Use descriptive names for routes and labels
2. **Icons**: Choose icons that well represent the screen's functionality
3. **Organization**: Keep screens organized in folders by feature
4. **Consistency**: Maintain the existing naming pattern

## Recommended Folder Structure

```
lib/
├── features/
│   ├── home/
│   │   └── home_screen.dart
│   ├── new_feature/
│   │   └── new_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── core/
│   └── tab_bar/
│       └── tab_bar_widget.dart
└── app_routes.dart
```

## Important Notes

- The tab bar is persistent on all main screens
- The selected tab state is maintained locally in the widget
- Navigation uses `go_router` for declarative routing
- All main routes must be inside the `ShellRoute`
