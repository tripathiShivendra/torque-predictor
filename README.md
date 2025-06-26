# ⚙️ Motor Torque Prediction App (MATLAB + ANN)

This application predicts the torque of DC and Induction motors using Artificial Neural Networks (ANN) in MATLAB. It is designed to work without physical torque sensors by using easily measurable electrical inputs like voltage and current.

---

## 📦 Prerequisites

- MATLAB R2022 or later
- Neural Network Toolbox
- All project files must be in a single folder

---

## 📁 Project Files

- `projectapp.mlapp` – Main App Designer GUI
- `InductionMotorTorqueNet.mat` – Pre-trained ANN model for Induction Motor
- `DCMotorTorquNet.m` – DC Motor torque calculation code (optional)
- `README.md` – Instructions to run and troubleshoot the app

---

## 🚀 How to Run

1. Open MATLAB
2. Set the Current Folder to your project folder:
   ```matlab
   cd('C:\Path\To\UnzippedFolder')
3. Open projectapp.mlapp in App Designer
4. Click the green Run button

---

## ❗ Troubleshooting

- **Model Not Found Error**  
  Ensure that `InductionMotorTorqueNet.mat` is present in the same folder as `projectapp.mlapp`. The app loads this file at runtime for Induction Motor torque prediction.

- **App Not Opening**  
  - Make sure you're using **MATLAB R2022 or later**.
  - Check that all files are properly **extracted** into a single folder.
  - Ensure the **Neural Network Toolbox** is installed (included by default in most MATLAB installations).

- **DC Motor Prediction Not Responding**  
  - Verify that the correct script (`DCMotorTorquNet.m`) is accessible and doesn't throw errors when called.

---

## 🛠 Built With

- **MATLAB** – Used for app development and running ANN models
- **App Designer** – GUI creation for the user interface
- **Neural Network Toolbox** – For training and running ANN-based torque prediction

---

## 👨‍💻 Author Notes

This project was developed as part of an academic exploration to estimate motor torque using ANN models instead of hardware-based torque sensors. The goal was to reduce reliance on expensive sensors by leveraging electrical input data (voltage & current) and applying data-driven predictive techniques.

AI tools like ChatGPT were used to guide backend

