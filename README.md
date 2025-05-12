# PPG Analyzer (Legacy MATLAB GUI)

This project contains the legacy MATLAB software for photoplethysmographic (PPG) signal analysis.  
The software includes a GUI developed using MATLAB GUIDE, used to load, filter, and analyze PPG signals collected with an Arduino-based sensor.

## 🧠 Technologies

- MATLAB GUI (GUIDE)
- Signal processing:
  - Butterworth band-pass filter
  - Wavelet transform
- Data input from Arduino-based Pulse Sensor SEN-11574
- Supported formats: `.mat`, `.txt`

## 📁 Folder Structure

- `programfiles/`: temporary variables and intermediate data  
- `processeddata/`: per-signal analysis results  
- `data/`: example legacy PPG signal recordings (see separate [README](data/README.md))

## 📝 Citation and Official Registration

### 📄 Publication:
Karaseva E., *Development of a hardware-software measurement system for the collection, detection, and processing of photoplethysmograms*,  
**Journal of Optical Technology**, Vol. 87, No. 1, 2020.  
[DOI: 10.1364/JOT.87.000036](https://doi.org/10.1364/JOT.87.000036)

### 🛡️ Registered Software (Russia):
**Title**: Data processing software for telediagnostic sensor  
**Registration No.**: RU 2020614950  
**Date**: April 29, 2020  
**Rightsholder**: Pavlov Institute of Physiology, Russian Academy of Sciences  
[Link on ФИПС (Federal Institute of Industrial Property)](https://fips.ru/registers-web/action?regnum=2020614950)

## 🧪 Origin and Use

This project began as part of an internship at **ESIEE Paris** (2018), focusing on remote diagnostics using pulse sensors.  
It was later extended and used at the **Pavlov Institute of Physiology**, Russian Academy of Sciences.  
I was a co-author of the software; the rightsholder is the Pavlov Institute of Physiology.

## ⚠️ Legacy Notice

This software is no longer under active development. It is preserved here for documentation, academic reference, and historical interest.

## 📜 License

Academic legacy project. Available for non-commercial use with attribution.
