# BMI Calculator - Flutter App

A stunning and user-friendly BMI (Body Mass Index) calculator built with Flutter and Dart, featuring beautiful animations, gradient backgrounds, and support for both metric and imperial units.

## 🎯 Features

- **Beautiful UI**: Gradient backgrounds with smooth animations
- **Dual Unit Support**: Switch between Metric (cm/kg) and Imperial (in/lbs)
- **Real-time Validation**: Input validation with user-friendly error messages
- **Visual BMI Scale**: Color-coded BMI categories with visual scale
- **Responsive Design**: Works on all screen sizes
- **Accessibility**: Large fonts, clear contrast, and tooltips
- **Offline Functionality**: Works entirely offline

## 📱 BMI Categories

- **Underweight**: < 18.5 (Amber)
- **Normal weight**: 18.5 - 24.9 (Green)
- **Overweight**: 25 - 29.9 (Orange)
- **Obese**: ≥ 30 (Red)

## 🚀 Quick Start

```bash
# Clone this repository
git clone https://github.com/ananyaakamat/bmi_calculator.git
cd bmi_calculator

# Install dependencies
flutter pub get

# Run in Chrome (fastest for testing)
flutter run -d chrome

# Build Android APK
flutter build apk --release
```

## 🛠️ Setup Instructions

### Prerequisites & Software Installation

#### 1. **Install Flutter SDK**

**Windows:**
```bash
# Option 1: Using winget (recommended)
winget install --id=9NBLGGH4Z1JC

# Option 2: Manual installation
# 1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows
# 2. Extract to C:\flutter (recommended location)
# 3. Add C:\flutter\bin to PATH environment variable
```

**macOS:**
```bash
# Using Homebrew (recommended)
brew install flutter

# Or download from: https://docs.flutter.dev/get-started/install/macos
```

**Linux:**
```bash
# Download from: https://docs.flutter.dev/get-started/install/linux
# Extract and add to PATH
```

#### 2. **Environment Variables Setup**

**Windows (PowerShell):**
```powershell
# Temporary (current session only)
$env:PATH += ";C:\flutter\bin"

# Permanent (add to system PATH)
# 1. Open System Properties > Advanced > Environment Variables
# 2. Add C:\flutter\bin to PATH variable
# 3. Or use PowerShell as Administrator:
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\flutter\bin", [EnvironmentVariableTarget]::Machine)
```

**macOS/Linux (Bash/Zsh):**
```bash
# Add to ~/.bashrc, ~/.zshrc, or ~/.profile
export PATH="$PATH:/path/to/flutter/bin"

# Reload shell
source ~/.bashrc  # or ~/.zshrc
```

#### 3. **Install Dart SDK** (Included with Flutter)
Dart SDK is automatically included with Flutter installation. No separate installation needed.

#### 4. **Android Studio & Android SDK** (For APK development)

**Windows:**
```bash
# Using winget
winget install Google.AndroidStudio

# Manual download: https://developer.android.com/studio
```

**macOS:**
```bash
# Using Homebrew
brew install --cask android-studio

# Manual download: https://developer.android.com/studio
```

**Post-installation setup:**
1. Open Android Studio
2. Follow setup wizard
3. Install Android SDK (API 30+ recommended)
4. Create virtual device (for testing)
5. Accept Android licenses:
```bash
flutter doctor --android-licenses
```

#### 5. **VS Code Setup** (Recommended IDE)

**Installation:**
```bash
# Windows
winget install Microsoft.VisualStudioCode

# macOS
brew install --cask visual-studio-code

# Or download from: https://code.visualstudio.com/
```

**Required Extensions:**
1. **Flutter** (Dart-Code.flutter)
2. **Dart** (Dart-Code.dart-code)

**Installation via VS Code:**
- Open Extensions (Ctrl+Shift+X)
- Search and install "Flutter"
- Dart extension will be installed automatically

#### 6. **Chrome Browser** (For web development)
```bash
# Windows
winget install Google.Chrome

# macOS
brew install --cask google-chrome

# Or download from: https://www.google.com/chrome/
```

#### 7. **Git** (For version control)
```bash
# Windows
winget install Git.Git

# macOS
brew install git

# Or download from: https://git-scm.com/
```

### Verification

**Check all installations:**
```bash
flutter doctor -v
```

**Expected output should show:**
- ✅ Flutter SDK
- ✅ Android toolchain (if Android Studio installed)
- ✅ Chrome browser
- ✅ VS Code with extensions
- ✅ Connected devices

**Troubleshoot issues:**
```bash
# Fix common issues
flutter doctor --android-licenses  # Accept Android licenses
flutter config --enable-web        # Enable web support
```

### Quick Start

**Clone this repository:**
```bash
git clone https://github.com/ananyaakamat/bmi_calculator.git
cd bmi_calculator
```

**Get dependencies:**
```bash
flutter pub get
```

**Run in Chrome** (Recommended for quick testing):
```bash
flutter run -d chrome
```
This will automatically open Chrome browser with the app running.

### Running on Different Platforms

```bash
# Run in Chrome browser (fastest for development)
flutter run -d chrome

# Run on Android emulator/device
flutter run

# Run on iOS simulator (macOS only)
flutter run -d ios

# Run on web (any browser)
flutter run -d web-server --web-port 8080
# Then open http://localhost:8080 in your browser
```

