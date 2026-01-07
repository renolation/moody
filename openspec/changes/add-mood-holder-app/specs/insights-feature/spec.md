# Insights Feature Specification

## ADDED Requirements

### Requirement: Insights Header with Month Navigation

The Insights screen SHALL display a header with the title "Your Insights" and current month/year.

#### Scenario: Header display
- **WHEN** user navigates to Insights screen
- **THEN** "Your Insights" title is displayed
- **AND** current month and year are shown below
- **AND** a calendar icon button is visible for month selection

#### Scenario: Month navigation
- **WHEN** user taps the calendar icon
- **THEN** a month picker dialog appears
- **AND** user can navigate to view historical data

### Requirement: Monthly Mood Heatmap Calendar

The Insights screen SHALL display a calendar heatmap showing mood intensity for each day.

#### Scenario: Heatmap display
- **WHEN** user has mood data for the current month
- **THEN** a 7-column calendar grid is displayed
- **AND** each day cell is colored based on average mood score
- **AND** higher mood scores show more saturated teal colors
- **AND** days without data show muted/empty styling

#### Scenario: Average mood badge
- **WHEN** viewing the heatmap
- **THEN** an "Avg {score}" badge displays the monthly average
- **AND** the badge pulses with a subtle animation

#### Scenario: Day selection
- **WHEN** user taps a day cell with data
- **THEN** a tooltip or modal shows that day's mood details
- **AND** all entries for that day are listed

### Requirement: Mood and Movement Correlation Chart

The Insights screen SHALL display a dual-axis chart showing mood scores and exercise minutes.

#### Scenario: Chart display
- **WHEN** user has mood and exercise data for the week
- **THEN** a combined chart is displayed
- **AND** mood score is shown as a line graph (teal color)
- **AND** exercise minutes are shown as bar chart (white/gray)
- **AND** X-axis shows days of the week (Mon-Sun)

#### Scenario: Chart legend
- **WHEN** viewing the correlation chart
- **THEN** a legend indicates "Mood Score" with teal dot
- **AND** "Exercise (min)" with gray square

#### Scenario: Interactive data points
- **WHEN** user taps a data point on the chart
- **THEN** exact values are displayed in a tooltip

### Requirement: Key Insight Card

The Insights screen SHALL display an AI-generated insight about mood patterns.

#### Scenario: Insight display
- **WHEN** sufficient data exists for pattern analysis
- **THEN** an insight card is displayed with lightbulb icon
- **AND** "KEY INSIGHT" label with teal styling
- **AND** a personalized message like "Data shows your mood improves by 15% on days with 30+ mins of exercise"

#### Scenario: Insufficient data
- **WHEN** user has less than 7 days of data
- **THEN** insight card shows encouragement to keep logging
- **AND** indicates how many more days needed for insights

### Requirement: VIP Analytics Gating

Premium analytics features SHALL be gated behind VIP subscription status.

#### Scenario: Free user access
- **WHEN** non-VIP user views Insights
- **THEN** mood heatmap is fully visible
- **AND** correlation chart shows a preview with blur overlay
- **AND** "Unlock with VIP" button is displayed

#### Scenario: VIP user access
- **WHEN** VIP user views Insights
- **THEN** all charts and insights are fully accessible
- **AND** no upgrade prompts are shown
