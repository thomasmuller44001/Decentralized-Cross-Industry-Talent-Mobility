# Decentralized Cross-Industry Talent Mobility Platform

A blockchain-based talent mobility system built on Stacks using Clarity smart contracts. This platform enables verified skill certification, career pathway mapping, opportunity matching, and transition support across different industries.

## 🌟 Features

### Core Contracts

1. **Individual Verification Contract** (`individual-verification.clar`)
    - Validates worker identities using cryptographic verification
    - Maintains verification status and authorized verifier network
    - Provides tamper-proof identity validation

2. **Skill Certification Contract** (`skill-certification.clar`)
    - Records verified capabilities across industries
    - Tracks proficiency levels and certification dates
    - Supports skill expiration and renewal

3. **Career Pathway Contract** (`career-pathway.clar`)
    - Maps skill transferability between sectors
    - Provides difficulty scores and success rates
    - Generates personalized pathway recommendations

4. **Opportunity Matching Contract** (`opportunity-matching.clar`)
    - Connects talent with cross-industry roles
    - Tracks application status and match scores
    - Enables employer-candidate interactions

5. **Transition Support Contract** (`transition-support.clar`)
    - Manages career change assistance programs
    - Facilitates mentorship assignments
    - Tracks progress and completion rates

## 🚀 Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) for local development
- [Stacks CLI](https://docs.stacks.co/docs/cli) for deployment
- Node.js 16+ for running tests

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd talent-mobility-platform
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Initialize Clarinet project:
   \`\`\`bash
   clarinet new talent-mobility
   cd talent-mobility
   \`\`\`

4. Copy contract files to the contracts directory:
   \`\`\`bash
   cp ../contracts/*.clar contracts/
   \`\`\`

### Running Tests

Execute the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Run specific test files:
\`\`\`bash
npm test individual-verification.test.js
npm test skill-certification.test.js
npm test career-pathway.test.js
\`\`\`

### Local Development

1. Start Clarinet console:
   \`\`\`bash
   clarinet console
   \`\`\`

2. Deploy contracts:
   \`\`\`clarity
   (contract-deploy .individual-verification individual-verification)
   (contract-deploy .skill-certification skill-certification)
   (contract-deploy .career-pathway career-pathway)
   (contract-deploy .opportunity-matching opportunity-matching)
   (contract-deploy .transition-support transition-support)
   \`\`\`

## 📋 Usage Examples

### Verify an Individual

\`\`\`clarity
;; Add a verifier
(contract-call? .individual-verification add-verifier 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC)

;; Verify an individual
(contract-call? .individual-verification verify-individual
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
0x1234567890abcdef1234567890abcdef12345678)
\`\`\`

### Certify Skills

\`\`\`clarity
;; Add a certifier
(contract-call? .skill-certification add-certifier 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC)

;; Certify a skill
(contract-call? .skill-certification certify-skill
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"JavaScript Programming"
"Technology"
u85
none)
\`\`\`

### Create Career Pathway

\`\`\`clarity
;; Add an analyst
(contract-call? .career-pathway add-analyst 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC)

;; Create a pathway
(contract-call? .career-pathway create-pathway
"Technology"
"Healthcare"
(list "Problem Solving" "Communication" "Leadership")
u75
u24
u85)
\`\`\`

## 🏗️ Architecture

### Contract Dependencies

\`\`\`
individual-verification (base)
↓
skill-certification
↓
career-pathway
↓
opportunity-matching
↓
transition-support
\`\`\`

### Data Flow

1. **Identity Verification**: Users get verified through authorized verifiers
2. **Skill Certification**: Verified users can have skills certified by authorized certifiers
3. **Pathway Analysis**: Analysts create pathways mapping skill transferability
4. **Opportunity Matching**: Employers post opportunities, users apply with match scores
5. **Transition Support**: Users enroll in support programs with mentorship

## 🔒 Security Features

- **Role-based Access Control**: Different authorization levels for verifiers, certifiers, analysts, employers, and coordinators
- **Identity Verification**: Cryptographic identity validation before skill certification
- **Immutable Records**: All certifications and verifications are permanently recorded
- **Authorized Operations**: Critical functions require proper authorization

## 🧪 Testing

The platform includes comprehensive test coverage:

- **Unit Tests**: Individual contract function testing
- **Integration Tests**: Cross-contract interaction testing
- **Error Handling**: Comprehensive error condition testing
- **Authorization Tests**: Role-based access control validation

### Test Structure

\`\`\`
tests/
├── individual-verification.test.js
├── skill-certification.test.js
├── career-pathway.test.js
├── opportunity-matching.test.js
└── transition-support.test.js
\`\`\`

## 📊 Contract Functions

### Individual Verification
- \`add-verifier\`: Add authorized verifier
- \`verify-individual\`: Verify user identity
- \`revoke-verification\`: Revoke verification
- \`is-verified\`: Check verification status

### Skill Certification
- \`add-certifier\`: Add authorized certifier
- \`certify-skill\`: Certify user skill
- \`update-skill-proficiency\`: Update skill level
- \`get-user-skill\`: Retrieve skill details

### Career Pathway
- \`add-analyst\`: Add authorized analyst
- \`create-pathway\`: Create career pathway
- \`recommend-pathway\`: Recommend pathway to user
- \`get-pathway\`: Retrieve pathway details

### Opportunity Matching
- \`add-employer\`: Add authorized employer
- \`post-opportunity\`: Post job opportunity
- \`apply-for-opportunity\`: Apply for job
- \`update-application-status\`: Update application

### Transition Support
- \`add-coordinator\`: Add program coordinator
- \`create-support-program\`: Create support program
- \`enroll-in-program\`: Enroll in program
- \`assign-mentor\`: Assign mentor to user

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Links

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/docs/clarity/)
- [Clarinet Documentation](https://github.com/hirosystems/clarinet)
  \`\`\`
