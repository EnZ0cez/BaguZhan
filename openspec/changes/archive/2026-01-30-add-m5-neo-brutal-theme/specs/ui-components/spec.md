# UI Components Specification Increment

## ADDED Requirements

### Requirement: Neo-Brutal Theme System

系统 MUST provide unified Neo-Brutal design style theme configuration.

#### Scenario: Get Theme Colors
- **When** App requests primary color
- **Then** Return `#58CC02` (Duo green)

#### Scenario: Get Hard Shadow Config
- **When** Component requests shadow config
- **Then** Return shadow with no blur, offset `(0, 6)`

#### Scenario: Get Border Config
- **When** Component requests border config
- **Then** Return border with width `3px`, color `#2D3436`

---

### Requirement: NeoContainer Base Container

系统 MUST provide container component with Neo-Brutal style.

#### Scenario: Render Container with Border and Shadow
- **When** Render NeoContainer
- **Then** Display 3px black border and (0, 6) hard shadow

#### Scenario: Pressed State
- **When** User taps container
- **Then** Container shifts down 4px, shadow disappears

#### Scenario: Custom Background Color
- **When** Pass `color` parameter
- **Then** Container uses specified color as background

---

### Requirement: NeoButton

系统 MUST provide Neo-style buttons with multiple sizes.

#### Scenario: Render Primary Button
- **When** Render NeoPrimaryButton
- **Then** Display green background, white text, black border, hard shadow

#### Scenario: Button Press Feedback
- **When** User presses button
- **Then** Button visually "sinks" (offset + shadow disappears)

#### Scenario: Button Disabled State
- **When** Button `onPressed` is null
- **Then** Display gray, no interaction effect

#### Scenario: Multiple Sizes
- **When** Specify `size` as small/medium/large
- **Then** Corresponding height is 40/48/56

---

### Requirement: NeoCard Stats Card

系统 MUST provide card component for displaying statistics.

#### Scenario: Render Stats Card
- **When** Render NeoCard
- **Then** Display white background, black border, hard shadow

#### Scenario: Card with Icon
- **When** Pass `icon` parameter
- **Then** Icon displays at top-left of card

#### Scenario: Card Layout
- **When** Multiple cards arranged horizontally
- **Then** Card spacing is 12px, equal width distribution

---

### Requirement: NeoProgressRing

系统 MUST provide SVG-style circular progress bar component.

#### Scenario: Render Progress Ring
- **When** Pass `progress` parameter (0.0 - 1.0)
- **Then** Draw colored arc corresponding to ratio

#### Scenario: Progress Label
- **When** Pass `label` parameter
- **Then** Display text in center of ring

#### Scenario: Animation Effect
- **When** Progress value changes
- **Then** Arc transitions smoothly (500ms)

---

### Requirement: NeoStatBar

系统 MUST provide top statistics bar component.

#### Scenario: Render Stats Bar
- **When** Render NeoStatBar
- **Then** Display 4 stats horizontally (fire/accuracy/questions/xp)

#### Scenario: Stat Icons and Colors
- **When** Display fire stat
- **Then** Use fire icon and orange color

#### Scenario: Data Update
- **When** New data passed
- **Then** Numbers animate with rolling effect

---

### Requirement: NeoUnitBanner

系统 MUST display banner for current learning unit.

#### Scenario: Render Unit Banner
- **When** Render NeoUnitBanner
- **Then** Display green background, white text, current unit info

#### Scenario: Banner Format
- **When** Pass unit and part info
- **Then** Display "Unit X, Part Y: [Topic Name]" format

---

### Requirement: NeoBottomNav

系统 MUST provide Neo-style bottom navigation bar.

#### Scenario: Render Navigation Bar
- **When** Render NeoBottomNav
- **Then** Display 5-6 navigation icons

#### Scenario: Selected State
- **When** A nav item is selected
- **Then** Item displays highlighted (green background or scaled)

#### Scenario: Nav Item Tap
- **When** User taps nav item
- **Then** Trigger callback and update selected state

---

### Requirement: ProgressDashboardPage

系统 MUST provide gamified learning progress dashboard page.

#### Scenario: Page Layout
- **When** User opens progress dashboard
- **Then** Display in order: stats bar, unit banner, progress ring button, function icons, bottom nav

#### Scenario: Continue Learning Tap
- **When** User taps center progress ring button
- **Then** Navigate to question page

#### Scenario: Display Stats Data
- **When** Page loads
- **Then** Fetch and display data from LearningProgressProvider

---

### Requirement: CelebrationPage

系统 MUST display celebration animation after completing unit/section.

#### Scenario: Show Celebration Page
- **When** User completes a unit
- **Then** Fullscreen celebration page with achievement badge, stats, continue button

#### Scenario: Confetti Animation
- **When** Celebration page displays
- **Then** Play confetti falling animation

#### Scenario: Share Function
- **When** User taps share button
- **Then** Invoke system share sheet

---

### Requirement: AchievementGalleryPage

系统 MUST display user's achievement badge collection.

#### Scenario: Show Locked and Unlocked Achievements
- **When** User opens achievement page
- **Then** Unlocked show in color, locked show gray with dashed border

#### Scenario: Achievement Progress
- **When** Some achievements not unlocked
- **Then** Display progress in "X/Y" format

---

## MODIFIED Requirements

### Requirement: AppTheme Extension

Existing theme MUST support Neo-Brutal style extension.

#### Scenario: Get Neo Colors
- **When** App requests `NeoBrutalTheme.primary`
- **Then** Return `#58CC02`

#### Scenario: Dark Mode Support
- **When** System switches to dark mode
- **Then** Neo components auto-use dark color scheme

#### Scenario: Compatible with Existing Theme
- **When** Existing code uses `AppTheme.duoGreen`
- **Then** Continues to work, no breaking change
