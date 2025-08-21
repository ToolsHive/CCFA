# 🕵️‍♂️ Certified Computer Forensic Analyst (CCFA)

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-success?style=for-the-badge&logo=github" alt="Status"/>
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge&logo=open-source-initiative" alt="License"/>
  <img src="https://img.shields.io/badge/Made%20With-PowerShell-darkblue?style=for-the-badge&logo=powershell" alt="Made With PowerShell"/>
  <br/>
  <img src="https://img.shields.io/badge/Focus-Digital%20Forensics-purple?style=for-the-badge&logo=security" alt="Learning Path"/>
  <img src="https://img.shields.io/github/repo-size/ToolsHive/CCFA?style=for-the-badge&color=informational" alt="Repo Size"/>
</p>

Welcome to the Certified Computer Forensic Analyst (CCFA) repository — a curated collection of notes, methodologies, procedures, and resources for mastering digital forensics and preparing for professional forensic analysis in real-world environments.

This repository serves as both a personal knowledge base and a practical toolkit, designed to support learning, research, and reference in the field of computer forensics and cybersecurity investigations.

# 🛠️ Tools and Usage

This repository contains various PowerShell scripts and resources to assist with forensic analysis and digital investigations.  
Each script is self-contained with its own purpose, workflow, and usage details.

## 📂 Scripts

### 🔍 NTFS $MFT & $MFTMirr Analysis (`MFT.ps1`)

This script automates the process of analyzing NTFS **Master File Table ($MFT)** and **$MFTMirr** files using [Eric Zimmerman's MFTECmd](https://ericzimmerman.github.io/).

**Features:**
- Automatically downloads and installs MFTECmd if not already present
- Ensures the tool’s directory is added to the system `PATH`
- Prompts the user to choose between analyzing `$MFT` or `$MFTMirr`
- Accepts user-provided file paths
- Generates structured CSV output for further analysis
- Runs with administrative privileges when required

**Workflow:**

1. **Extract `$MFT` or `$MFTMirr`**  
  Use a forensic imaging tool such as **FTK Imager** to extract the `$MFT` or `$MFTMirr` file from the disk image.

2. **Download the Script**  
  Download [`MFT.ps1`](https://github.com/ToolsHive/CCFA/blob/main/MFT.ps1) from GitHub.

3. **Set Execution Policy**  

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
  > Open **PowerShell (Run as Administrator)** and allow script execution: 

1. **Unblock the file**: 
 
```powershell
Unblock-File .\MFT.ps1
``` 
  > If you downloaded the script, unblock it to avoid security restrictions

1. **Run the script**:
 
```powershell
 ./MFT.ps1
```

6. **Quick One-Liner Execution**

```powershell
iex (iwr "https://raw.githubusercontent.com/ToolsHive/CCFA/refs/heads/main/MFT.ps1")
```
  > Run the script directly from GitHub without downloading


# 🤝 Contributing

This is primarily a personal learning repository, but contributions are always welcome!
Feel free to fork, adapt, or expand the material for your own studies or to help others.

If you’d like to contribute:

1. Fork the repo
2. Create a feature branch `git checkout -b <feature-name>`
3. Commit your changes
4. Open a Pull Request

# ⚖️ License

This project is licensed under the [MIT LICENSE](./LICENSE).