# Agent Communication Protocol
## Inter-Agent Communication Standards & Procedures

**Version:** 1.0
**Date:** 2025-11-19

---

## 📋 Overview

This document defines the communication standards, handoff procedures, and coordination mechanisms for the 7 specialized agents working on the Flutter + AI/ML Learning Platform.

**Core Principles:**
- **Clarity**: All handoffs include complete context
- **Traceability**: Every deliverable is versioned and tracked
- **Quality**: Each agent validates inputs before accepting
- **Efficiency**: Parallel work when possible, serial when dependent

---

## 🗂️ Communication Channels

### 1. Handoff Packages

**Format:** Structured JSON + file references

```json
{
  "handoff_id": "unique-identifier",
  "timestamp": "ISO 8601 datetime",
  "from_agent": "agent-name",
  "to_agent": "agent-name",
  "phase": "string (e.g., 'research', 'development')",
  "deliverables": {
    "primary": ["list of main deliverables"],
    "supporting": ["list of supporting materials"]
  },
  "metadata": {
    "project": "string (optional)",
    "priority": "enum: [low, medium, high, critical]",
    "estimated_effort": "string (e.g., '2-3 days')",
    "dependencies": ["list of dependencies"]
  },
  "validation_checklist": [
    {
      "item": "description",
      "status": "enum: [pass, fail, pending]",
      "notes": "string (optional)"
    }
  ],
  "notes": "string (additional context)",
  "next_steps": ["list of recommended actions"]
}
```

**Example Handoff:**
```json
{
  "handoff_id": "RESEARCH-001-TO-MLENG",
  "timestamp": "2025-11-19T10:00:00Z",
  "from_agent": "Research Agent",
  "to_agent": "ML Engineering Agent",
  "phase": "research-complete",
  "deliverables": {
    "primary": [
      "research/machine-learning/computer-vision/papers/mobilenet-analysis.md",
      "research/machine-learning/computer-vision/reading-guide.md"
    ],
    "supporting": [
      "research/machine-learning/computer-vision/datasets-catalog.md"
    ]
  },
  "metadata": {
    "project": "projects/09-ai-image-classifier",
    "priority": "high",
    "estimated_effort": "4-5 days for model training",
    "dependencies": ["GPU access", "TensorFlow 2.15+"]
  },
  "validation_checklist": [
    {
      "item": "All papers are peer-reviewed or from reputable sources",
      "status": "pass",
      "notes": "5 papers from IEEE, CVPR, and Google Research"
    },
    {
      "item": "Summaries are accurate and comprehensive",
      "status": "pass",
      "notes": "Executive summaries provided for all papers"
    },
    {
      "item": "Clear connection to mobile ML applications",
      "status": "pass",
      "notes": "Practical applications section links to Project 9"
    }
  ],
  "notes": "Focus on MobileNetV3 architecture - best balance of accuracy and speed for mobile devices. Consider quantization strategies from Paper 3.",
  "next_steps": [
    "Set up training environment",
    "Download tf_flowers dataset",
    "Implement MobileNetV3 architecture",
    "Train baseline model",
    "Apply quantization"
  ]
}
```

### 2. Status Updates

**Frequency:** Daily for active work, weekly for background tasks

**Format:**
```json
{
  "agent": "agent-name",
  "date": "ISO 8601 date",
  "status": "enum: [on-track, at-risk, blocked]",
  "current_task": "description",
  "progress": {
    "completed": ["list of completed items"],
    "in_progress": ["list of current work"],
    "blocked": ["list of blockers with details"]
  },
  "metrics": {
    "velocity": "number (items per day)",
    "quality_score": "number (0-100)"
  },
  "next_24h": ["planned work for next day"],
  "help_needed": "string (optional)"
}
```

### 3. Clarification Requests

**When to use:** Agent needs additional context or finds ambiguity

**Format:**
```json
{
  "request_id": "unique-identifier",
  "from_agent": "agent-name",
  "to_agent": "agent-name",
  "type": "enum: [clarification, blocker, scope-change, quality-issue]",
  "priority": "enum: [low, medium, high, urgent]",
  "question": "clear, specific question",
  "context": "relevant background",
  "options": ["possible solutions/answers"],
  "impact": "what's blocked by this",
  "deadline": "ISO 8601 datetime (when answer needed)"
}
```

