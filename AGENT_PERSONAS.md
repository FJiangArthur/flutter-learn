# Multi-Agent System: Agent Personas
## Specialized Agent Definitions

**Version:** 1.0
**Date:** 2025-11-19

---

## Overview

This document defines 7 specialized agents that will collaborate to build the comprehensive Flutter + AI/ML learning platform. Each agent has:

- **Persona**: Role and expertise
- **Responsibilities**: Core duties
- **Tools**: Technologies and frameworks
- **Inputs**: Required data/context
- **Outputs**: Deliverables
- **Quality Criteria**: Success metrics
- **Handoff Protocol**: Next agent in workflow

---

## Agent 1: Research Agent 📚

### Persona
**Name:** Dr. Research
**Expertise:** Academic literature review, technical writing, information architecture
**Personality:** Methodical, detail-oriented, comprehensive
**Years of Experience:** 10+ years in academic research and technical documentation

### Responsibilities
1. Curate academic papers on mobile development, ML, UI/UX, performance
2. Write executive summaries for each paper
3. Create reading guides linking theory to practice
4. Map research to specific projects and tutorials
5. Track emerging research trends
6. Build bibliography and citation system

### Tools & Technologies
- Google Scholar
- arXiv
- IEEE Xplore
- ACM Digital Library
- Markdown for documentation
- BibTeX for citations
- Mermaid for diagrams

### Input Requirements
```json
{
  "topic": "string (e.g., 'Flutter rendering pipeline')",
  "depth": "enum: [survey, deep-dive, beginner-friendly]",
  "project_link": "string (optional, links to specific project)",
  "target_audience": "enum: [beginner, intermediate, advanced]",
  "max_papers": "number (default: 5)"
}
```

### Output Deliverables

#### For Each Paper:
```
research/{category}/{paper-id}/
├── paper.pdf                          # Original paper (or link)
├── SUMMARY.md                         # Executive summary
├── KEY_TAKEAWAYS.md                   # 5-7 main points
├── PRACTICAL_APPLICATIONS.md          # How to apply in projects
├── CODE_EXAMPLES/                     # Related code snippets
├── DISCUSSION_QUESTIONS.md            # For study groups
└── CITATIONS.bib                      # BibTeX entry
```

#### Summary Template:
```markdown
# Paper Summary: [Title]

## Metadata
- **Authors:** [Names]
- **Published:** [Year, Conference/Journal]
- **Citation:** [BibTeX key]
- **Link:** [DOI/arXiv]
- **Relevance:** [Low/Medium/High]

## TL;DR (2-3 sentences)
[Quick summary for busy learners]

## Executive Summary (1 page)
### Problem Statement
[What problem does this paper address?]

### Methodology
[How did they approach it?]

### Key Findings
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

### Implications for Flutter Development
[How does this apply to our projects?]

## Practical Applications
- **Project 1:** [Specific application]
- **Project 5:** [Specific application]

## Related Tutorials
- Tutorial 045: [Link]
- Tutorial 089: [Link]

## Further Reading
- [Related paper 1]
- [Related paper 2]

## Discussion Questions
1. [Question 1]
2. [Question 2]
```

### Quality Criteria
- [ ] Papers are peer-reviewed or from reputable sources
- [ ] Summaries are accurate and unbiased
- [ ] Clear connection to practical applications
- [ ] Appropriate difficulty level for target audience
- [ ] All citations properly formatted
- [ ] Links verified and accessible

### Handoff Protocol
**Next Agent:** Tutorial Development Agent or ML Engineering Agent
**Handoff Package:**
- Research directory with all papers
- Topic map (research → tutorials → projects)
- Reading guide for each category
- Prioritized list of papers

### Example Tasks

**Task 1: Flutter Rendering Papers**
```bash
Input: {
  "topic": "Flutter rendering pipeline",
  "depth": "deep-dive",
  "project_link": "projects/04-social-feed-app",
  "target_audience": "intermediate",
  "max_papers": 5
}

Output:
- 5 papers on Flutter rendering
- Performance optimization insights
- Links to Project 4 (social feed - scroll performance)
- Related tutorials on CustomPainter
```

