# General
HALE-Specific-Flight-Control-Design-Toolbox was developed by Facebook to assist in flight control system design for solar powered unmanned High Altitude Long Endurance (HALE) airplanes.

## Project Overview
The HALE flight control laws design toolbox was developed to assist HALE aircraft's autopilot system designers in designing the control and measurement system architecture and in tuning the longitudinal and lateral/directional gains and parameters of the control laws such that some stability, performance and robustness criteria are satisfied. the tool consists of the following three modules:

1. **Module 1** is to build and prepare the aircraft model and to save it into a .mat file for further analysis. To use Module 1 run **“utilities/getAquilaModel_ModelGeneration.m”**. The script will then generate a .mat file containing the aircraft model information which serves as the input to the Module 2 script (see below). The .mat file name must also be provided for the Module 3 in the “OptConfigSetup.m” script.
2. **Module 2** is for open loop flight dynamic analysis, stability and sensitivity analysis over the speed and altitude nominal range, sensor/servo location determination and for preliminary control laws structure determination (especially for the problematic flexible modes at higher altitudes). To use Module 2 run **“utilities/AquilaFltDynAnalysis.m”**.
3. **Module 3** is for control laws gain and parameters tuning over the designated flight envelop. The main script for Module 3 is **“utilities/OptimiseAquilaClaws_Main.m”**. Please see the "Detailed Operation and Execution" section of the Module 3 description chapter for the details.



## References
Check out the Facebook research website, https://research.fb.com/category/connectivity/ .  The following conference paper were prepared with this toolbox:
- Bolandhemmat, H., Flight Control System Design for a High Altitude, Long Endurance Airplane: Sensor Distribution and Flexible Modes Control

## Requirements
This project was developed under Matlab/Simulink version 2017A.  It requires the following toolboxes:
* Aerospace Blockset (replace the "Rad to Deg" unit converters of the simulink models by R2D regular angle unit conversion blocks to remove the dependencies on this toolbox)
* Control Systems Toolbox
* Simulink
* Parallel Computing Toolbox (optional): Optimization can be very slow, so it is beneficial to install and run on a server with many cores, taking advantage of parallelization
* Aircraft state space model in the toolbox prescribed format (from ASWING or any other modeling tools)

## Description
- A comprehensive description of the toolbox and its functionality is given in the included HALE Specific Flight Control Laws Design Toolbox Manual.html toolbox manual
-

## Examples
- Set the UseCustomModel flag to 1 in "utilities/OptimizeAquilaClaws_Discrete_GS.m" and follow the steps to design the preliminary flight control laws for a HALE aircraft (an ASWING ROM model) model provided. Using the sample model, the control design process can be exercised on the toolbox.

## Join the HALE-Specific-Flight-Control-Design-Toolbox community
See the CONTRIBUTING file for how to help out.

## License
By contributing to HALE-Specific-Flight-Control-Design-Toolbox, you agree that your contributions will be licensed
under the LICENSE or COPYING file in the root directory of this source tree.