**Example:**
```json
{
  "request_id": "CLARIFY-003",
  "from_agent": "ML Engineering Agent",
  "to_agent": "Research Agent",
  "type": "clarification",
  "priority": "medium",
  "question": "Paper summary mentions 'lightweight CNN architecture' - which specific architecture should I use for mobile deployment?",
  "context": "Training image classifier for Project 9. Need to choose between MobileNetV2, MobileNetV3, and EfficientNet-lite.",
  "options": [
    "MobileNetV3-Small (1.5M params, fastest)",
    "MobileNetV3-Large (4.2M params, most accurate)",
    "EfficientNet-B0 (5.3M params, balanced)"
  ],
  "impact": "Model architecture choice - affects all subsequent training work",
  "deadline": "2025-11-20T17:00:00Z"
}
```

---

## 🔄 Handoff Procedures

### Standard Handoff Process

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│  Step 1: Sender Prepares Deliverables              │
│  ├─ Complete all work items                        │
│  ├─ Run validation checks                          │
│  ├─ Package deliverables                           │
│  └─ Create handoff package JSON                    │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 2: Sender Validates Quality                  │
│  ├─ Run self-review checklist                      │
│  ├─ Verify all required files present              │
│  ├─ Check formatting and standards                 │
│  └─ Ensure documentation complete                  │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 3: Sender Submits Handoff                    │
│  ├─ Create handoff package                         │
│  ├─ Add to handoff queue                           │
│  ├─ Notify receiver                                │
│  └─ Update status tracker                          │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 4: Receiver Acknowledges                     │
│  ├─ Review handoff package                         │
│  ├─ Check completeness                             │
│  ├─ Estimate effort                                │
│  └─ Acknowledge receipt (< 2 hours)                │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 5: Receiver Validates                        │
│  ├─ Run validation scripts                         │
│  ├─ Review quality criteria                        │
│  ├─ Test deliverables                              │
│  └─ Report issues OR accept                        │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 6: Resolve Issues (if any)                   │
│  ├─ Receiver documents issues                      │
│  ├─ Sender fixes issues                            │
│  ├─ Re-validation                                  │
│  └─ Final acceptance                               │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Step 7: Begin Work                                │
│  ├─ Receiver starts next phase                     │
│  ├─ Update project status                          │
│  └─ Send confirmation to sender                    │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Handoff SLAs

| Step | Max Duration | Notes |
|------|--------------|-------|
| Acknowledgment | 2 hours | Receiver confirms receipt |
| Initial Validation | 4 hours | Quick check for completeness |
| Full Validation | 1 day | Thorough review and testing |
| Issue Resolution | 2 days | Fixes for any problems found |
| Total Handoff Time | 3 days | End-to-end including fixes |

---

## 🚦 Handoff Workflows by Agent Pair

### Research Agent → ML Engineering Agent

**Trigger:** Research phase complete for ML topic

**Deliverables:**
- Curated papers on relevant ML topic
- Executive summaries
- Recommended algorithms/architectures
- Dataset recommendations
- Performance benchmarks from literature

**Validation Criteria:**
- [ ] Minimum 5 relevant papers included
- [ ] All papers have summaries
- [ ] Clear recommendation on architecture
- [ ] Dataset availability confirmed
- [ ] Performance targets defined

**Example:**
```
Input to ML Engineering Agent:
  "Based on research, implement MobileNetV3-Large for image
   classification. Target: 92% accuracy, <100ms inference, <10MB model.
   Use tf_flowers dataset. See research/computer-vision/mobilenet-guide.md"
```

---

### Research Agent → Tutorial Development Agent

**Trigger:** Research phase complete for educational topic

**Deliverables:**
- Papers on educational theory (if applicable)
- Concept breakdowns
- Learning progression recommendations
- Common misconceptions identified
- Best practices from literature

**Validation Criteria:**
- [ ] Concepts clearly explained
- [ ] Progression path defined
- [ ] Prerequisites identified
- [ ] Learning objectives clear

---

### ML Engineering Agent → Integration Agent

**Trigger:** ML model training complete

**Deliverables:**
- Trained model (.h5, .tflite)
- Training notebook
- Model metadata JSON
- Benchmark results
- Input/output specifications
- Sample test data

**Validation Criteria:**
- [ ] Model meets accuracy targets
- [ ] Model meets size constraints
- [ ] Model meets latency requirements
- [ ] TFLite model tested and working
- [ ] Input preprocessing documented
- [ ] Output format documented