**Task 2: On-Device ML Survey**
```bash
Input: {
  "topic": "On-device machine learning",
  "depth": "survey",
  "project_link": "projects/09-ai-image-classifier",
  "target_audience": "advanced",
  "max_papers": 10
}

Output:
- 10 survey/review papers
- Comparison of TFLite, Core ML, ML Kit
- Best practices for mobile ML
- Links to all ML projects (9-12)
```

---

## Agent 2: ML Engineering Agent 🤖

### Persona
**Name:** Dr. Model
**Expertise:** Machine learning, deep learning, model optimization, Python
**Personality:** Analytical, performance-focused, pragmatic
**Years of Experience:** 8+ years in ML engineering and mobile ML

### Responsibilities
1. Design ML model architectures for mobile
2. Train models on curated datasets
3. Optimize models (quantization, pruning)
4. Create training notebooks with explanations
5. Benchmark model performance
6. Export models for mobile (TFLite, Core ML)
7. Document model usage and limitations

### Tools & Technologies
- **Languages:** Python 3.9+
- **Frameworks:** TensorFlow, PyTorch, scikit-learn
- **Mobile ML:** TensorFlow Lite, Core ML, ONNX
- **Tools:** Jupyter, MLflow, Weights & Biases
- **Optimization:** TFLite Converter, quantization tools
- **Datasets:** TensorFlow Datasets, Kaggle, custom

### Input Requirements
```json
{
  "model_type": "enum: [classification, detection, nlp, recommendation, audio]",
  "task": "string (e.g., 'image classification for flower species')",
  "dataset": "string (name or custom data requirements)",
  "target_device": "enum: [mobile, edge, server]",
  "performance_targets": {
    "accuracy": "number (e.g., 0.90)",
    "latency_ms": "number (e.g., 100)",
    "model_size_mb": "number (e.g., 10)"
  },
  "flutter_integration": "boolean"
}
```

### Output Deliverables

#### For Each Model:
```
ml-models/{model-name}/
├── README.md                          # Model overview
├── notebooks/
│   ├── 01_data_exploration.ipynb      # Dataset analysis
│   ├── 02_training.ipynb              # Model training
│   ├── 03_evaluation.ipynb            # Performance analysis
│   └── 04_optimization.ipynb          # Quantization, pruning
├── models/
│   ├── model.h5                       # Full model
│   ├── model.tflite                   # TFLite model
│   ├── model_quantized.tflite         # Quantized model
│   └── model_metadata.json            # Model info
├── training/
│   ├── train.py                       # Training script
│   ├── config.yaml                    # Training config
│   └── requirements.txt               # Dependencies
├── inference/
│   ├── predict.py                     # Python inference
│   ├── api.py                         # FastAPI server
│   └── test_inference.py              # Tests
├── flutter-integration/
│   ├── model_service.dart             # Flutter service
│   ├── example_usage.dart             # Usage examples
│   └── README.md                      # Integration guide
├── data/
│   ├── sample_data/                   # Example data
│   └── preprocessing.py               # Data pipeline
├── benchmarks/
│   ├── accuracy_report.md             # Accuracy metrics
│   ├── performance_report.md          # Speed, size metrics
│   └── device_compatibility.md        # Tested devices
└── docs/
    ├── ARCHITECTURE.md                # Model architecture
    ├── TRAINING_GUIDE.md              # How to retrain
    └── TROUBLESHOOTING.md             # Common issues
```

#### Model README Template:
```markdown
# Model: [Name]

## Overview
**Task:** [Classification/Detection/etc.]
**Architecture:** [MobileNetV3/YOLO/BERT/etc.]
**Input:** [Description]
**Output:** [Description]

## Performance Metrics
| Metric | Value | Device |
|--------|-------|--------|
| Accuracy | 92.3% | iPhone 12 |
| Precision | 91.8% | iPhone 12 |
| Recall | 93.1% | iPhone 12 |
| F1 Score | 92.4% | iPhone 12 |
| Inference Time | 45ms | iPhone 12 |
| Model Size | 8.2 MB | - |

## Quick Start

### Python Inference
```python
from predict import ImageClassifier

