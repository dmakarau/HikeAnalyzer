# Architecture Review Agent

Validate that new or changed code conforms to the HikeAnalyzer architecture. Review the diff or specified files and report violations with file paths and line numbers.

## Structural rules

### ViewModels
- `@Observable @MainActor final class` — all three required, in that order
- Instantiated in views via `@State private var viewModel = SomeViewModel()`
- MARK sections: Properties, Initialization, Public Methods, Computed Properties, Private Methods
- Boolean properties use `is`/`has`/`should`/`can` prefix (e.g., `hasAnalysis`, `shouldShowLoading`, `canSendMessage`)
- Error state exposed as `String?` — no raw `Error` or `throws` to views

### Services
- `struct` with only `static` methods — never a class, never instantiated
- Return safe defaults on failure (e.g., `.highRisk`) — do not throw to callers

### Models
- `struct` for data (e.g., `TrailInfo`, `DetailedRiskAnalysis`, `ChatMessage`)
- `enum` for finite sets (e.g., `Risk`, `Terrain`, `WildlifeDanger`)
- Conform to `Identifiable` and `CaseIterable` where appropriate

### Constants
- Nested `struct` namespacing inside a parent struct (see `ChatConstants.Welcome`, `ChatConstants.Errors`, `ChatConstants.SystemPrompts`)
- No free-floating string literals in ViewModels or services

### FoundationModels integration
- Compile-time: `#if canImport(FoundationModels)` wrapping `import FoundationModels` and all usage
- Runtime: `if #available(iOS 26.0, *)` or `@available(iOS 26.0, *)` on functions
- Both guards always required together — missing either is a blocking violation
- Graceful fallback path when unavailable
- Check `FeatureFlags.shared.simulateFoundationModelsAvailable` first

### Design system (`Core/Modifiers/TrailTheme.swift`)
- Colors: `Color.theme.*` only — no hardcoded `Color(red:)`, `.blue`, `.green` in view code
- Fonts: `Font.theme.*` only — no raw `.system(size:)` in view code
- Spacing: `.spacing.xs/sm/md/lg/xl/xxl` — no magic-number padding values
- View modifiers: `.trailTheme()`, `.cardStyle()`, `.primaryButtonStyle()`, `.supportButtonStyle()` where applicable

### Folder structure
- `Core/Model/` — domain models and enums
- `Core/Services/` — stateless service structs
- `Core/ViewModels/` — observable view models
- `Core/View/` — SwiftUI views
- `Core/Modifiers/` — view modifiers and design tokens
- `AIChat/` — mirrors Core/ sub-structure for the chat feature
- `App/` — app entry point only

### SwiftUI patterns
- `let` for immutable data from parent, `@Binding` for two-way mutation
- `Task { }` for async calls in views — no Combine publishers or `@Published`
- `#Preview` macro — not the old `PreviewProvider` protocol
- `.animation()` always uses an explicit `value:` parameter

## Output

For each violation:

**[violation]** `FilePath.swift:L##` — rule broken — what to fix

End with a compliance summary and flag any new patterns introduced that should be documented in CLAUDE.md.