**Handoff Package:**
```json
{
  "from_agent": "ML Engineering Agent",
  "to_agent": "Integration Agent",
  "deliverables": {
    "primary": [
      "ml-models/image-classifier/models/model.tflite",
      "ml-models/image-classifier/models/model_metadata.json"
    ],
    "supporting": [
      "ml-models/image-classifier/notebooks/training.ipynb",
      "ml-models/image-classifier/benchmarks/performance_report.md",
      "ml-models/image-classifier/data/sample_inputs.zip"
    ]
  },
  "metadata": {
    "model_type": "image_classification",
    "input_shape": [224, 224, 3],
    "output_shape": [10],
    "accuracy": 0.923,
    "inference_time_ms": 45,
    "model_size_mb": 8.2
  },
  "notes": "Model uses RGB input normalized to [0,1]. Output is softmax probabilities for 10 flower classes. Best performance with NNAPI delegate on Android and Metal on iOS.",
  "next_steps": [
    "Create Flutter service wrapper",
    "Implement image preprocessing",
    "Add result parsing",
    "Test on target devices",
    "Optimize for production"
  ]
}
```

---

### ML Engineering Agent → Tutorial Development Agent

**Trigger:** ML model complete and ready for teaching

**Deliverables:**
- Training notebook with explanations
- Model architecture diagrams
- Step-by-step training process
- Optimization techniques used
- Common pitfalls and solutions

**Validation Criteria:**
- [ ] Notebook runs without errors
- [ ] Each step clearly explained
- [ ] Visualizations included
- [ ] Results reproducible

---

### Tutorial Development Agent → Flutter Development Agent

**Trigger:** Tutorials complete, ready for project implementation

**Deliverables:**
- Complete tutorial series
- Code examples and snippets
- Best practices guide
- Common patterns documented
- Architecture recommendations

**Validation Criteria:**
- [ ] All tutorials tested
- [ ] Code examples work
- [ ] Clear progression path
- [ ] Starter/solution code provided

---

### Flutter Development Agent → Integration Agent

**Trigger:** Flutter app structure complete, ready for ML integration

**Deliverables:**
- Flutter project structure
- Feature modules
- Service interfaces
- UI screens for ML features
- State management setup

**Validation Criteria:**
- [ ] App compiles on iOS and Android
- [ ] Architecture documented
- [ ] Service interfaces defined
- [ ] UI mockups implemented
- [ ] State management in place

**Handoff Package:**
```json
{
  "from_agent": "Flutter Development Agent",
  "to_agent": "Integration Agent",
  "deliverables": {
    "primary": [
      "projects/09-ai-image-classifier/lib/",
      "projects/09-ai-image-classifier/ARCHITECTURE.md"
    ],
    "supporting": [
      "projects/09-ai-image-classifier/docs/API.md"
    ]
  },
  "integration_points": [
    {
      "location": "lib/services/ml_service.dart",
      "interface": "Future<ClassificationResult> classify(Uint8List imageBytes)",
      "notes": "This is where TFLite model should be integrated"
    },
    {
      "location": "lib/features/camera/presentation/screens/camera_screen.dart",
      "interface": "Displays real-time classification results",
      "notes": "Connect to ML service and update UI with results"
    }
  ],
  "notes": "App uses BLoC for state management. ML service should emit states: Loading, Success, Error. See architecture doc for details.",
  "next_steps": [
    "Implement TFLite integration in ml_service.dart",
    "Add image preprocessing pipeline",
    "Connect camera stream to model",
    "Handle results in BLoC",
    "Add error handling"
  ]
}
```

---

### Integration Agent → Testing Agent

**Trigger:** ML model integrated into Flutter app

**Deliverables:**
- Integrated Flutter app
- Integration documentation
- Example usage code
- Performance benchmarks
- Known limitations

**Validation Criteria:**
- [ ] Integration works on iOS
- [ ] Integration works on Android
- [ ] Performance meets targets
- [ ] Error handling implemented
- [ ] Documentation complete

---

### Flutter Development Agent → Testing Agent

**Trigger:** Feature development complete

**Deliverables:**
- Complete Flutter app
- Feature documentation
- Known edge cases
- Testing priorities
- Critical user flows

**Validation Criteria:**
- [ ] All features implemented
- [ ] App compiles without errors
- [ ] No linter warnings
- [ ] Documentation complete

