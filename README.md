# Joke-App
A Flutter app that fetches and caches jokes using the shared_preferences package. The app works seamlessly in both online and offline modes, ensuring a smooth user experience.
## Caching Mechanism  

The app uses the `shared_preferences` package to store jokes locally, enabling offline access.  

### How Caching Works  

#### Online Mode  
- Fetches jokes from the API.  
- Stores the fetched jokes in `shared_preferences` as a JSON string.  
- Displays the jokes in the app UI.  

#### Offline Mode  
- If the API call fails (e.g., no internet connection), the app fetches jokes from `shared_preferences`.  
- Cached jokes are deserialized into a usable format and displayed in the UI.  

---

## Serialization and Deserialization  

Serialization and deserialization ensure that jokes are stored and retrieved in a structured format.  

### Serialization  
- Converts the fetched jokes (a Dart `List<Map<String, dynamic>>`) into a JSON string using `jsonEncode`.  
- The JSON string is stored in `shared_preferences`.  

### Deserialization  
- Reads the JSON string from `shared_preferences`.  
- Converts it back into a Dart `List<Map<String, dynamic>>` using `jsonDecode`.  
- This deserialized data is used to populate the joke list when offline.  

---

## Features  

- Fetch jokes dynamically from the API.  
- Cache jokes locally for offline access.  
- User-friendly UI with filtering options for joke types.  

---

## Getting Started  

### Prerequisites  
- Flutter SDK installed  
- Internet connection for the initial fetch  

### Installation  
1. Clone the repository:  
   ```bash  
   git clone <repository-url>  
   cd joke_app
   
![Screenshot_20241221-115915 (2)](https://github.com/user-attachments/assets/f7c9f2ec-2a03-4c55-9c83-d0099e79e993)

### Run the Command to Create a New Flutter App   
Use the flutter create command followed by the app name:
```bash
flutter create your_app_name
```

## When to Use Dio?
When your app requires advanced HTTP features like interceptors, retries, or custom headers.    

When you need to upload/download files.      

When you want a robust, flexible solution for REST API interactions.     

If you only need very basic requests (like one or two GET calls), the http package may suffice. But for most real-world apps with more complex needs, dio is an excellent choice!      

The dio package is a powerful and flexible HTTP client for Dart that is widely used in Flutter apps for handling network requests. It offers a lot of features that make it a great choice compared to Flutter's built-in http package.     

### Command to Add the Dio Package     

Run the following command in your terminal within your Flutter project's directory:  
```bash
flutter pub add dio
```

### What Happens?
This command automatically:   
Adds the latest version of dio to the dependencies section in your pubspec.yaml file.    
To fetch the package:     
```bash
flutter pub get
```