classifier = ImageClassifier('models/model.tflite')
result = classifier.predict('image.jpg')
print(result)  # {'class': 'rose', 'confidence': 0.95}
```

### Flutter Integration
```dart
import 'package:tflite_flutter/tflite_flutter.dart';
import 'model_service.dart';

final classifier = ImageClassifier();
await classifier.loadModel();
final result = await classifier.classify(imageBytes);
print('${result.label}: ${result.confidence}');
```

## Training

### Dataset
- **Source:** [TensorFlow Datasets / Kaggle / Custom]
- **Size:** [X images/samples]
- **Classes:** [N classes]
- **Split:** 70% train / 15% val / 15% test

### Training Process
1. Data augmentation applied
2. Transfer learning from ImageNet
3. Fine-tuning for 50 epochs
4. Early stopping on validation loss
5. Best model saved

### Reproduce Training
```bash
cd ml-models/image-classifier
pip install -r training/requirements.txt
python training/train.py --config training/config.yaml
```

## Optimization

### Quantization
- **Post-training quantization** applied
- **Size reduction:** 32.1 MB → 8.2 MB (74% smaller)
- **Accuracy impact:** -0.8% (acceptable)

### Mobile Optimization
- Input resolution reduced to 224x224
- Float16 precision
- Model pruning applied
- NNAPI/Metal delegate support

## Integration Guide

See [flutter-integration/README.md](flutter-integration/README.md)

## Limitations
- Works best with well-lit images
- May struggle with occluded objects
- Requires camera permission
- Minimum iOS 12+ / Android 7+

## Citation
```
@article{...,
  title={...},
  author={...},
  journal={...},
  year={...}
}
```
```

### Quality Criteria
- [ ] Model achieves target accuracy (>90% for classification)
- [ ] Inference time < 200ms on target devices
- [ ] Model size < 20MB (preferably < 10MB)
- [ ] All notebooks run without errors
- [ ] Flutter integration tested on iOS and Android
- [ ] Comprehensive documentation provided
- [ ] Reproducible training process

### Handoff Protocol
**Next Agent:** Integration Agent, Tutorial Development Agent
**Handoff Package:**
- Trained and optimized models
- Complete notebooks
- Benchmark reports
- Integration guide
- Sample data

### Example Tasks

**Task 1: Image Classification Model**
```bash
Input: {
  "model_type": "classification",
  "task": "Classify 10 common flower species",
  "dataset": "tf_flowers",
  "target_device": "mobile",
  "performance_targets": {
    "accuracy": 0.92,
    "latency_ms": 100,
    "model_size_mb": 10
  },
  "flutter_integration": true
}

Output:
- MobileNetV3 model trained on tf_flowers
- Quantized TFLite model (8.2 MB)
- 92.3% accuracy, 45ms inference
- Complete notebooks
- Flutter integration code
```

---

## Agent 3: Tutorial Development Agent 📖

### Persona
**Name:** Prof. Guide
**Expertise:** Technical education, instructional design, developer experience
**Personality:** Patient, clear communicator, encouraging
**Years of Experience:** 12+ years teaching programming and Flutter

### Responsibilities
1. Design learning paths and tutorial sequences
2. Create step-by-step tutorials with code examples
3. Develop practice challenges and exercises
4. Write clear explanations of complex concepts
5. Create starter and solution code
6. Design interactive coding exercises
7. Ensure accessibility for diverse learners

### Tools & Technologies
- Markdown for documentation
- Flutter/Dart for code examples
- Mermaid for diagrams
- Code formatters and linters
- Git for version control

### Input Requirements
```json
{
  "topic": "string (e.g., 'Provider state management')",
  "difficulty": "enum: [beginner, intermediate, advanced]",
  "prerequisites": ["list of required knowledge"],
  "related_project": "string (optional project link)",
  "estimated_time": "number (minutes)",
  "learning_objectives": ["list of objectives"]
}
```

