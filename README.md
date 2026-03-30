# UART Verification Environment (SystemVerilog) – Advanced Features

## Overview

This project extends a basic UART verification environment with advanced verification techniques including SystemVerilog Assertions (SVA), functional coverage, and error injection. The goal is to achieve higher verification confidence, better bug detection, and improved stimulus quality.

## Features

* Protocol checking using SVA
* Functional coverage for baud rates and data patterns
* Error injection for robustness testing
* Self-checking scoreboard integration
* Randomized stimulus with corner-case exploration

---

## Assertions (SVA)

### Purpose

Assertions are used to validate protocol correctness during simulation by checking timing and signal behavior.

### Implemented Checks

* Start bit validation
* Stop bit validation
* Data stability during transmission
* Glitch detection on TX line

### Integration

* Assertions are implemented in a separate module
* Connected to the UART interface
* Automatically triggered during simulation

### Benefits

* Early bug detection
* Immediate protocol violation reporting
* Improves design reliability

---

## Functional Coverage

### Purpose

Functional coverage ensures that all important scenarios and corner cases are exercised.

### Coverage Points

* Baud rate variations
* Data patterns:

  * All zeros (`0x00`)
  * All ones (`0xFF`)
  * Alternating patterns (`0xAA`, `0x55`)
  * Random values

### Cross Coverage

* Baud rate × data pattern combinations

### Sampling

* Coverage is sampled dynamically during simulation
* Typically triggered from monitor or scoreboard

### Benefits

* Measures verification completeness
* Identifies untested scenarios
* Guides stimulus refinement

---

## Error Injection

### Purpose

Error injection tests robustness of the UART design under faulty conditions.

### Supported Error Types

#### Parity Error

* Incorrect parity bit is transmitted
* Tests receiver’s parity error detection

#### Framing Error

* Stop bit is forced low instead of high
* Simulates improper frame termination

#### Noise Injection

* Random bit flips during transmission
* Mimics line noise or signal corruption

### Implementation

* Integrated into driver
* Controlled via randomized variables
* Can be extended to controlled scenarios

### Benefits

* Improves fault tolerance testing
* Validates error handling logic
* Simulates real-world conditions

---

## Integration Flow

1. Generator creates randomized transactions
2. Driver transmits data with optional error injection
3. DUT processes incoming UART data
4. Monitor captures received data
5. Assertions check protocol correctness in parallel
6. Coverage collects scenario statistics
7. Scoreboard validates expected vs actual data

---

## Simulation Flow

* Reset applied
* Stimulus generation begins
* Assertions actively monitor protocol
* Coverage is sampled continuously
* Errors injected randomly
* Results printed via scoreboard

---

## Design Assumptions

* 8-bit data width
* Single stop bit
* Parity enabled in extended driver
* Fixed baud timing (configurable variable)

---

## Limitations

* No full UVM framework
* No dynamic baud detection
* Limited protocol variations
* Basic reference model

---

## Possible Extensions

* Full UVM agent and sequences
* Configurable parity modes (even/odd/none)
* Multiple stop bits support
* Adaptive baud rate generator
* Formal verification integration
* Coverage-driven verification closure

---

## File Structure

* `uart_if.sv` : Interface
* `uart_transaction.sv` : Transaction class
* `uart_driver_err.sv` : Driver with error injection
* `uart_monitor.sv` : Monitor
* `uart_scoreboard.sv` : Scoreboard
* `uart_assertions.sv` : SVA module
* `uart_coverage.sv` : Coverage model
* `uart_env.sv` : Environment
* `tb.sv` : Testbench

---

## Requirements

* SystemVerilog simulator (VCS, Questa, Xcelium)
* SVA and coverage support enabled

---

## Verification Goals

* Achieve high functional coverage
* Detect protocol violations using assertions
* Validate robustness via error injection
* Ensure correct data transmission and reception

---

## Free for educational and learning purposes
