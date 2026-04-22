# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Build & Run

- Open `HikeAnalyzer.xcodeproj` in Xcode, then `Cmd+R` to build and run.
- Target device: iOS 26 simulator or physical device running iOS 26+.
- FoundationModels (on-device AI) requires iOS 26+ and Apple Intelligence enabled.

## Architecture

The app follows MVVM with a clear separation between `Core` (trail analysis) and `AIChat` (chat assistant) feature modules.

### Module Structure

```
HikeAnalyzer/
├── App/
│   └── HikeAnalyzerApp.swift
├── Core/
│   ├── Model/          — data models, CoreML wrapper, risk analysis
│   ├── Services/       — CoreMLTrailAnalyzer, FeatureFlags
│   ├── View/           — SwiftUI screens
│   ├── ViewModels/     — TrailInputViewModel, TrailAnalysisViewModel
│   └── Modifiers/      — TrailTheme (design system)
└── AIChat/
    ├── Models/         — ChatMessage, ChatConstants
    ├── Services/       — HikingAIService
    ├── ViewModels/     — ChatViewModel
    └── Views/          — chat UI components
```

### Analysis Pipeline

`TrailInputViewModel` → `TrailAnalysisViewModel.analyzeTrail()` → `IntelligentRiskAnalyzer` → `DetailedRiskAnalysis`

1. **`CoreMLTrailAnalyzer`** runs `TrailAnalyzerModel.mlmodel` (static method `predictRisk(for:)`) to produce a base `Risk` prediction from distance, elevation, terrain, and wildlife inputs.
2. **`IntelligentRiskAnalyzer`** wraps that prediction and, when FoundationModels is available, calls `SystemLanguageModel` / `LanguageModelSession` to generate a natural-language explanation, recommendations, safety priorities, and gear suggestions into a `DetailedRiskAnalysis`.
3. **`FeatureFlags.shared.simulateFoundationModelsAvailable`** (defaults `true`) can force-enable or disable the FoundationModels path for testing.

### AI Chat

`ChatViewModel` → `HikingAIService` → `FoundationModels`

The chat uses tool calling (iOS 26) and `@Generable` structured output. When the user describes a trail, the AI autonomously invokes `CoreMLTrailAnalyzer` as a tool and returns a typed `TrailAnalysisReport` struct rendered as a rich card.

### Design System

All styling lives in `Core/Modifiers/TrailTheme.swift`:
- `Color.theme` — `ColorTheme` with semantic color tokens
- `Font.theme` — `FontTheme` with rounded system fonts
- `CGFloat.spacing` — `Spacing` with xs/sm/md/lg/xl/xxl constants
- View modifiers: `.trailTheme()`, `.cardStyle()`, `.primaryButtonStyle()`, `.supportButtonStyle()`

Always use these constants. Never use raw numbers for colors, fonts, or spacing.

### Observable Pattern

All ViewModels use `@Observable` + `@MainActor`. Views instantiate ViewModels with `@State private var`. Never use `ObservableObject`, `@Published`, or Combine.

### FoundationModels Availability Pattern

Both a compile-time guard and a runtime check are required every time:

```swift
#if canImport(FoundationModels)
import FoundationModels
#endif

if #available(iOS 26.0, *) { ... }
```

---

## Swift Standards

Write modern Swift. These are non-negotiable:

- **Swift 6 concurrency** — `async/await`, `@MainActor`, `actor` where appropriate. No completion handlers or Combine chains in new code.
- **`@Observable`** — for all ViewModels. Never `ObservableObject`.
- **Value types** — prefer `struct` over `class` for models. Use `class` only for reference semantics (ViewModels, services that hold state).
- **`@Generable` / `@Guide`** — for any FoundationModels structured output.
- **No force unwraps** — use `guard let`, `if let`, or `??`. The only exception is test code.
- **No comments explaining what code does** — name things clearly instead. Only write a comment when the *why* is non-obvious (a workaround, a hidden constraint, a subtle invariant).
- **No magic numbers** — use `TrailTheme` spacing/color constants.
- **Error handling** — use typed errors with `enum … : Error`. Avoid catching and swallowing errors silently.
- **Access control** — default to `private`/`fileprivate`. Only expose what consumers need.
- **Extensions** — group protocol conformances in `// MARK: -` separated extensions.

---

## Commit Messages

- Short and concise — one line, present tense, sentence case
- Human-readable — write as a developer would, not a robot
- No emojis, no ticket numbers, no "refactor:", "feat:", "fix:" prefixes
- Bad: `✨ feat: Add @Generable structured output for trail analysis`
- Good: `Add structured trail analysis report using @Generable`
- Bad: `Fix bug in ChatViewModel where session was recreated on every message`
- Good: `Persist LanguageModelSession across chat turns`

---

## Branching

- `main` — stable, always builds
- `feature/<short-description>` — new features
- `fix/<short-description>` — bug fixes

---

## Custom Agents

Reusable agent workflows in `.claude/agents/`:

| Agent | File | Purpose |
|-------|------|---------|
| Review | `review.md` | Full code review using Opus — enforces Swift standards, architecture, security |
| Commit | `commit.md` | Generates human-style commit messages |
| Test | `test.md` | Writes and runs unit/UI tests |
| Architect | `architect.md` | Validates new code fits MVVM + service layer + design system |
| Investigate | `investigate.md` | Deep-dives into bugs and unexpected behavior |
| Refactor | `refactor.md` | Identifies and applies safe refactoring opportunities |
| Security | `security.md` | iOS-focused security review |