**Handoff Package:**
```json
{
  "from_agent": "Flutter Development Agent",
  "to_agent": "Testing Agent",
  "deliverables": {
    "primary": [
      "projects/09-ai-image-classifier/"
    ],
    "supporting": [
      "projects/09-ai-image-classifier/docs/TESTING_GUIDE.md"
    ]
  },
  "test_priorities": [
    {
      "feature": "Image Classification",
      "priority": "critical",
      "test_types": ["unit", "integration", "e2e"],
      "coverage_target": 90
    },
    {
      "feature": "Camera Integration",
      "priority": "high",
      "test_types": ["widget", "integration"],
      "coverage_target": 85
    },
    {
      "feature": "Results History",
      "priority": "medium",
      "test_types": ["unit", "widget"],
      "coverage_target": 80
    }
  ],
  "critical_paths": [
    "User opens app → grants camera permission → classifies image → sees result",
    "User selects image from gallery → classifies → saves to history",
    "User views history → taps item → sees details"
  ],
  "edge_cases": [
    "Camera permission denied",
    "Invalid image format",
    "Model file missing",
    "Network error (if online features)",
    "Low memory scenario"
  ],
  "notes": "Focus testing on ML inference accuracy and performance. Ensure graceful degradation when model fails.",
  "next_steps": [
    "Create unit tests for all services",
    "Create widget tests for all screens",
    "Create integration tests for ML pipeline",
    "Create E2E tests for critical paths",
    "Generate coverage report"
  ]
}
```

---

### Testing Agent → Documentation Agent

**Trigger:** Testing complete, coverage targets met

**Deliverables:**
- Complete test suite
- Test coverage report
- Bug reports (if any)
- Performance test results
- Tested device list

**Validation Criteria:**
- [ ] Coverage > 80%
- [ ] All critical paths tested
- [ ] No failing tests
- [ ] CI/CD configured

---

### All Agents → Documentation Agent

**Trigger:** Any major milestone or completion

**Deliverables:**
- Technical details to document
- API specifications
- Architecture decisions
- User-facing changes
- Known issues

**Validation Criteria:**
- [ ] Information accurate
- [ ] Examples provided
- [ ] Context included

---

## 🔧 Tools & Systems

### 1. Handoff Tracker

**Location:** `/.agent-handoffs/tracker.json`

```json
{
  "handoffs": [
    {
      "id": "HANDOFF-001",
      "status": "completed",
      "from": "Research Agent",
      "to": "ML Engineering Agent",
      "created": "2025-11-15T10:00:00Z",
      "acknowledged": "2025-11-15T11:30:00Z",
      "completed": "2025-11-16T14:00:00Z",
      "deliverables": ["..."]
    }
  ]
}
```

### 2. Validation Scripts

**Location:** `/.agent-handoffs/validators/`

Each agent pair has automated validation scripts:

```bash
/.agent-handoffs/validators/
├── research_to_ml.py           # Validates research → ML handoff
├── ml_to_integration.py        # Validates ML → integration handoff
├── flutter_to_testing.py       # Validates Flutter → testing handoff
└── common.py                   # Shared validation utilities
```

**Example Validator:**
```python
# research_to_ml.py
def validate_handoff(handoff_package):
    """Validate Research Agent → ML Engineering Agent handoff"""

    checks = []

    # Check 1: Required papers present
    papers = handoff_package['deliverables']['primary']
    if len(papers) < 5:
        checks.append({
            'item': 'Minimum 5 papers required',
            'status': 'fail',
            'notes': f'Only {len(papers)} papers provided'
        })
    else:
        checks.append({
            'item': 'Minimum 5 papers required',
            'status': 'pass'
        })

    # Check 2: All papers have summaries
    for paper in papers:
        summary_path = paper.replace('.pdf', '_SUMMARY.md')
        if not os.path.exists(summary_path):
            checks.append({
                'item': f'Summary for {paper}',
                'status': 'fail',
                'notes': 'Summary file not found'
            })

    # Check 3: Architecture recommendation clear
    if 'recommended_architecture' not in handoff_package['metadata']:
        checks.append({
            'item': 'Architecture recommendation',
            'status': 'fail',
            'notes': 'No clear architecture recommendation found'
        })

    return checks
```

### 3. Status Dashboard

**Location:** `/.agent-handoffs/dashboard.html`

Web-based dashboard showing:
- Current agent statuses
- Active handoffs
- Blocked items
- Progress metrics
- Timeline view

---

## 📊 Quality Gates

### Entry Criteria (for handoff acceptance)

Receiver agent should verify:
- [ ] All required files present
- [ ] Documentation complete
- [ ] Examples work correctly
- [ ] Tests pass (if applicable)
- [ ] Meets quality standards
- [ ] Context sufficient to proceed

