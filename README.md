# Joke-API

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