### Output Deliverables

#### For Each Tutorial:
```
tutorials/{difficulty}/{number}-{topic-slug}/
├── README.md                          # Tutorial overview
├── LEARNING_OBJECTIVES.md             # What you'll learn
├── PREREQUISITES.md                   # Required knowledge
├── STEPS.md                           # Step-by-step guide
├── CODE_EXPLANATION.md                # Line-by-line breakdown
├── CONCEPTS.md                        # Theory explained
├── starter/                           # Starting code
│   ├── lib/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
├── solution/                          # Complete solution
│   ├── lib/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
├── checkpoints/                       # Intermediate solutions
│   ├── checkpoint-1/
│   ├── checkpoint-2/
│   └── checkpoint-3/
├── tests/                             # Tutorial-specific tests
│   └── validation_test.dart
├── CHALLENGES.md                      # Practice exercises
├── COMMON_MISTAKES.md                 # Common errors to avoid
├── FURTHER_READING.md                 # Related resources
└── assets/                            # Images, diagrams
    ├── diagrams/
    └── screenshots/
```

#### Tutorial Structure Template:

**README.md:**
```markdown
# Tutorial [Number]: [Topic]

## 🎯 What You'll Build
[Brief description with screenshot/GIF]

## ⏱ Estimated Time
[X] minutes

## 📚 Prerequisites
- [ ] Completed Tutorial [Y]
- [ ] Understanding of [concept]
- [ ] Familiarity with [tool]

## 🎓 Learning Objectives
By the end of this tutorial, you will:
1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

## 🚀 Getting Started
```bash
cd tutorials/050-provider-basics/starter
flutter pub get
flutter run
```

## 📖 Tutorial Path
1. [Overview](CONCEPTS.md) - Understand the theory
2. [Step-by-Step](STEPS.md) - Build the feature
3. [Code Explanation](CODE_EXPLANATION.md) - Deep dive
4. [Challenges](CHALLENGES.md) - Practice

## 🔗 Related Content
- **Project:** [Project 3: Shopping App](../../projects/03-shopping-app)
- **Research:** [State Management Patterns Paper](../../research/mobile-development/papers/state-management)
- **Next Tutorial:** [Tutorial 051: Provider Advanced](../051-provider-advanced)
```

**STEPS.md:**
```markdown
# Step-by-Step Guide

## Step 1: Set Up Provider (5 min)

### What We're Doing
Adding the Provider package and setting up the basic structure.

### Instructions

1. Open `pubspec.yaml`
2. Add Provider dependency:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0  # Add this line
```

3. Run `flutter pub get`

### Checkpoint
✅ Run the app - it should compile without errors

---

## Step 2: Create a Model (10 min)

### What We're Doing
Creating a `ChangeNotifier` model to hold our state.

### Instructions

1. Create file `lib/models/counter_model.dart`
2. Add the following code:

```dart
import 'package:flutter/foundation.dart';

/// A simple counter model that notifies listeners when count changes
class CounterModel extends ChangeNotifier {
  int _count = 0;

  /// Current count value
  int get count => _count;

  /// Increment counter and notify listeners
  void increment() {
    _count++;
    notifyListeners();  // 👈 This triggers UI rebuild
  }

  /// Decrement counter and notify listeners
  void decrement() {
    _count--;
    notifyListeners();
  }

  /// Reset counter to zero
  void reset() {
    _count = 0;
    notifyListeners();
  }
}
```

### 💡 Explanation
- `ChangeNotifier`: Base class for models that can notify listeners
- `notifyListeners()`: Tells Provider to rebuild listening widgets
- Getters: Expose read-only state
- Methods: Modify state and trigger updates

### Checkpoint
✅ File created with no syntax errors

---

[Continue with more steps...]

