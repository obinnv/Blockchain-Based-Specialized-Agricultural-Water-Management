# Blockchain-Based Specialized Agricultural Water Management

This decentralized platform enables efficient monitoring and management of agricultural water resources through transparent tracking, rights verification, and implementation of conservation measures. By leveraging blockchain technology, the system provides immutable records of water usage while incentivizing sustainable irrigation practices.

## System Overview

The Blockchain-Based Specialized Agricultural Water Management platform consists of four primary smart contracts:

1. **Farm Registration Contract**: Documents participating agricultural operations and their characteristics
2. **Water Source Verification Contract**: Validates water access rights and entitlements
3. **Usage Monitoring Contract**: Tracks irrigation water consumption with tamper-proof records
4. **Efficiency Improvement Contract**: Coordinates implementation of water conservation techniques

## Getting Started

### Prerequisites

- Node.js (v16.0+)
- Blockchain development environment (Truffle/Hardhat)
- Web3 library
- IoT sensor integration capability
- Digital wallet (MetaMask or similar)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/agricultural-water-management.git
   cd agricultural-water-management
   ```

2. Install dependencies
   ```
   npm install
   ```

3. Compile smart contracts
   ```
   npx hardhat compile
   ```

4. Deploy to test network
   ```
   npx hardhat run scripts/deploy.js --network testnet
   ```

## Smart Contract Architecture

### Farm Registration Contract
Records comprehensive details about participating farms including location, size, crop types, soil characteristics, and irrigation infrastructure. Each registered farm receives a unique digital identifier that links to all water management activities.

### Water Source Verification Contract
Validates and documents water rights allocations, including surface water permits, groundwater entitlements, and seasonal allowances. Creates an immutable record of legitimate water access to prevent unauthorized usage.

### Usage Monitoring Contract
Integrates with IoT sensors to track actual water consumption across registered farms. Records withdrawal amounts, timing, and purpose with tamper-proof blockchain entries. Supports comparison against allocated rights and environmental benchmarks.

### Efficiency Improvement Contract
Facilitates the implementation and verification of water conservation measures including drip irrigation, soil moisture monitoring, weather-based scheduling, and crop rotation strategies. Tracks efficiency improvements and manages incentive distribution.

## Usage Examples

### Registering a Farm
```javascript
const farmRegistry = await FarmRegistrationContract.deployed();
await farmRegistry.registerFarm(
  "Sunshine Valley Orchards",
  [38.5816, -121.4944], // coordinates
  120, // acres
  ["almonds", "peaches"],
  "loam",
  ["drip", "micro-sprinkler"],
  "2022-07-15" // registration date
);
```

### Recording Water Usage
```javascript
const usageMonitor = await UsageMonitoringContract.deployed();
await usageMonitor.recordWaterUsage(
  "FARM-SVQ-1234", // farm ID
  "WSRC-GW-5678", // water source ID
  24500, // gallons used
  1714834800, // timestamp (Unix format)
  "irrigation",
  "IoT-SENSOR-WF-789" // sensor ID
);
```

## Features

- **Transparent Allocation**: Creates verifiable records of water rights and usage
- **Consumption Monitoring**: Tracks actual water usage with tamper-proof ledger entries
- **Conservation Incentives**: Rewards implementation of water-saving techniques
- **Regulatory Compliance**: Simplifies reporting and verification for water authorities
- **Data-Driven Decisions**: Provides analytics for optimizing irrigation practices
- **Dispute Resolution**: Maintains immutable history for resolving water access conflicts

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or support, please contact: support@agwatermanagement.org
