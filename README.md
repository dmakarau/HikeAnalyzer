# HikeAnalyzer

An iOS app for trail risk assessment. Uses Core ML for predictions and includes an AI chat assistant for hiking advice.

## Tech Stack

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.9+-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-007AFF?style=for-the-badge&logo=swift&logoColor=white)
![Core ML](https://img.shields.io/badge/Core%20ML-5.0+-34C759?style=for-the-badge&logo=apple&logoColor=white)
![FoundationModels](https://img.shields.io/badge/FoundationModels-AI%20LLM-FF6B35?style=for-the-badge&logo=apple&logoColor=white)
![Async/Await](https://img.shields.io/badge/Async%2FAwait-Concurrency-9B59B6?style=for-the-badge&logo=swift&logoColor=white)
![Foundation](https://img.shields.io/badge/Foundation-iOS%2017+-000000?style=for-the-badge&logo=apple&logoColor=white)

![Xcode](https://img.shields.io/badge/Xcode-15.0+-147EFB?style=for-the-badge&logo=xcode&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17.0+-007AFF?style=for-the-badge&logo=ios&logoColor=white)
![Educational](https://img.shields.io/badge/Purpose-Educational-4CAF50?style=for-the-badge&logo=graduation-cap&logoColor=white)

</div>

## Screenshots

<p align="center">
  <img src="docs/screenshot/main-screen.png" width="200" alt="Main Screen">
  <img src="docs/screenshot/analysis-result.png" width="200" alt="Analysis Result">
  <img src="docs/screenshot/ai-assistant.png" width="200" alt="AI Assistant">
  <img src="docs/screenshot/risk-guide.png" width="200" alt="Risk Levels Guide">
</p>

## Features

### AI Hiking Assistant
- Chat interface for hiking questions and advice
- Uses Apple's FoundationModels on supported devices (iOS 26+)
- Falls back to curated knowledge base on older devices
- Covers gear, safety, weather, and trail planning topics

### Risk Assessment
- Core ML model predicts trail difficulty
- Takes distance, elevation, terrain, and wildlife into account
- Shows risk level with personalized recommendations
- Optional AI-enhanced explanations when available

### Risk Categories
- **Easy**: Good for beginners
- **Moderate**: Some experience recommended
- **Difficult**: Requires fitness and experience
- **High Risk**: Expert-level trails

## Getting Started

### Requirements
- macOS Ventura 13.0+
- Xcode 15.0+
- iOS 17.0+ SDK

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

## Usage

1. **Enter trail details**: distance, elevation, terrain type, wildlife danger
2. **Tap "Analyze Trail"** to get your risk assessment
3. **Use AI Support** for hiking questions and advice
4. **Check Risk Levels Guide** to understand the categories

## How It Works

### AI Assistant
On iOS 26+ devices with FoundationModels support, the chat uses on-device AI. On older devices, it uses a curated knowledge base covering common hiking topics. Both provide the same user experience.

### Risk Model
The Core ML model considers:
- **Distance**: Longer trails mean more fatigue
- **Elevation**: Steep climbs increase difficulty
- **Terrain**: Surface type affects stability
- **Wildlife**: Potential animal encounters

## Design Notes

- Clean, minimal interface
- Supports Dynamic Type and VoiceOver
- Lightweight ML model for fast predictions

## Project Structure

```
HikeAnalyzer/
├── App/                    # App entry point
├── AIChat/                 # AI assistant functionality
│   ├── Models/            # Chat message data models
│   ├── Services/          # AI service integration
│   ├── ViewModels/        # Chat business logic
│   └── Views/             # Chat interface components
├── Core/
│   ├── Model/             # Data models and ML integration
│   ├── View/              # SwiftUI views
│   └── Modifiers/         # View modifiers and themes
└── Resources/             # Assets and ML model
```

### Key Components
- **CoreMLTrailAnalyzer**: ML model wrapper
- **ChatViewModel**: Chat state management
- **HikingAIService**: FoundationModels + fallback logic
- **TrailTheme**: Colors and styling

## Contributing

This is a personal project for learning. Feel free to fork it or open an issue if you find bugs.

## Changelog

### December 2025
- Added Apple Intelligence integration via FoundationModels (iOS 26+)
- Fallback system for devices without FoundationModels support
- AI-enhanced risk explanations and recommendations

### Earlier Updates
- Migrated to `@Observable` from `@ObservableObject`
- MVVM refactoring with ChatViewModel
- Decomposed views into smaller components
- Added ChatConstants for string management
- Keyboard dismissal improvements

## License

MIT License - see [LICENSE](LICENSE).

## Acknowledgments

- SwiftUI community
- Apple's Core ML and FoundationModels teams

---

Built with SwiftUI, Core ML, and FoundationModels.