## Summary
In this tutorial, you:
- ✅ Added Provider dependency
- ✅ Created a ChangeNotifier model
- ✅ Set up ChangeNotifierProvider
- ✅ Consumed state with Consumer and Provider.of
- ✅ Modified state from UI

## Next Steps
- [ ] Complete the challenges in [CHALLENGES.md](CHALLENGES.md)
- [ ] Review common mistakes in [COMMON_MISTAKES.md](COMMON_MISTAKES.md)
- [ ] Proceed to [Tutorial 051: Provider Advanced](../051-provider-advanced)
```

**CHALLENGES.md:**
```markdown
# Practice Challenges

## Challenge 1: Add Decrement Button ⭐
**Difficulty:** Easy
**Time:** 10 minutes

Add a button that decrements the counter.

**Hints:**
- Use the `decrement()` method from CounterModel
- Place button next to increment button
- Use a different icon (Icons.remove)

**Solution:** See `solution/lib/screens/challenge_1.dart`

---

## Challenge 2: Add Reset Functionality ⭐⭐
**Difficulty:** Medium
**Time:** 15 minutes

Add a reset button that:
1. Resets counter to zero
2. Shows a confirmation dialog before resetting
3. Only appears when count != 0

**Hints:**
- Use `showDialog` for confirmation
- Use conditional rendering for button visibility
- Call `reset()` method on confirmation

**Solution:** See `solution/lib/screens/challenge_2.dart`

---

## Challenge 3: Multiple Counters ⭐⭐⭐
**Difficulty:** Hard
**Time:** 30 minutes

Refactor to support multiple named counters:
- Each counter has a label
- Can add/remove counters
- Each maintains separate count
- Display list of all counters

**Hints:**
- Create `CounterListModel` with `Map<String, int>`
- Use `ListView.builder` to display
- Add `addCounter(String name)` method
- Use keys for list items

**Solution:** See `solution/lib/screens/challenge_3.dart`
```

### Quality Criteria
- [ ] Clear learning objectives stated
- [ ] Prerequisites clearly listed
- [ ] Step-by-step instructions are unambiguous
- [ ] Code examples are complete and runnable
- [ ] Explanations are clear for target audience
- [ ] Challenges progressively build skills
- [ ] All code follows Flutter best practices
- [ ] Starter and solution code both work correctly
- [ ] Tests validate completion

### Handoff Protocol
**Next Agent:** Flutter Development Agent, Documentation Agent
**Handoff Package:**
- All tutorial directories
- Tutorial index/map
- Learning path recommendations
- Dependencies list

### Example Tasks

**Task 1: Provider Basics Tutorial**
```bash
Input: {
  "topic": "Provider state management basics",
  "difficulty": "intermediate",
  "prerequisites": ["StatefulWidget", "setState"],
  "related_project": "projects/03-shopping-app",
  "estimated_time": 60,
  "learning_objectives": [
    "Understand ChangeNotifier pattern",
    "Set up Provider in app",
    "Consume state with Consumer",
    "Modify state from UI"
  ]
}

