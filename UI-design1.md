# Flutter Notes App - UI Design Document

## Design Philosophy

**Keep it Simple, Keep it Fast**
- Minimal cognitive load for users
- Clear visual hierarchy
- Instant feedback for all actions
- Real-time sync status always visible
- Two note types: Simple (quick text) and Rich (full editor)

---

## Color Scheme & Typography

```
Primary Colors:
- Background: #FFFFFF (Light) / #1A1A1A (Dark)
- Primary: #2563EB (Blue)
- Success: #10B981 (Green) 
- Warning: #F59E0B (Orange)
- Error: #EF4444 (Red)
- Text: #1F2937 (Light) / #F9FAFB (Dark)
- Subtle: #6B7280 (Gray)

Icons:
- Simple Notes: 📝
- Rich Notes: ✏️
- Categories: 📁
- Sync Status: 🔄 📶 ✅ ❌
- Actions: + ← 🔍 ⚙️
```

---

## Core Screens

### 1. Home Screen (Main Dashboard)

**Purpose**: Quick access to categories and recent notes

```
┌─────────────────────────────────┐
│  ☰ Notes                👤      │ ← Clean header, hamburger menu
├─────────────────────────────────┤
│                                 │
│  🔄 Syncing • 2s ago     📶     │ ← Sync status (prominent but not intrusive)
│                                 │
│ ┌───────────────────────────────┐│
│ │ 🔍 Search notes...            ││ ← Search always accessible
│ └───────────────────────────────┘│
│                                 │
│  Categories                     │ ← Section header (simple text)
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Personal          (12) → │ │ ← Category cards with count
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ 📁 Work              (8) →  │ │
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ 📁 Quick Notes       (15) → │ │
│ └─────────────────────────────┘ │
│                                 │
│  Recent Notes                   │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Shopping List            │ │ ← Note type indicator
│ │ Milk, bread, eggs...        │ │ ← Preview text
│ │ Personal • 30m ago          │ │ ← Context info
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Meeting Notes            │ │
│ │ Q4 planning discussion...   │ │
│ │ Work • 2h ago               │ │
│ └─────────────────────────────┘ │
│                                 │
│               [+]               │ ← Floating action button
│                                 │
└─────────────────────────────────┘
```

**Key Features:**
- Sync status is always visible but not distracting
- Categories show note counts for context
- Recent notes show type, preview, and timestamp
- Single FAB for creating new notes
- Search is prominent and always accessible

---

### 2. Category View (Notes List)

**Purpose**: Browse all notes within a category with sorting options

```
┌─────────────────────────────────┐
│  ← Personal Notes (12)       ⋮  │ ← Back + category name + menu
├─────────────────────────────────┤
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 🔤 Recent ↓    [Grid] [List]│ │ ← Sort options + view toggle
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Shopping List      [⋮]   │ │ ← Note with action menu
│ │ • Milk  • Bread  • Eggs     │ │ ← Content preview
│ │ 30 minutes ago              │ │ ← Timestamp
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Daily Journal      [⋮]   │ │
│ │ Today was productive and... │ │
│ │ 2 hours ago                 │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Call Mom           [⋮]   │ │
│ │ Remember to discuss...      │ │
│ │ Yesterday                   │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Project Ideas      [⋮]   │ │
│ │ # New Features             │ │
│ │ 2 days ago                  │ │
│ └─────────────────────────────┘ │
│                                 │
│               [+]               │
│                                 │
└─────────────────────────────────┘
```

**Sort Options:**
- Recent (default)
- Oldest
- A-Z
- Z-A

**View Modes:**
- List (default) - Shows content preview
- Grid - Compact card view

---

### 3. Create Note Dialog

**Purpose**: Quick note type selection

