# Numerically Controlled Oscillator (NCO)

A versatile FPGA-based Numerically Controlled Oscillator (NCO) capable of generating multiple waveforms (sine, cosine, triangular, sawtooth, sinc, square) and a wide range of frequencies. The design targets learning, experimentation, and small FPGA projects that require digitally generated analog-like waveforms and a simple UI (keypad + LCD) for frequency and waveform selection.

Report: report.pdf

## Stack
- Language(s): SystemVerilog
- Target: FPGA (examples in code reference Intel/Altera devices: MAX 10 and Cyclone V)
- Simulation / Synthesis tools: ModelSim / Questa (simulation), Intel Quartus Prime (synthesis and device-specific IP like PLL)

## Key features
- Multiple waveform generation using lookup tables (LUT) in WaveGen
- Frequency selection and scaling (mHz, Hz, KHz, MHz) via keypad input and FrequencyDivider
- On-board UI using a 4x4 keypad and a character LCD (LcdInterface + Keypad)
- Simple state machine to guide user interaction and flow (StateMachine)
- Example PLL instantiations for clock generation (PLL for MAX 10 and a commented Cyclone V option)
- Output sample stream available on `wave_out` and a DAC clock provided by `clk_dac`

## Repository layout
```
LICENSE               # Project license
report.pdf            # Project report (design, results, diagrams)
Modules/              # SystemVerilog modules for the NCO and UI
  FrequencyDivider.sv # frequency computation and low/high clock divider
  FunctionGenerator.sv # top-level module that wires submodules together
  LcdInterface.sv     # character LCD controller and display logic
  StateMachine.sv     # user interaction state machine
  WaveGensv.sv        # waveform lookup tables and output sequencing
  keypad.sv           # 4x4 keypad scanner and input processing
```

How it fits together:
- FunctionGenerator.sv is the top-level module that instantiates the StateMachine, LcdInterface, Keypad, FrequencyDivider, WaveGen and PLL primitives.
- The StateMachine controls UI flow (select waveform, display selection, select frequency, display frequency, then enable generation).
- Keypad scans a 4x4 matrix and provides waveform and frequency digits to FrequencyDivider and display bytes to LcdInterface.
- FrequencyDivider computes the desired frequency scaling and generates a clock (clk_out) that gates the WaveGen LUT stepping.
- WaveGen holds LUTs for several waveform shapes and steps through the selected LUT at the generated rate; wave_out is the 8-bit sample output.

## Top-level signals
- Inputs: clk_50MHz (main reference clock), rst, keypad row lines
- Outputs: col (keypad column), data/lcd_e/lcd_rs/lcd_rw (LCD signals), wave_out (8-bit waveform samples), clk_dac
- Top module: `FunctionGenerator` (Modules/FunctionGenerator.sv)

## How to simulate
1. Clone the repository:

```bash
git clone https://github.com/snevindsouza/Numerically_Controlled_Oscillator.git
cd Numerically_Controlled_Oscillator
```

2. Choose a simulator (ModelSim/Questa is recommended for SystemVerilog features used here).

3. Compile and run a simulation (example with ModelSim/Questa):

```bash
# compile
vlog Modules/*.sv
# start simulation using the top-level module
vsim FunctionGenerator
# run simulation (use an appropriate testbench or drive clocks/rows/rst manually)
run -all
```

Notes:
- The repository does not include a testbench. Create a simple testbench that instantiates `FunctionGenerator`, toggles `clk_50MHz`, `clk_50MHz`-derived PLL outputs (or replace PLL with simple clock generators), asserts `rst`, and drives keypad `row` inputs to simulate presses.
- For faster iteration you can stub out the PLL instantiation in FunctionGenerator (or replace with clock generators in a testbench) to avoid vendor IP dependency during simulation.

## How to synthesize / program
- This project targets FPGA devices (examples in code reference MAX 10 / Cyclone V). Use Intel Quartus Prime for synthesis and for generating vendor PLL IP if you want to use the included PLL instantiations.
- Steps (high level):
  1. Create a new Quartus project and add Modules/*.sv to the project.
  2. Provide pin assignments for your board (keypad rows/cols, LCD data/ctrl, wave_out to DAC pins, clocks, reset).
  3. Generate the appropriate PLL IP in the Quartus IP Catalog (or use the provided PLL instantiation if it matches your device).
  4. Compile and program the FPGA.

## Files of interest
- Modules/FunctionGenerator.sv — top-level wiring and PLL instantiation
- Modules/WaveGensv.sv — LUTs for sine, cosine, triangular, sinc, sawtooth, square
- Modules/FrequencyDivider.sv — converts user-entered digits into frequency scaling and produces clk_out
- Modules/LcdInterface.sv — drives a character LCD to show menu, selection, and frequency
- Modules/keypad.sv — keypad scanner and input handler

## License
This repository includes a LICENSE file — see LICENSE for details.

## Report
The design report and project write-up are included as `report.pdf` in the repository.

## Contributing
- If you want to add features, please open an issue describing the change you propose and attach a short patch or fork and submit a pull request.
- Suggested improvements: add an automated testbench, add a README diagram of pin assignments, parameterize LUT depth and sample width, add fixed-point amplitude control or calibration.

## Contact
Repository owner: snevindsouza

