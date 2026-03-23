# UART Implementation in Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Simulator](https://img.shields.io/badge/Simulator-Icarus%20Verilog-green)
![Waveform](https://img.shields.io/badge/Waveform-GTKWave-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

A fully functional **Universal Asynchronous Receiver Transmitter (UART)** designed in Verilog HDL featuring a Baud Rate Generator, FSM-based Transmitter, Receiver with 16x oversampling, and Even Parity — verified through Icarus Verilog simulation and GTKWave waveform analysis.

---

## Specifications

| Parameter | Value |
|---|---|
| Clock Frequency | 50 MHz |
| Baud Rate | 9600 bps |
| Oversampling | 16x (RX side) |
| Parity | Even |
| Data Bits | 8 (LSB first) |
| Stop Bits | 1 |
| Baud Tick Frequency | 153,600 Hz (9600 × 16) |

---

## Architecture

![UART Architecture](waveform/uart_architecture.png)

---

## Frame Format
| START | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | PARITY | STOP |

---

## Module Overview

| Module | File | Description |
|---|---|---|
| Baud Rate Generator | `src/baud_rate_gen.v` | Generates 153,600 Hz ticks (DIVISOR = 325) |
| UART Transmitter | `src/uart_tx.v` | FSM: IDLE→START→DATA→PARITY→STOP, 16 ticks/bit |
| UART Receiver | `src/uart_rx.v` | 16x oversampling, center sampling, parity check |
| Top Level | `src/uart_top.v` | Connects all submodules, parameterized DIVISOR |
| Testbench | `tb/uart_tb.v` | Loopback test, 3 byte transmission |

**Test Cases (Loopback — TX connected to RX):**

| Data | Binary | Parity | Result |
|---|---|---|---|
| 0x55 | 0101 0101 | 0 | ✅ PASS |
| 0xAA | 1010 1010 | 0 | ✅ PASS |
| 0xA5 | 1010 0101 | 0 | ✅ PASS |

> `DIVISOR = 5` used in testbench for fast simulation. Real design uses `DIVISOR = 325`.

---

## Tools Used

| Tool | Purpose |
|---|---|
| Verilog HDL | Hardware description |
| Icarus Verilog | Simulation |
| GTKWave | Waveform analysis |


---




