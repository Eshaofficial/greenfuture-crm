<div align="center">

# 🌍✨ **GreenFuture CRM**  
### _Carbon Credit & Sustainability Partnership Management System_  
**Built on Salesforce (Admin + Developer Capstone Project)**  

<img src="https://img.shields.io/badge/Salesforce-Platform-blue?style=for-the-badge&logo=salesforce"/>  
<img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge"/>  
<img src="https://img.shields.io/badge/Version-1.0.0-brightgreen?style=for-the-badge"/>  
<img src="https://img.shields.io/badge/License-Educational-lightgrey?style=for-the-badge"/>  

---

</div>

## 🪴 **Overview**
**GreenFuture CRM** is a Salesforce-powered platform that enables organizations to manage sustainability initiatives, automate carbon credit lifecycle, integrate real-time data sources, and ensure transparency in achieving **Net Zero** goals.  

This system provides end-to-end visibility across **projects**, **partners**, and **carbon credits**, with automation, analytics, and security built into Salesforce.

---

## 🌱 **Industry**
> ♻️ _Climate Tech_ | 🌞 _Renewable Energy_ | 🌎 _Environmental Sustainability_

---

## 👥 **Target Users**
- 🌿 Corporate Sustainability Teams  
- 🌍 NGOs & Environmental Partners  
- 💼 Carbon Credit Buyers & Investors  
- 🏛️ Government Auditors  
- 🧩 Sustainability Consultants  

---

## 🧠 **Problem Statement**
Organizations aiming for **Net Zero** struggle with fragmented tools, manual compliance tracking, and non-transparent carbon credit management.

###   Challenges:
- Disconnected project & partner tracking  
- No automation in credit lifecycle  
- Inefficient approval & audit processes  
- Manual sustainability reporting  
- Lack of transparency in credit trading  

### ✅ Solution:
**GreenFuture CRM** automates sustainability workflows, unifies credit and partner data, integrates with external APIs, and visualizes impact via dashboards.

---

## ⚡ **Core Use Cases**

| Function | Highlights |
|-----------|-------------|
| 🌿 **Lead Management** | Auto-capture sustainability leads & assign by region/project type. |
| 🌳 **Project Management** | Track lifecycle: Proposed → Verified → Approved → Active → Completed. |
| 💰 **Carbon Credit Trading** | Auto-create credits, manage issuance & expiry validation. |
| 🤝 **Partner & Compliance** | Automate certification renewals & audit tracking. |
| 📬 **Engagement & Alerts** | Auto emails/SMS on purchase, expiry, or new projects. |
| 📊 **Dashboards & Reports** | Visualize credits, performance, impact & buyer contribution. |

---

## 🧩 **Architecture Overview**

| Phase | Component | Description |
|:------|:-----------|:-------------|
| 1️⃣ | Problem Understanding | Business need & personas |
| 2️⃣ | Org Setup | Users, Roles, Profiles, OWD |
| 3️⃣ | Data Model | Custom objects for Projects, Credits, Partners |
| 4️⃣ | Process Automation | Flows, Approvals, Workflows |
| 5️⃣ | Apex Programming | Triggers, Batch, Queueable, Scheduler |
| 6️⃣ | UI (LWC) | Interactive Dashboard Component |
| 7️⃣ | Integrations | Platform Events, CDC, API Callouts |
| 8️⃣ | Deployment | Data Loader, SFDX, CI/CD Ready |
| 9️⃣ | Reporting & Security | Reports, Dashboards, FLS, IP Controls |

---

## 💻 **Salesforce Implementation**

### 🧱 Objects
`SustainabilityProject__c` | `CarbonCredit__c` | `Partner__c` | `ProjectPartner__c`

### ⚙️ Automation
- ✅ Validation Rules  
- ✅ Approval Processes  
- ✅ Record-Triggered Flows  
- ✅ Workflow Emails  

### 🧩 Apex Classes
| Class | Function |
|-------|-----------|
| `CarbonCreditManager.cls` | Auto-create carbon credits |
| `SustainabilityProjectTriggerHandler.cls` | Clean trigger logic |
| `NotifyQueueable.cls` | Async task notifications |
| `ExpireCreditsBatch.cls` | Expire credits older than 1 year |
| `NightlyCreditScheduler.cls` | Daily scheduler |
| `CarbonPriceService.cls` | @future API callout |

### 🔗 Integrations
- 📡 **Platform Events:** `Project_Update__e`  
- 🔄 **CDC:** Projects & Credits  
- 🌐 **Salesforce Connect:** External Carbon Price Data  
- 🧾 **Remote Site Settings:** Secure HTTP callouts  

### 📈 Reports & Dashboards
- Credits Issued vs Sold  
- Partner Performance Metrics  
- Buyer Contribution Reports  
- Sustainability Scoreboard  

---

## ⚙️ **Setup & Deployment (SFDX)**

```bash
# Authenticate Dev Hub
sfdx auth:web:login -d -a DevHub

# Create Scratch Org
sfdx force:org:create -f config/project-scratch-def.json -a GreenFutureScratch -s -d 7

# Push Source
sfdx force:source:push -u GreenFutureScratch

# Assign Permission Set
sfdx force:user:permset:assign -n CarbonCreditAdmin

# Import Sample Data
sfdx force:data:tree:import -f data/sample-plan.json

# Run Apex Tests
sfdx force:apex:test:run --resultformat human --wait 10

# Open Org
sfdx force:org:open