```
┌─────────────────────────────────┐
│  Create New Note             ✕  │ ← Bottom sheet modal
├─────────────────────────────────┤
│                                 │
│  What type of note?             │ ← Simple choice
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Simple Note              │ │ ← Quick text note
│ │ Perfect for lists, reminders│ │ ← Description
│ │ and quick thoughts          │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Rich Note                │ │ ← Full editor note  
│ │ Advanced formatting, blocks │ │ ← Description
│ │ and rich content            │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌───────────────────────────────┐│
│ │ 📁 Category: Personal    ⌄   ││ ← Category selector
│ └───────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

### 4. Simple Note Bottom Sheet

**Purpose**: Quick text editing without leaving current context

```
┌─────────────────────────────────┐
│  📝 Simple Note              ✕  │ ← Bottom sheet (75% height)
├─────────────────────────────────┤
│                                 │
│ ┌───────────────────────────────┐│
│ │ Note title (optional)...     ││ ← Optional title
│ └───────────────────────────────┘│
│                                 │
│ ┌───────────────────────────────┐│
│ │ • Milk - 2% organic          ││ ← Main content area
│ │ • Bread - whole wheat        ││ ← Auto-formats as you type
│ │ • Eggs - dozen               ││
│ │ • Apples - honeycrisp        ││
│ │ • Chicken breast             ││
│ │                              ││
│ │ Type your note here...       ││ ← Placeholder text
│ │                              ││
│ │                              ││
│ │                              ││
│ │                              ││
│ └───────────────────────────────┘│
│                                 │
│ [B] [I] [•] [1.] [√]            │ ← Minimal formatting bar
│                                 │
│ 📁 Personal          ✅ Saved   │ ← Category + auto-save status
│                                 │
│               [Done]             │ ← Save and close
│                                 │
└─────────────────────────────────┘
```

**Auto-formatting Features:**
- Type `- ` or `* ` → bullet points
- Type `1. ` → numbered lists  
- Type `[ ]` → checkboxes
- **Bold** and *italic* with buttons
- Auto-saves every 2 seconds
- Swipe down or tap outside to save & close

---

### 5. Rich Text Editor (AppFlowy Style)

**Purpose**: Full-featured editing with blocks and rich formatting

```
┌─────────────────────────────────┐
│  ← Done              ✏️ Rich    │
├─────────────────────────────────┤
│                                 │
│ ┌───────────────────────────────┐│
│ │ # Meeting Notes              ││ ← Title with formatting
│ │                              ││
│ │ ## Action Items              ││ ← Headings
│ │ - [ ] Review architecture    ││ ← Interactive checkboxes
│ │ - [x] Update documentation   ││
│ │ - [ ] Schedule follow-up     ││
│ │                              ││
│ │ ### Key Decisions            ││
│ │ > Move forward with the new  ││ ← Quote blocks
│ │ > microservice approach      ││
│ │                              ││
│ │ **Important points:**        ││ ← Bold formatting
│ │ • Budget approved ✅         ││ ← Mixed content
│ │ • Timeline: *6 weeks*        ││ ← Italic formatting
│ │ • Team size: 4 developers    ││
│ │                              ││
│ │ ```typescript               ││ ← Code blocks
│ │ interface User {             ││
│ │   id: string;               ││
│ │   name: string;             ││
│ │ }                           ││
│ │ ```                         ││
│ │                              ││
│ │ |                           ││ ← Cursor
│ │                              ││
│ └───────────────────────────────┘│
│                                 │
│ ┌───────────────────────────────┐│
│ │ + Add block...               ││ ← Block selector
│ │ [H1] [H2] [•] [1.] [>] [{}] ││ ← Quick block types
│ └───────────────────────────────┘│
│                                 │
│  📁 Work • ✅ Saved • 📶 Synced │
│                                 │
└─────────────────────────────────┘
```

**Rich Formatting Blocks:**
- **H1**, **H2**, **H3** - Headings
- **•** - Bullet lists
- **1.** - Numbered lists  
- **[ ]** - Todo lists
- **>** - Quote blocks
- **{}** - Code blocks
- **---** - Dividers
- **📷** - Images
- **🔗** - Links

**Block-based Editing:**
- Type `/` to open block selector
- Drag blocks to reorder
- Each block is independently formatted

---

### 6. Search Results

**Purpose**: Find notes quickly with highlighted matches

```
┌─────────────────────────────────┐
│  ← [🔍 meeting notes...]     ✕  │ ← Search with clear button
├─────────────────────────────────┤
│                                 │
│  Found 4 results in 0.02s      │ ← Quick results count
│                                 │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Team **Meeting**         │ │ ← Highlighted matches
│ │ Weekly **meeting** covered  │ │
│ │ budget and timeline...      │ │
│ │ Work • Yesterday            │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 **Meeting** Prep         │ │
│ │ Agenda items for tomorrow's │ │
│ │ **meeting** with client...  │ │
│ │ Personal • 2 days ago       │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ ✏️ Q4 Planning              │ │
│ │ Next **meeting** scheduled  │ │
│ │ for Friday at 2 PM...       │ │
│ │ Work • Last week            │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Quick **Notes**          │ │
│ │ Remember to book conference │ │
│ │ room for **meeting**...     │ │
│ │ Personal • 2 weeks ago      │ │
│ └─────────────────────────────┘ │
│                                 │
│  Recent searches:               │ ← Search history
│  "project ideas" • "shopping"  │
│                                 │
└─────────────────────────────────┘
```

**Search Features:**
- Full-text search across all notes
- Real-time results as you type
- Highlighted search terms
- Search within specific categories
- Recent search history
- Search suggestions

---

### 7. Settings & Profile

**Purpose**: Manage sync, preferences, and account settings

```
┌─────────────────────────────────┐
│  ← Settings                     │
├─────────────────────────────────┤
│                                 │
│ ┌───────────────────────────────┐│
│ │ 👤 John Doe                  ││ ← User profile section
│ │ john.doe@email.com           ││
│ │                              ││
│ │ [Edit Profile]               ││
│ └───────────────────────────────┘│
│                                 │
│ ┌───────────────────────────────┐│
│ │ 🔄 Sync Status               ││
│ │                              ││
│ │ ✅ All synced • 📶 Online    ││ ← Combined status
│ │ Last sync: 2 minutes ago     ││ ← Timestamp
│ │                              ││
│ │ [🔄 Sync Now]                ││ ← Manual sync button
│ └───────────────────────────────┘│
│                                 │
│ ┌───────────────────────────────┐│
│ │ ⚙️ Preferences               ││
│ │                              ││
│ │ 🌙 Dark Mode        [ON]     ││ ← Theme toggle
│ │ 📝 Auto-save        [ON]     ││ ← Auto-save setting  
│ │ 🔔 Notifications    [OFF]    ││ ← Notification toggle
│ │ 📱 Rich Editor      [ON]     ││ ← Editor preference
│ └───────────────────────────────┘│
│                                 │
│ ┌───────────────────────────────┐│
│ │ 📊 Usage Statistics          ││
│ │                              ││
│ │ 📝 Total Notes: 47           ││
│ │ 📁 Categories: 5             ││
│ │ 💾 Storage Used: 3.2 MB      ││
│ │ ⏱️ Time Saved: 12 hours      ││
│ └───────────────────────────────┘│
│                                 │
│  [🔒 Export Data]               │ ← Data management
│  [🗑️ Clear Cache]               │
│  [🚪 Sign Out]                  │
│                                 │
└─────────────────────────────────┘
```

---

### 8. Category Management

**Purpose**: Create, edit, and organize categories

```
┌─────────────────────────────────┐
│  ← Manage Categories         +  │ ← Back button + add category
├─────────────────────────────────┤
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Personal          (12)   │ │ ← Drag handle for reordering
│ │ ┊┊                      [⋮] │ │ ← Options menu
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Work                (8)   │ │
│ │ ┊┊                      [⋮] │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Quick Notes        (15)   │ │
│ │ ┊┊                      [⋮] │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Projects           (3)    │ │
│ │ ┊┊                      [⋮] │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📁 Archive            (0)    │ │
│ │ ┊┊                      [⋮] │ │
│ └─────────────────────────────┘ │
│                                 │
│  💡 Drag to reorder categories  │ ← Helper text
│                                 │
│ ┌───────────────────────────────┐│
│ │ [📁 New Category...]         ││ ← Add new category
│ └───────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