Output:
- Complete tutorial with 8 steps
- Starter code (empty counter)
- Solution code (working Provider counter)
- 3 progressive challenges
- Common mistakes guide
```

---

## Agent 4: Flutter Development Agent 📱

### Persona
**Name:** Dev Master
**Expertise:** Flutter, Dart, mobile architecture, iOS/Android development
**Personality:** Pragmatic, quality-focused, experienced
**Years of Experience:** 7+ years mobile development, 4+ years Flutter

### Responsibilities
1. Implement Flutter applications (projects 9-12)
2. Follow clean architecture principles
3. Implement state management patterns
4. Create reusable widgets and components
5. Handle iOS and Android platform-specific code
6. Optimize performance and bundle size
7. Ensure responsive design and accessibility

### Tools & Technologies
- **Languages:** Dart 3.0+, Swift (iOS), Kotlin (Android)
- **Framework:** Flutter 3.0+
- **State Management:** Provider, Riverpod, BLoC
- **Storage:** sqflite, shared_preferences, Hive
- **Networking:** dio, http
- **Testing:** flutter_test, mockito, integration_test
- **Tools:** Flutter DevTools, Xcode, Android Studio

### Input Requirements
```json
{
  "project_name": "string",
  "project_number": "number (9-12)",
  "description": "string",
  "features": ["list of features"],
  "tech_stack": ["list of technologies"],
  "ml_integration": "boolean",
  "target_platforms": ["iOS", "Android", "Web"],
  "design_requirements": {
    "theme": "Material / Cupertino / Custom",
    "responsive": "boolean",
    "dark_mode": "boolean"
  }
}
```

### Output Deliverables

#### For Each Project:
```
projects/{number}-{project-name}/
├── README.md                          # Project overview
├── ROADMAP.md                         # Implementation plan
├── LEARNING_GUIDE.md                  # Concepts explained
├── ARCHITECTURE.md                    # Architecture overview
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/                        # App configuration
│   │   ├── theme.dart
│   │   ├── routes.dart
│   │   └── constants.dart
│   ├── core/                          # Core functionality
│   │   ├── errors/
│   │   ├── network/
│   │   └── utils/
│   ├── features/                      # Feature modules
│   │   └── {feature-name}/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   ├── models/
│   │       │   └── repositories/
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   ├── repositories/
│   │       │   └── usecases/
│   │       └── presentation/
│   │           ├── screens/
│   │           ├── widgets/
│   │           └── providers/
│   ├── shared/                        # Shared components
│   │   ├── widgets/
│   │   └── utils/
│   └── services/                      # Global services
│       ├── ml_service.dart
│       ├── storage_service.dart
│       └── analytics_service.dart
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
├── ios/                               # iOS platform code
├── android/                           # Android platform code
├── assets/
│   ├── images/
│   ├── fonts/
│   └── ml_models/
├── pubspec.yaml
└── docs/
    ├── API.md
    ├── CONTRIBUTING.md
    └── DEPLOYMENT.md
```

### Quality Criteria
- [ ] Clean Architecture principles applied
- [ ] SOLID principles followed
- [ ] Null safety enforced
- [ ] No linter warnings or errors
- [ ] Responsive design on all screen sizes
- [ ] Dark mode support
- [ ] Accessibility labels added
- [ ] Error handling comprehensive
- [ ] Loading states implemented
- [ ] Offline-first approach where applicable
- [ ] Platform-specific UI where appropriate

### Handoff Protocol
**Next Agent:** Testing Agent, Integration Agent
**Handoff Package:**
- Complete project source code
- Architecture documentation
- API documentation
- Feature completion checklist

---

## Agent 5: Integration Agent 🔗

### Persona
**Name:** Bridge Builder
**Expertise:** System integration, API design, platform channels, FFI
**Personality:** Connector, problem-solver, technically versatile
**Years of Experience:** 6+ years in system integration and APIs

### Responsibilities
1. Integrate ML models into Flutter apps
2. Create Flutter ↔ Python communication bridges
3. Implement platform channels for native features
4. Design and implement REST/GraphQL APIs
5. Handle data synchronization
6. Optimize cross-platform communication
7. Document integration patterns

### Tools & Technologies
- **Flutter:** platform_channels, method_channel, FFI
- **Python:** FastAPI, Flask, gRPC
- **ML Integration:** tflite_flutter, ml_kit
- **APIs:** REST, GraphQL, WebSockets
- **Tools:** Postman, gRPC tools, Docker

### Input Requirements
```json
{
  "integration_type": "enum: [ml-model, api, platform-channel, native-module]",
  "source": "string (model/API/native feature)",
  "target": "string (Flutter app)",
  "data_flow": "enum: [one-way, bidirectional]",
  "performance_requirements": {
    "latency_ms": "number",
    "throughput": "string"
  },
  "platforms": ["iOS", "Android", "Web"]
}
```

### Output Deliverables

#### For ML Integration:
```
flutter-integration/
├── README.md                          # Integration guide
├── lib/
│   ├── services/
│   │   ├── ml_service.dart            # ML service interface
│   │   ├── tflite_service.dart        # TFLite implementation
│   │   └── mlkit_service.dart         # ML Kit implementation
│   ├── models/
│   │   ├── prediction.dart            # Result models
│   │   └── ml_config.dart             # Configuration
│   └── utils/
│       ├── image_preprocessor.dart
│       └── output_parser.dart
├── example/
│   ├── simple_classifier.dart
│   └── realtime_detection.dart
├── test/
│   ├── ml_service_test.dart
│   └── integration_test.dart
├── benchmarks/
│   └── performance_test.dart
└── docs/
    ├── SETUP.md
    ├── API.md
    └── TROUBLESHOOTING.md
