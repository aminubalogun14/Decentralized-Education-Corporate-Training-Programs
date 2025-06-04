# Decentralized Education Corporate Training Programs

A blockchain-based corporate training platform built on Stacks using Clarity smart contracts. This system provides a decentralized approach to managing corporate training programs with transparent verification, progress tracking, and skill certification.

## System Overview

The platform consists of five interconnected smart contracts that work together to provide a comprehensive training management system:

### 1. Training Provider Verification Contract
- **Purpose**: Manages registration and verification of corporate training providers
- **Key Features**:
    - Provider registration with company details
    - Admin verification system
    - Provider status tracking
    - Verification history

### 2. Curriculum Management Contract
- **Purpose**: Handles creation and management of training curricula and courses
- **Key Features**:
    - Curriculum creation with metadata
    - Course addition and organization
    - Difficulty level classification
    - Duration estimation
    - Category management

### 3. Employee Progress Contract
- **Purpose**: Tracks employee enrollment and training progress
- **Key Features**:
    - Employee enrollment in curricula
    - Course-by-course progress tracking
    - Time spent monitoring
    - Completion status management
    - Progress percentage calculation

### 4. Skill Certification Contract
- **Purpose**: Manages skill assessments and certification issuance
- **Key Features**:
    - Skill assessment submission
    - Automated certification issuance
    - Certification expiration management
    - Multiple attempt tracking
    - Certification revocation

### 5. Performance Measurement Contract
- **Purpose**: Measures training effectiveness and generates analytics
- **Key Features**:
    - Performance metrics recording
    - Curriculum analytics
    - Employee performance tracking
    - Effectiveness score calculation
    - Satisfaction ratings

## Contract Architecture

\`\`\`
┌─────────────────────────────────────────────────────────────┐
│                    Training Platform                        │
├─────────────────────────────────────────────────────────────┤
│  Provider Verification  │  Curriculum Management           │
│  - Register providers   │  - Create curricula              │
│  - Verify credentials   │  - Add courses                   │
│  - Track status         │  - Manage content                │
├─────────────────────────────────────────────────────────────┤
│  Employee Progress      │  Skill Certification             │
│  - Track enrollment     │  - Assess skills                 │
│  - Monitor progress     │  - Issue certificates            │
│  - Record completion    │  - Manage expiration             │
├─────────────────────────────────────────────────────────────┤
│              Performance Measurement                        │
│              - Analytics & Metrics                          │
│              - Effectiveness Scoring                        │
└─────────────────────────────────────────────────────────────┘
\`\`\`

## Key Features

### Decentralized Verification
- Transparent provider verification process
- Immutable training records
- Blockchain-based certification

### Comprehensive Tracking
- Real-time progress monitoring
- Detailed analytics and reporting
- Performance measurement

### Flexible Curriculum Management
- Modular course structure
- Customizable difficulty levels
- Category-based organization

### Automated Certification
- Score-based certification issuance
- Expiration date management
- Revocation capabilities

## Getting Started

### Prerequisites
- Stacks blockchain environment
- Clarity development tools
- Basic understanding of smart contracts

### Deployment

1. Deploy contracts in the following order:
   \`\`\`bash
   # 1. Training Provider Verification
   clarinet deploy training-provider-verification

   # 2. Curriculum Management
   clarinet deploy curriculum-management

   # 3. Employee Progress
   clarinet deploy employee-progress

   # 4. Skill Certification
   clarinet deploy skill-certification

   # 5. Performance Measurement
   clarinet deploy performance-measurement
   \`\`\`

### Basic Usage

#### For Training Providers:
1. Register as a training provider
2. Wait for admin verification
3. Create curricula and courses
4. Monitor student progress

#### For Companies:
1. Enroll employees in training programs
2. Track progress and completion
3. View performance analytics
4. Manage certifications

#### For Employees:
1. View available training programs
2. Track personal progress
3. Complete assessments
4. Earn certifications

## Contract Functions

### Training Provider Verification
- \`register-provider\`: Register a new training provider
- \`verify-provider\`: Verify a provider (admin only)
- \`get-provider\`: Get provider information
- \`is-provider-verified\`: Check verification status

### Curriculum Management
- \`create-curriculum\`: Create a new curriculum
- \`add-course\`: Add course to curriculum
- \`get-curriculum\`: Get curriculum details
- \`deactivate-curriculum\`: Deactivate curriculum

### Employee Progress
- \`enroll-employee\`: Enroll employee in curriculum
- \`update-course-progress\`: Update course progress
- \`complete-enrollment\`: Mark enrollment as complete
- \`get-enrollment\`: Get enrollment details

### Skill Certification
- \`submit-assessment\`: Submit skill assessment
- \`issue-certification\`: Issue certification
- \`revoke-certification\`: Revoke certification
- \`is-certification-valid\`: Check certification validity

### Performance Measurement
- \`record-performance-metrics\`: Record performance data
- \`get-curriculum-analytics\`: Get curriculum analytics
- \`get-employee-performance\`: Get employee performance
- \`calculate-effectiveness-score\`: Calculate effectiveness

## Data Models

### Provider
- ID, owner, name, description, website
- Verification status and registration block

### Curriculum
- ID, provider, title, description, category
- Difficulty level, duration, creation block

### Course
- ID, curriculum, title, description
- Order index, duration, required status

### Enrollment
- ID, employee, curriculum, enrollment block
- Status, progress percentage, completion block

### Certification
- ID, employee, curriculum, skill name
- Level, score, issued block, expiration

### Performance Metrics
- Completion time, engagement score
- Knowledge retention, practical application
- Overall satisfaction, evaluator

## Security Considerations

- Contract owner privileges for provider verification
- Authorization checks for sensitive operations
- Input validation for all parameters
- Protection against duplicate registrations
- Secure certification issuance process

## Future Enhancements

- Integration with external learning management systems
- Advanced analytics and reporting
- Gamification features
- Multi-language support
- Mobile application integration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

