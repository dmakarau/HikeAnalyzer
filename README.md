# 🏔️ HikeAnalyzer

A modern iOS app that provides intelligent trail risk assessment using machine learning to help hikers plan safer adventures.

## 🛠️ Tech Stack

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.9+-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-007AFF?style=for-the-badge&logo=swift&logoColor=white)
![Core ML](https://img.shields.io/badge/Core%20ML-5.0+-34C759?style=for-the-badge&logo=apple&logoColor=white)
![Foundation](https://img.shields.io/badge/Foundation-iOS%2017+-000000?style=for-the-badge&logo=apple&logoColor=white)

![Xcode](https://img.shields.io/badge/Xcode-15.0+-147EFB?style=for-the-badge&logo=xcode&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17.0+-007AFF?style=for-the-badge&logo=ios&logoColor=white)
![Educational](https://img.shields.io/badge/Purpose-Educational-4CAF50?style=for-the-badge&logo=graduation-cap&logoColor=white)

</div>

## 📱 Screenshots

<p align="center">
  <img src="docs/screenshot/main-screen.png" width="250" alt="Main Screen">
  <img src="docs/screenshot/analysis-result.png" width="250" alt="Analysis Result">
  <img src="docs/screenshot/risk-guide.png" width="250" alt="Risk Levels Guide">
</p>

## ✨ Features

### 🎯 **Intelligent Risk Assessment**
- **Machine Learning Analysis**: Advanced ML model analyzes trail parameters to predict risk levels
- **Comprehensive Evaluation**: Considers distance, elevation, terrain type, and wildlife danger
- **Real-time Results**: Instant risk assessment with detailed explanations

### 🎨 **Modern Design**
- **Professional UI**: Clean, modern interface with smooth animations
- **Intuitive Input**: Easy-to-use form with smart input validation
- **Visual Feedback**: Color-coded risk levels with progress indicators
- **Responsive Layout**: Optimized for all iPhone screen sizes

### 📊 **Risk Categories**
- **🟢 Easy**: Perfect for beginners and casual outdoor enthusiasts
- **🟡 Moderate**: Suitable for hikers with some experience and fitness
- **🟠 Difficult**: Challenging trail requiring good fitness and experience
- **🔴 High Risk**: Expert level with significant challenges and dangers

### 💡 **Smart Recommendations**
- **Personalized Tips**: Contextual advice based on risk level
- **Safety Guidelines**: Essential preparation recommendations
- **Equipment Suggestions**: Risk-appropriate gear recommendations

## 🛠️ Technical Features

### **Core Technologies**

| Technology | Version | Purpose |
|------------|---------|---------|
| ![Swift](https://img.shields.io/badge/Swift-5.9+-FA7343?style=flat-square&logo=swift&logoColor=white) | 5.9+ | Primary programming language |
| ![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-007AFF?style=flat-square&logo=swift&logoColor=white) | 4.0+ | Declarative UI framework |
| ![Core ML](https://img.shields.io/badge/Core%20ML-5.0+-34C759?style=flat-square&logo=apple&logoColor=white) | 5.0+ | On-device machine learning |
| ![Foundation](https://img.shields.io/badge/Foundation-iOS%2017+-000000?style=flat-square&logo=apple&logoColor=white) | iOS 17+ | Core data types and models |

### **Key Features**
- **State Management**: SwiftUI's native `@State` and `@Binding`
- **Custom UI Components**: Reusable SwiftUI views and modifiers
- **ML Integration**: Core ML model for risk prediction
- **Modern Design**: Custom color system and animations

### **Design System**
- **Custom Color Palette**: Professional gradient-based theme
- **Typography Hierarchy**: Consistent font system with SF Pro
- **Spacing System**: Standardized spacing for perfect alignment
- **Animation Framework**: Smooth micro-interactions and transitions

### **Development Tools**
- **Xcode 15.0+**: Primary IDE
- **iOS Simulator**: Testing and debugging
- **Instruments**: Performance profiling
- **Git**: Version control

### **Input Components**
- **Smart Text Fields**: Numeric input with validation
- **Modern Pickers**: Intuitive selection for terrain types
- **Segmented Controls**: Easy wildlife danger selection
- **Interactive Cards**: Touch-friendly input containers

## 🚀 Getting Started

### **System Requirements**

<div align="center">

![macOS](https://img.shields.io/badge/macOS-Ventura%2013.0+-000000?style=for-the-badge&logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-147EFB?style=for-the-badge&logo=xcode&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17.0+-007AFF?style=for-the-badge&logo=ios&logoColor=white)

</div>

### **Development Requirements**
- **macOS Ventura 13.0** or later
- **Xcode 15.0** or later  
- **iOS 17.0** SDK or later
- **Apple Developer Account** (for device testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/dmakarau/HikeAnalyzer.git
   cd HikeAnalyzer
   ```

2. **Open in Xcode**
   ```bash
   open HikeAnalyzer.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## 📋 Usage

### 1. **Enter Trail Details**
- **Distance**: Enter the total hiking distance in kilometers
- **Elevation Change**: Input the total elevation gain in meters
- **Terrain Type**: Select from Paved, Dirt, Rocky, or Sandy
- **Wildlife Danger**: Choose between Low or High risk

### 2. **Get Risk Assessment**
- Tap "Analyze Trail" to process your input
- View your personalized risk level with detailed explanation
- Read contextual tips and recommendations

### 3. **Explore Risk Levels**
- Access the "Risk Levels Guide" for comprehensive information
- Understand different difficulty categories
- Learn about requirements for each risk level

## 🧠 Machine Learning Model

The app uses a custom Core ML model trained on trail data to predict risk levels based on:

- **Distance Factor**: Longer trails increase fatigue and exposure time
- **Elevation Impact**: Steep climbs affect difficulty and oxygen levels
- **Terrain Analysis**: Surface type influences stability and navigation
- **Wildlife Assessment**: Animal encounters affect safety considerations

## 🎨 Design Philosophy

### **User-Centric Design**
- Minimalist interface focusing on essential information
- Clear visual hierarchy guiding user attention
- Consistent interactions throughout the app

### **Accessibility First**
- High contrast colors for better readability
- Scalable typography supporting Dynamic Type
- VoiceOver compatibility for screen readers

### **Performance Optimized**
- Lightweight Core ML model for instant results
- Efficient SwiftUI rendering with optimized layouts
- Smooth 60fps animations and transitions

## 🔧 Development

### **Project Structure**
```
HikeAnalyzer/
├── App/                    # App entry point
├── Core/
│   ├── Model/             # Data models and ML integration
│   ├── View/              # SwiftUI views and screens
│   └── Modifiers/         # Custom view modifiers and themes
└── Resources/             # Assets and ML model files
```

### **Key Components**
- **TrailAnalyzer**: Core ML model integration
- **TrailTheme**: Design system and styling
- **RiskCardView**: Animated risk presentation
- **HikeInputView**: Reusable input component

## 🤝 Contributing

This is a personal educational project, but feel free to fork it and make your own improvements! If you have suggestions or find bugs, please open an issue.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##  Acknowledgments

- SwiftUI community for design inspiration
- Core ML team for machine learning framework
- iOS design guidelines for user experience principles

---

<div align="center">

### 📊 Project Stats

![GitHub repo size](https://img.shields.io/github/repo-size/dmakarau/HikeAnalyzer?style=flat-square)
![GitHub code size](https://img.shields.io/github/languages/code-size/dmakarau/HikeAnalyzer?style=flat-square)
![GitHub top language](https://img.shields.io/github/languages/top/dmakarau/HikeAnalyzer?style=flat-square&color=FA7343)
![GitHub last commit](https://img.shields.io/github/last-commit/dmakarau/HikeAnalyzer?style=flat-square)

### 🏷️ Tags

![Machine Learning](https://img.shields.io/badge/-Machine%20Learning-FF6B35?style=flat-square)
![iOS Development](https://img.shields.io/badge/-iOS%20Development-007AFF?style=flat-square)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-FA7343?style=flat-square)
![Hiking](https://img.shields.io/badge/-Hiking-34C759?style=flat-square)
![Risk Assessment](https://img.shields.io/badge/-Risk%20Assessment-FF9500?style=flat-square)

**Built with ❤️ using SwiftUI and Core ML**

</div>