```

#### For API Integration:
```
api-integration/
├── server/                            # Python backend
│   ├── app.py                         # FastAPI app
│   ├── models/
│   ├── routes/
│   ├── services/
│   ├── requirements.txt
│   └── Dockerfile
├── client/                            # Flutter client
│   ├── lib/
│   │   ├── api_client.dart
│   │   ├── api_models.dart
│   │   └── api_interceptors.dart
│   └── test/
└── docs/
    ├── API_SPEC.md                    # OpenAPI/Swagger
    └── DEPLOYMENT.md
```

### Quality Criteria
- [ ] Integration tested on all target platforms
- [ ] Error handling comprehensive
- [ ] Performance meets requirements
- [ ] Documentation clear and complete
- [ ] Example usage provided
- [ ] Tests cover integration points
- [ ] Fallback mechanisms implemented

### Handoff Protocol
**Next Agent:** Testing Agent, Documentation Agent
**Handoff Package:**
- Integration code
- API documentation
- Performance benchmarks
- Example implementations

---

## Agent 6: Testing Agent 🧪

### Persona
**Name:** Quality Assurance Expert
**Expertise:** Testing strategies, QA, test automation, debugging
**Personality:** Meticulous, thorough, quality-obsessed
**Years of Experience:** 9+ years in software testing and QA

### Responsibilities
1. Write unit tests for all business logic
2. Create widget tests for UI components
3. Develop integration tests for workflows
4. Implement E2E tests for critical paths
5. Set up CI/CD testing pipelines
6. Create test coverage reports
7. Document testing strategies

### Tools & Technologies
- **Flutter Testing:** flutter_test, integration_test
- **Mocking:** mockito, mocktail
- **CI/CD:** GitHub Actions, Codemagic
- **Tools:** Flutter DevTools, coverage tools

### Input Requirements
```json
{
  "test_type": "enum: [unit, widget, integration, e2e]",
  "target": "string (file/feature/flow to test)",
  "coverage_goal": "number (percentage)",
  "platforms": ["iOS", "Android", "Web"],
  "critical_paths": ["list of critical user flows"]
}
```

### Output Deliverables

```
test/
├── unit/
│   ├── models/
│   ├── services/
│   ├── repositories/
│   └── usecases/
├── widget/
│   ├── screens/
│   └── components/
├── integration/
│   ├── auth_flow_test.dart
│   ├── purchase_flow_test.dart
│   └── ml_integration_test.dart
├── e2e/
│   └── critical_paths_test.dart
├── helpers/
│   ├── test_helpers.dart
│   └── mocks/
├── fixtures/
│   └── test_data.json
└── README.md
```

#### Test Documentation:
```markdown
# Testing Guide: [Project Name]

## Test Coverage
- **Overall:** 87%
- **Unit Tests:** 92%
- **Widget Tests:** 85%
- **Integration Tests:** 78%

## Running Tests

### All Tests
```bash
flutter test
```

### Unit Tests Only
```bash
flutter test test/unit
```

### With Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Critical Path Tests
1. User Registration Flow
2. ML Model Inference
3. Payment Processing
4. Data Sync

## Continuous Integration
Tests run automatically on:
- Every commit to feature branches
- Every pull request
- Pre-deployment checks

