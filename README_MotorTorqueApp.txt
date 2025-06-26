📘 README – How to Run the Motor Torque Prediction MATLAB App

🔧 Prerequisites:
- MATLAB R2022 or later installed.
- Neural Network Toolbox (default in most installations).
- All files must be unzipped into a single folder.

📁 Files Included:
- projectapp.mlapp – Main app file.
- InductionMotorTorqueNet.mat – Pre-trained model for Induction Motor torque prediction.
- DCMotorTorquNet.m – Code for DC Motor torque calculation (if separated).
- README.txt – Instructions to run the app.

🚀 How to Run the App:
1. Open MATLAB.
2. Set the Current Folder to your unzipped project folder:
   - Use File Browser in MATLAB, or
   - Use the command:
     cd('C:\Path\To\UnzippedFolder')
3. Double-click on projectapp.mlapp to open it in App Designer.
4. Click the green Run button at the top of App Designer.

❗Troubleshooting Tips:
- Error: Model Not Found – Ensure InductionMotorTorqueNet.mat is present in the same folder.
- App Not Opening – Check if you’re using MATLAB 2022 or later and if all files are unzipped.