### Building for Production

#### Android APK
```bash
# Build release APK (for mobile installation)
flutter build apk --release

# APK will be created at: build/app/outputs/flutter-apk/app-release.apk
```

#### Web Deployment
```bash
# Build for web hosting
flutter build web --release

# Files will be in: build/web/
```

#### iOS App (macOS only)
```bash
flutter build ios --release
```

## 🎨 Design Features

- **Color Scheme**: Modern blue gradient (#3559FF to #7EA6FF)
- **Typography**: Clean Roboto font with appropriate weights
- **Animations**: Smooth slide and fade transitions
- **Cards**: Material Design with subtle shadows
- **Interactive Elements**: Choice chips, filled/outlined buttons
- **Visual Feedback**: Color-coded BMI categories

## 🏗️ Project Structure

```
bmi_calculator/
├── lib/
│   └── main.dart              # Main application code
├── pubspec.yaml               # Dependencies and metadata
├── analysis_options.yaml     # Linting rules
└── README.md                 # This file
```

## 🔧 Technical Details

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Architecture**: StatefulWidget with animations
- **State Management**: Built-in setState (no external packages)
- **UI Framework**: Material Design 3
- **Animations**: Custom AnimationController with curves

## 📐 BMI Calculation Formulas

- **Metric**: BMI = weight(kg) / [height(m)]²
- **Imperial**: BMI = (weight(lbs) × 703) / [height(in)]²

## 🎯 Usage

1. **Select Unit System**: Choose between Metric or Imperial
2. **Enter Height**: Input your height in cm or inches
3. **Enter Weight**: Input your weight in kg or lbs
4. **Calculate**: Tap the calculate button to get your BMI
5. **View Results**: See your BMI score, category, and position on the scale
6. **Reset**: Clear inputs and start over

## 🚀 Troubleshooting

### Installation Issues

1. **Flutter command not found:**
   ```bash
   # Windows: Check PATH variable
   echo $env:PATH | Select-String flutter
   
   # If not found, add manually:
   $env:PATH += ";C:\flutter\bin"
   
   # macOS/Linux: Check PATH
   echo $PATH | grep flutter
   
   # If not found, add to shell profile:
   export PATH="$PATH:/path/to/flutter/bin"
   ```

2. **Flutter Doctor Issues:**
   ```bash
   # Android licenses not accepted
   flutter doctor --android-licenses
   
   # Android SDK not found
   # Set ANDROID_HOME environment variable:
   # Windows: C:\Users\<username>\AppData\Local\Android\Sdk
   # macOS: ~/Library/Android/sdk
   # Linux: ~/Android/Sdk
   
   # Chrome not detected
   flutter config --enable-web
   ```

3. **VS Code Flutter Extension Issues:**
   ```bash
   # Reload VS Code window
   Ctrl+Shift+P -> "Developer: Reload Window"
   
   # Check Dart SDK path in VS Code settings
   # Should be: <flutter-path>/bin/cache/dart-sdk
   ```

4. **Android Studio Setup:**
   - Ensure Android SDK Tools are installed
   - Create at least one AVD (Android Virtual Device)
   - Enable Developer Options on physical device

### Runtime Issues

1. **APK build fails:**
   ```bash
   # Clean project
   flutter clean
   flutter pub get
   
   # Ensure Android licenses accepted
   flutter doctor --android-licenses
   
   # Check Android SDK version (API 30+ recommended)
   ```

2. **Chrome not launching:**
   ```bash
   # Specify port
   flutter run -d chrome --web-port 8080
   
   # Enable web explicitly
   flutter config --enable-web
   
   # Check Chrome installation
   flutter devices
   ```

3. **Slow first web build:**
   - First compilation: 20-60 seconds (normal)
   - Subsequent hot reloads: 1-3 seconds
   - Use `flutter run -d chrome` for fastest development

4. **Permission denied errors:**
   ```bash
   # Windows: Run PowerShell as Administrator
   # macOS/Linux: Use sudo for system-wide installations
   sudo flutter doctor --android-licenses
   ```

### Development Tips

- **Hot Reload**: Press `r` in terminal while app is running
- **Hot Restart**: Press `R` in terminal for full restart
- **Debug in Chrome**: Open DevTools (F12) for web debugging
- **Test APK**: Install with `adb install build/app/outputs/flutter-apk/app-release.apk`
- **Performance**: Use `flutter run --profile` for performance testing

### System Requirements

**Minimum Requirements:**
- **Disk Space**: 2.8 GB (Flutter SDK + tools)
- **RAM**: 4 GB minimum, 8 GB recommended
- **OS**: Windows 10+, macOS 10.14+, Linux (64-bit)

**Recommended Setup:**
- **SSD Storage**: For faster builds
- **16 GB RAM**: For smooth Android emulator
- **Dedicated Graphics**: For emulator acceleration

## 🧪 Testing

The app includes comprehensive input validation:

- Prevents negative values
- Handles empty inputs
- Validates numeric input only
- Provides user-friendly error messages

## 📱 Compatibility

- **Android**: 8.0+ (API level 26+)
- **iOS**: 13.0+
- **Web**: Modern browsers
- **Desktop**: Windows, macOS, Linux (with Flutter desktop support)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design system
- BMI calculation standards from WHO guidelines