**Category Options Menu (⋮):**
- ✏️ Rename
- 🎨 Change Color
- 📁 Move Notes
- 🗑️ Delete

---

### 9. Note Options & Actions

**Purpose**: Quick actions for individual notes

```
┌─────────────────────────────────┐
│  Note Actions                ✕  │ ← Bottom sheet modal
├─────────────────────────────────┤
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 📝 Shopping List            │ │ ← Note preview
│ │ • Milk  • Bread  • Eggs     │ │
│ │ Personal • 30 minutes ago   │ │
│ └─────────────────────────────┘ │
│                                 │
│  Actions:                       │
│                                 │
│  ✏️ Edit Note                   │ ← Edit action
│  📁 Move to Category            │ ← Move to different category
│  🔗 Share                       │ ← Share note
│  📋 Copy                        │ ← Copy to clipboard
│  📌 Pin to Top                  │ ← Pin important notes
│  🗑️ Delete                      │ ← Delete note
│                                 │
│ ┌───────────────────────────────┐│
│ │ Move to:                     ││ ← Category selector
│ │ ○ Personal                   ││
│ │ ● Work                       ││ ← Current category
│ │ ○ Quick Notes                ││
│ │ ○ Projects                   ││
│ └───────────────────────────────┘│
│                                 │
│               [Cancel]           │
│                                 │
└─────────────────────────────────┘
```

