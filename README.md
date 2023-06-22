# DiaryApp - Order Management

DiaryApp is a Flutter application designed for time series analysis and efficient order management, primarily targeting a B2B (Business-to-Business) distribution model. It leverages Firebase as its robust backend for authentication, data storage, and real-time capabilities, complemented by Hive for local data persistence. The application provides a user-friendly interface for distributors to manage products, create orders, and track their history.

## Features

*   **User Authentication**: Secure user login and registration powered by Firebase Authentication.
*   **Distributor-Specific Product Catalog**: Dynamically loads product listings based on the authenticated distributor's assigned brands, including custom pricing.
*   **Product Browsing & Filtering**: Users can browse products and filter them by brand/category.
*   **Shopping Cart Management**: Add, remove, and update quantities of products in a persistent shopping cart.
*   **Order Creation**: Streamlined process for creating new orders.
*   **Order History**: View past orders and their details.
*   **Local Data Storage**: Utilizes Hive for efficient local storage of user profiles and other essential data, ensuring quick access and offline capabilities.
*   **Responsive UI**: Designed with Flutter's flexible UI framework, incorporating custom wave assets for a distinct visual appeal.

## Technologies Used

*   **Flutter**: Frontend framework for building natively compiled applications for mobile (Android & iOS).
*   **Firebase**: Backend-as-a-Service (BaaS) providing:
    *   **Firebase Authentication**: For secure user authentication and management.
    *   **Cloud Firestore**: A flexible, scalable NoSQL cloud database used for storing:
        *   **Distributor Data**: User profiles, including assigned brands and B2B status.
        *   **Product Data**: Products categorized by brand, with support for custom pricing per distributor.
    *   **Firebase Analytics**: (Implicitly used via `firebase_analytics` dependency, though not explicitly seen in the provided code snippets, it's a common Firebase integration).
    *   **Firebase App Check**: (Used via `firebase_app_check` dependency for app integrity).
*   **Hive**: A fast, lightweight, and powerful NoSQL database for local data storage, used for persisting `UserStore` objects.
*   **Provider**: A simple yet powerful state management solution for Flutter, used for managing `Products` and `Cart` data across the application.
*   **flutter_svg**: For rendering SVG assets, used for custom UI elements like waves.
*   **razorpay_flutter**: Integrated for payment gateway functionalities.
*   **intl**: For internationalization and localization, likely used for date/time or currency formatting.

## Architecture Overview

DiaryApp follows a clean architecture approach, separating concerns into distinct layers:

*   **`lib/main.dart`**: The application's entry point, responsible for initializing Firebase, Hive, and setting up the root widget (`MaterialApp`) with `MultiProvider` for global state management and `RouteGenerator` for navigation.
*   **State Management (Provider)**:
    *   **`lib/providers/products_provider.dart`**: Manages the application's product catalog. It fetches product data from Firestore, handles filtering by brand, and calculates prices (including tax and distributor-specific custom pricing).
    *   **`lib/providers/cart_provider.dart`**: Manages the user's shopping cart, allowing items to be added, removed, and quantities updated. It also calculates the total amount of items in the cart.
*   **Local Data Storage (Hive)**:
    *   **`lib/models/user_stored.dart`**: Defines the `UserStore` Hive object, which locally caches authenticated user details such as `username`, `id`, `email`, `route`, `brands` (assigned product categories), and `isB2B` status. This data is crucial for personalizing the user experience and fetching relevant product data.
    *   **`lib/models/boxes.dart`**: (Likely) A utility class to manage Hive boxes, providing easy access to stored data.
*   **Navigation (`lib/utils/route_generator.dart`)**: Centralizes route definitions and generation, ensuring a clean and maintainable navigation flow throughout the application.
*   **UI Components (`lib/static_assets/`)**: Contains custom SVG assets and widgets like `WaveSvg` and `BottomWave` used for unique visual elements in the application's design.

## Data Models

*   **`UserStore` (`lib/models/user_stored.dart`)**: Represents the locally stored profile of an authenticated user/distributor.
    *   `username`: User's display name.
    *   `id`: Unique identifier for the user (Firebase UID).
    *   `route`: User's assigned route.
    *   `email`: User's email address.
    *   `brands`: A list of strings representing the product brands/categories the distributor is authorized to view.
    *   `isB2B`: Boolean indicating if the user has a B2B (GST Regular) account.
*   **`Product` (`lib/providers/products_provider.dart`)**: Represents a single product item available in the catalog.
    *   `id`: Unique product identifier.
    *   `brand`: The brand/category the product belongs to.
    *   `title`: Product name.
    *   `description`: Product description.
    *   `price`: Product price including tax.
    *   `price_no_tax`: Product price excluding tax.
    *   `imageUrl`: URL to the product image.
    *   `PacketCount`: Quantity per packet.
*   **`CartItem` (`lib/providers/cart_provider.dart`)**: Represents an item within the shopping cart. Similar to `Product` but includes `quantity`.
*   **`OrderInstance` (`lib/models/order_instance.dart`)**: Represents a completed or pending order.
    *   `id`: Unique order identifier.
    *   `paymentType`: Method of payment.
    *   `otp`: One-Time Password (if applicable for order confirmation).
    *   `productList`: List of products in the order.
    *   `status`: Current status of the order.
    *   `totalPrice`: Total cost of the order.
    *   `route`: The route associated with the order.

## Firebase Data Structure (Conceptual)

*   **`Distributors` Collection**:
    *   Each document represents a distributor/user.
    *   Fields include `Email`, `Name`, `Route`, `GST Type` (determining `isB2B`), and `Brand` (comma-separated string of brands).
*   **Brand Collections (e.g., `company1`, `company2`)**:
    *   Each collection is named after a product brand.
    *   Documents within these collections represent individual products.
    *   Fields include `Name`, `Description`, `ImageURI`, `Price` (default), `Tax`, `PacketCount`.
    *   Custom pricing for distributors is stored as `Price_<distributorId>`.

## Installation

Follow these steps to get DiaryApp up and running on your local machine.

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (Stable channel recommended)
*   [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)
*   Node.js and npm (for Firebase CLI)

### Setup Steps

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/notBlue-org/cuddlyApp
    cd cuddlyApp
    ```

2.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Project Setup:**
    *   Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/).
    *   Add a new Android app and an iOS app to your Firebase project.
    *   Download the `google-services.json` file for Android and place it in `android/app/`.
    *   Download the `GoogleService-Info.plist` file for iOS and place it in `ios/Runner/`.
    *   **Important**: Ensure your Firestore database is set up with collections like `Distributors` and your product brand collections (e.g., `company1`, `company2`) with the described data structure.

4.  **Configure Firebase for Flutter:**
    *   Ensure you are logged in to Firebase CLI:
        ```bash
        firebase login
        ```
    *   Configure your Flutter project with Firebase:
        ```bash
        flutterfire configure
        ```
        Follow the prompts to select your Firebase project and platforms. This will generate `lib/firebase/firebase_options.dart`.

5.  **Run the application:**
    ```bash
    flutter run
    ```

## Usage

Once the application is running:

1.  **Login**: Use the login screen to authenticate. Ensure you have a corresponding entry in the `Distributors` collection in your Firebase Firestore.
2.  **Browse Products**: Navigate through different product brands/categories.
3.  **Add to Cart**: Select products and add them to your shopping cart.
4.  **Place Order**: Proceed to checkout and complete the order using the integrated payment gateway.
5.  **View History**: Check your order history.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you'd like to contribute code, please fork the repository and create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