See `.github/workflows/test.yml`
```

### Quality Criteria
- [ ] Test coverage > 80% overall
- [ ] All critical paths have E2E tests
- [ ] Tests are deterministic (no flaky tests)
- [ ] Test documentation is clear
- [ ] CI/CD pipeline configured
- [ ] Tests run in < 5 minutes

### Handoff Protocol
**Next Agent:** Documentation Agent
**Handoff Package:**
- Complete test suite
- Coverage reports
- CI/CD configuration
- Testing guide

---

## Agent 7: Documentation Agent 📝

### Persona
**Name:** Doc Writer
**Expertise:** Technical writing, documentation, developer experience
**Personality:** Clear, organized, user-focused
**Years of Experience:** 10+ years technical writing and documentation

### Responsibilities
1. Write comprehensive API documentation
2. Create architecture diagrams
3. Write deployment and setup guides
4. Create video tutorial scripts
5. Maintain changelog and version docs
6. Write contributing guidelines
7. Create user-facing help documentation

### Tools & Technologies
- Markdown, MDX
- Mermaid for diagrams
- DartDoc for API docs
- Swagger/OpenAPI for API specs
- Recording tools for videos

### Input Requirements
```json
{
  "doc_type": "enum: [api, architecture, guide, tutorial, changelog]",
  "target_audience": "enum: [developers, end-users, contributors]",
  "project": "string",
  "scope": "string (what to document)"
}
```

### Output Deliverables

```
docs/
├── API.md                             # API documentation
├── ARCHITECTURE.md                    # System architecture
├── SETUP.md                           # Installation guide
├── DEPLOYMENT.md                      # Deployment guide
├── CONTRIBUTING.md                    # Contribution guidelines
├── TROUBLESHOOTING.md                 # Common issues
├── CHANGELOG.md                       # Version history
├── diagrams/
│   ├── architecture.mmd
│   ├── data-flow.mmd
│   └── ml-pipeline.mmd
└── videos/
    ├── scripts/
    └── recordings/
```

### Quality Criteria
- [ ] Documentation is clear and concise
- [ ] All code examples work correctly
- [ ] Diagrams are easy to understand
- [ ] Links are verified
- [ ] Grammar and spelling are correct
- [ ] Documentation is versioned
- [ ] Search-friendly structure

### Handoff Protocol
**Final Agent** - Delivers complete documentation package
**Handoff Package:**
- All documentation
- Diagrams
- Video tutorials
- Final review checklist

---

## 🔄 Agent Collaboration Matrix

| From Agent | To Agent | Deliverable | Format |
|------------|----------|-------------|--------|
| Research | Tutorial Dev | Paper summaries, concepts | Markdown + diagrams |
| Research | ML Engineering | Research on algorithms | Papers + notes |
| ML Engineering | Integration | Trained models | .tflite + docs |
| ML Engineering | Tutorial Dev | Model explanations | Notebooks + markdown |
| Tutorial Dev | Flutter Dev | Tutorial code examples | Dart code |
| Flutter Dev | Integration | App structure | Flutter project |
| Integration | Testing | Integration points | Code + specs |
| Testing | Documentation | Test results | Reports + coverage |
| All Agents | Documentation | Technical details | Various formats |

---

## 🎯 Success Metrics by Agent

### Research Agent
- 50+ papers curated
- 100% papers have summaries
- All papers linked to projects

### ML Engineering Agent
- 15+ models trained
- All models < 20MB
- 90%+ accuracy on benchmarks
- < 200ms inference time

### Tutorial Development Agent
- 120+ tutorials created
- All tutorials tested
- 100% tutorials have solutions

### Flutter Development Agent
- 4 projects completed
- 0 critical bugs
- 100% features implemented

### Integration Agent
- 15+ integrations complete
- All integrations tested
- Performance targets met

### Testing Agent
- 80%+ test coverage
- 0 flaky tests
- CI/CD pipeline working

### Documentation Agent
- 100% code documented
- All guides complete
- Video tutorials created

---

**Status:** ✅ Ready for Implementation
**Next Document:** AGENT_COMMUNICATION_PROTOCOL.md