---

## Sync Status Indicators

### Real-time Sync States

```
States and their indicators:

🔄 Syncing...           ← Active sync in progress
✅ Synced • 2m ago      ← Successfully synced with timestamp  
📶 Online               ← Connected to internet
📴 Offline              ← No internet connection
❌ Sync Error           ← Sync failed, needs attention
⏸️ Paused               ← Sync temporarily disabled
🔄 Pending (3)          ← Number of changes waiting to sync
```

### Sync Status Details Modal

```
┌─────────────────────────────────┐
│  Sync Status                 ✕  │
├─────────────────────────────────┤
│                                 │
│            ✅                   │ ← Large status icon
│                                 │
│       All notes synced          │ ← Simple message
│                                 │
│     Last sync: 2 minutes ago    │ ← When it happened
│                                 │
│                                 │
│  📶 Online                      │ ← Connection status
│                                 │
│                                 │
│                                 │
│          [🔄 Sync Now]          │ ← Simple manual sync
│                                 │
│                                 │
└─────────────────────────────────┘
```

---

## Navigation & Flow

### Navigation Structure

```
Home Screen (Dashboard)
├── Category View → Note List
│   ├── Simple Note Editor
│   ├── Rich Text Editor  
│   └── Note Actions Menu
├── Search Results
│   └── Individual Notes
├── Settings
│   ├── Profile Management
│   ├── Sync Settings
│   ├── Preferences
│   └── Data Management
└── Category Management
    ├── Create Category
    ├── Edit Category
    └── Reorder Categories
```

### User Flow Examples

**Creating a Simple Note:**
1. Tap (+) FAB on any screen
2. Choose "📝 Simple Note" from bottom sheet
3. Start typing immediately (auto-saves)
4. Tap Done or swipe down to close

**Creating a Rich Note:**
1. Tap (+) FAB on any screen
2. Choose "✏️ Rich Note" from bottom sheet
3. Opens full-screen rich editor
4. Use block-based editing
5. Tap Done to return

**Finding a Note:**
1. Tap search bar on home screen
2. Type search terms
3. See real-time results
4. Tap note to open

**Managing Categories:**
1. Tap hamburger menu (☰)
2. Select "Manage Categories"
3. Drag to reorder or tap (⋮) for options
4. Tap (+) to add new category

---

## Responsive Design

### Phone Layout (Primary)
- Single column layout
- Bottom tab navigation
- FAB for primary actions
- Swipe gestures for quick actions

### Tablet Layout (Adaptive)
- Two-pane layout (categories + notes)
- Side navigation drawer
- Larger editor areas
- Multi-select for bulk actions

### Dark Mode Support
- Automatic system theme detection
- Manual toggle in settings
- High contrast for accessibility
- Consistent color scheme across all screens

---

## Accessibility Features

- **Voice Over/TalkBack**: All elements properly labeled
- **Keyboard Navigation**: Tab order and shortcuts
- **High Contrast**: Optional high contrast mode
- **Large Text**: Dynamic text sizing support
- **Color Blind**: No color-only information conveyance
- **Motor Impairments**: Large touch targets (44pt minimum)

---

## Performance Considerations

- **Lazy Loading**: Load notes on-demand
- **Virtual Scrolling**: For large note lists
- **Image Optimization**: Compress and cache images
- **Offline First**: Full functionality without internet
- **Incremental Sync**: Only sync changed data
- **Background Sync**: Sync when app is backgrounded

---

## Summary

This UI design prioritizes **simplicity and speed** while providing powerful features:

1. **Two Note Types**: Simple text and rich editor to match user needs
2. **Always-Visible Sync**: Users know their data is safe
3. **Category Organization**: Keep notes organized without complexity
4. **Powerful Search**: Find anything instantly
5. **Offline Capable**: Works everywhere, syncs when possible
6. **Clean Interface**: Minimal UI that gets out of the way

The design follows Flutter's Material Design principles while maintaining a unique, focused experience for note-taking with real-time synchronization.