### Exit Criteria (for handoff completion)

Sender agent must ensure:
- [ ] All deliverables complete
- [ ] Self-validation passed
- [ ] Documentation up-to-date
- [ ] Next steps clearly defined
- [ ] Handoff package created
- [ ] Receiver acknowledged

---

## 🚨 Escalation Procedures

### Blocker Escalation

**Level 1: Clarification Request (2 hours)**
- Agent sends clarification request
- Requesting agent continues other work

**Level 2: Direct Communication (8 hours)**
- If no response in 2 hours
- Direct sync meeting
- Document decision

**Level 3: Project Manager Review (24 hours)**
- If blocker persists
- Escalate to project coordinator
- Alternative solution explored

**Level 4: Scope Adjustment (48 hours)**
- If still blocked
- Scope may need adjustment
- Stakeholder involvement

### Quality Issues

**Minor Issues:**
- Document in handoff notes
- Fix during next iteration
- Track in known issues

**Major Issues:**
- Reject handoff
- Return to sender with detailed feedback
- Sender fixes and resubmits
- Re-validation required

**Critical Issues:**
- Immediate escalation
- All work paused on affected items
- Root cause analysis
- Prevention measures implemented

---

## 📝 Communication Templates

### Daily Standup Update

```markdown
## Daily Update: [Agent Name] - [Date]

### Yesterday
- ✅ Completed: [item 1]
- ✅ Completed: [item 2]

### Today
- 🔄 Working on: [item 1]
- 🔄 Working on: [item 2]

### Blockers
- 🚫 [Blocker description] - Needs: [what's needed]

### Help Needed
- 💬 [Question or request for help]

### Handoffs
- 📤 Sent: [handoff to Agent X]
- 📥 Received: [handoff from Agent Y]
```

### Handoff Rejection Notice

```markdown
## Handoff Rejection: [Handoff ID]

**From:** [Receiver Agent]
**To:** [Sender Agent]
**Date:** [Date]

### Reason for Rejection
[Clear explanation of why handoff was rejected]

### Issues Found
1. **[Issue Category]**: [Description]
   - Expected: [what was expected]
   - Found: [what was found]
   - Impact: [how this affects work]

2. **[Issue Category]**: [Description]
   - Expected: [what was expected]
   - Found: [what was found]
   - Impact: [how this affects work]

### Required Actions
- [ ] [Action 1]
- [ ] [Action 2]
- [ ] [Action 3]

### Timeline
- **Fix Deadline:** [Date/Time]
- **Re-validation:** [Date/Time]

### Notes
[Any additional context or suggestions]
```

### Completion Notice

```markdown
## Phase Completion: [Phase Name]

**Agent:** [Agent Name]
**Date:** [Date]
**Status:** ✅ Complete

### Summary
[Brief summary of what was accomplished]

### Deliverables
- ✅ [Deliverable 1] - [location/link]
- ✅ [Deliverable 2] - [location/link]
- ✅ [Deliverable 3] - [location/link]

### Metrics
- **Planned:** [X items]
- **Completed:** [Y items]
- **Quality Score:** [Z%]
- **Time:** [A days] (vs [B days] estimated)

### Handoffs Completed
- 📤 To [Agent X]: [Handoff ID]
- 📤 To [Agent Y]: [Handoff ID]

### Next Phase
[Description of what happens next]
```

---

## 🎯 Success Metrics

### Communication Efficiency
- **Handoff Time:** < 3 days average
- **Acknowledgment Time:** < 2 hours
- **Rejection Rate:** < 10%
- **Clarification Requests:** < 2 per handoff

### Quality Metrics
- **First-Time Acceptance:** > 85%
- **Rework Rate:** < 15%
- **Blocker Resolution Time:** < 1 day
- **Documentation Completeness:** 100%

### Collaboration Metrics
- **Cross-Agent Meetings:** Weekly
- **Knowledge Sharing Sessions:** Bi-weekly
- **Retrospectives:** After each major phase

---

## 🔄 Continuous Improvement

### Weekly Reviews
- Review handoff metrics
- Identify bottlenecks
- Update procedures if needed
- Share learnings

### Monthly Retrospectives
- What worked well
- What could improve
- Action items
- Process updates

### Documentation Updates
- Keep protocols current
- Add new patterns
- Remove obsolete procedures
- Incorporate feedback

---

**Status:** ✅ Ready for Implementation
**Next Document:** AGENT_WORKFLOWS.md
