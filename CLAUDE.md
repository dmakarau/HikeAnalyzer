# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

- Open `HikeAnalyzer.xcodeproj` in Xcode, then `Cmd+R` to build and run.
- Use the `BuildProject` MCP tool to build from the CLI.
- Minimum deployment target: iOS 17.0. FoundationModels features require iOS 26+.

## Architecture

The app follows MVVM with a clear separation between Core (trail analysis) and AIChat (chat assistant) feature modules.

### Analysis Pipeline

User input → `TrailInputViewModel` → `TrailAnalysisViewModel.analyzeTrail()` → `IntelligentRiskAnalyzer` → `DetailedRiskAnalysis`

1. **`CoreMLTrailAnalyzer`** runs the bundled `TrailAnalyzerModel.mlmodel` to produce a base `Risk` prediction from distance, elevation, terrain, and wildlife inputs.
2. **`IntelligentRiskAnalyzer`** wraps that prediction and, if `FoundationModels` is available (iOS 26+), calls `SystemLanguageModel` / `LanguageModelSession` to generate a natural-language explanation, personalized recommendations, safety priorities, and gear suggestions. Falls back gracefully to a static message otherwise.
3. **`FeatureFlags.shared.simulateFoundationModelsAvailable`** (defaults `true`) can force-enable or force-disable the Foundation Models path for testing on older devices/simulators.

### AI Chat

`ChatViewModel` → `HikingAIService.generateResponse()` → `FoundationModels` or static fallback

`HikingAIService` uses the same `FeatureFlags` guard. The active system prompt is `ChatConstants.SystemPrompts.badPromt` — this is intentional for demo purposes.

### Design System

All styling lives in `Core/Modifiers/TrailTheme.swift`:
- `Color.theme` — `ColorTheme` struct with semantic color tokens
- `Font.theme` — `FontTheme` struct with rounded system fonts
- `CGFloat.spacing` — `Spacing` struct with xs/sm/md/lg/xl/xxl constants
- View modifiers: `.trailTheme()`, `.cardStyle()`, `.primaryButtonStyle()`, `.supportButtonStyle()`

### Observable Pattern

All ViewModels use `@Observable` + `@MainActor` (Swift Observation framework, not `ObservableObject`/Combine). Views instantiate ViewModels with `@State private var`.

### FoundationModels Availability Pattern

Both a compile-time guard and a runtime availability check are required:

```swift
#if canImport(FoundationModels)
import FoundationModels
#endif

// Runtime check
if #available(iOS 26.0, *) { ... }
```

## Custom Agents

Reusable agent workflows live in `.claude/agents/`:

| Agent | File | Purpose |
|-------|------|---------|
| Code Review | `review.md` | Enforces Swift/SwiftUI best practices and project conventions |
| Commit | `commit.md` | Generates developer-style commit messages (no AI mentions) |
| Investigate | `investigate.md` | Deep-dives into bugs and code flow questions using the most capable model |
| Architect | `architect.md` | Validates new code fits MVVM + service layer + design system conventions |
