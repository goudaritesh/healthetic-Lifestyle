# Healthetic Flutter Login Assignment

## Description
A beautifully designed and animated Flutter project featuring a modern login, signup, and forgot password flow. This was built as part of the Healthetic internship assignment to demonstrate UI/UX implementation, form validation, and animations in Flutter.

## Screenshots

| Idle State | Focused State |
|:---:|:---:|
| <!-- TODO: Add idle state screenshot --> `![Idle State](screenshots/idle.png)` | <!-- TODO: Add focused state screenshot --> `![Focused State](screenshots/focused.png)` |

| Validation Errors | Loading State |
|:---:|:---:|
| <!-- TODO: Add validation error screenshot --> `![Validation Errors](screenshots/error.png)` | <!-- TODO: Add loading state screenshot --> `![Loading State](screenshots/loading.png)` |

## Prerequisites
- **Flutter SDK:** 3.x
- **Dart SDK:** ^3.8.1

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/[your-username]/healthetic-flutter-login-assignment-ritesh.git
   ```

2. **Navigate to the project folder:**
   ```bash
   cd healthetic-flutter-login-assignment-ritesh
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Demo Video
- [Link to Demo Video](<!-- TODO: Insert Video Link Here -->)

## Approach and Design Decisions
- **UI/UX & Design:** Focused on a modern, clean aesthetic using a vibrant color palette to give it a premium feel. Added subtle fade-in and scale animations to improve the overall flow.
- **Code Quality:** Organized the code into modular files under `lib/screens/` to ensure reusability and clean architecture. Used custom reusable widgets and an `AnimatedEntrance` helper to stagger animations.
- **Functionality:** Implemented robust form validation to handle edge cases like empty fields, invalid email formats, and string length requirements. Animated states transitions (e.g., form submission loading states and success dialogs).
