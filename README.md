# FPGA-Traffic-Light-Controller
FSM-based traffic light controller in Verilog on Spartan-7 FPGA
# FPGA Traffic Light Controller

## Overview
This project implements a traffic light controller using a Finite State Machine (FSM) in Verilog, targeted for FPGA (Spartan-7). The design controls highway and country road signals based on sensor input and timed transitions.

---

## Features
- FSM-based traffic control logic  
- Separate combinational and sequential design  
- Timer-based state transitions  
- Sensor-controlled switching (highway ↔ country road)  
- Synthesizable and FPGA-ready design  

---

## System Description
The controller manages two roads:
- **Highway (default priority)**
- **Country road (activated on demand)**

A sensor input (`x`) detects vehicles on the country road and triggers state transitions.

---

## State Diagram (Concept)
- Highway Green → Highway Yellow → All Red  
- Country Green → Country Yellow → Highway Green  

Each transition is controlled using a delay counter.

---

## Design Details

### Inputs
- `clk` : System clock  
- `clear / rst` : Reset signal  
- `x / sensor` : Vehicle detection input  

### Outputs
- `hwy_light [1:0]` : Highway signal (RED/YELLOW/GREEN)  
- `cntry_light [1:0]` : Country road signal  

---

## Implementation
- Written in **Verilog HDL**  
- FSM implemented using:
  - State register  
  - Next-state logic  
  - Output logic  
- Timer used for delay-based transitions  

---

## Simulation
- Verified using a Verilog testbench  
- Waveforms generated using `$dumpvars`  
- State transitions validated under different sensor conditions  

---

## Tools Used
- Verilog HDL  
- Xilinx Vivado (for synthesis/implementation)  
- GTKWave / simulation tools  

---

## Files
- `traffic_light_ctrl.v` – Main FSM design  
- `tb_traffic.v` – Testbench  
- `wave.vcd` – Simulation waveform (optional)  

---

## How to Run
1. Compile the design and testbench  
2. Run simulation  
3. View waveform using GTKWave or similar tool  

---

## Learning Outcomes
- FSM design for real-time systems  
- Separation of combinational and sequential logic  
- Timing control using counters  
- Hardware-oriented debugging and verification  

---

## Future Improvements
- Multi-road intersection controller  
- Pedestrian signal integration  
- Adaptive timing based on traffic density  
- Integration with sensors (real hardware)

---
