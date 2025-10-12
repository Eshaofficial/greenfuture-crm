# 🌿 GreenFuture CRM  
### Salesforce-Based Carbon Credit & Sustainability Partnership Management System  

---

## 📘 Project Overview  
**GreenFuture CRM** is a Salesforce-powered Customer Relationship Management (CRM) platform designed to help organizations manage sustainability initiatives, carbon credit lifecycles, and eco-partnerships.  

It centralizes **projects**, **partners**, and **carbon credits**, automates **approval and trading workflows**, integrates **real-time data sources**, and provides transparent **impact dashboards** — empowering companies to achieve **Net Zero** with accountability.  

---

## 🏭 Industry Focus  
**Climate Tech | Environmental Sustainability | Renewable Energy**

---

## 🧑‍💼 Target Users  
- Corporate Sustainability Teams (Net-Zero Programs)  
- NGOs managing carbon offset projects (Tree Plantation, Recycling, Renewable Energy)  
- Carbon Credit Buyers & Investors  
- Government Auditors & Compliance Officers  
- Sustainability Consultants & Vendors  

---

## 🧩 Problem Statement  
Organizations striving for Net Zero face challenges in tracking sustainability projects, managing carbon credits, ensuring compliance, and demonstrating impact transparently.  

**Key Issues:**
- Disparate systems for project tracking and partner collaboration  
- Manual approval and compliance management  
- Limited visibility into credit issuance and expiry  
- Lack of transparency in credit trading  
- Cumbersome impact reporting and audit tracking  

**Solution – GreenFuture CRM on Salesforce:**  
- Centralizes all sustainability and credit data.  
- Automates the entire carbon credit lifecycle.  
- Integrates with external APIs and systems for real-time carbon pricing.  
- Provides dashboards and analytics for transparent reporting.  

---

## 🧠 Core Use Cases

### 🟢 Lead Management
- Capture sustainability leads from web, NGO, or campaign forms.  
- Assign leads automatically based on region/project type.  
- Qualify leads using a custom **Green Interest Score**.

### 🟢 Project Management
- Manage projects from *Proposed → Verified → Approved → Active → Completed*.  
- Track budgets, partners, and impact metrics.  
- Automate audit and certification stage tracking.

### 🟢 Carbon Credit Trading
- Automate credit creation from completed projects.  
- Manage issuance, sale, and retirement with audit logs.  
- Prevent expired credits from resale using validation rules.

### 🟢 Partner & Compliance Management
- Maintain sustainability partner directory with certifications.  
- Automate compliance renewals and verification workflows.  
- Generate annual compliance & sustainability reports.

### 🟢 Engagement & Notifications
- Send alerts for expiring credits or new projects.  
- Automated email/SMS updates after credit purchase.  
- Personalized dashboards for buyers showing sustainability contributions.

### 🟢 Reporting & Dashboards
- Credits Issued vs Sold  
- Partner Performance  
- Buyer Contribution Reports  
- Real-time Sustainability Scoreboard (emissions reduced, trees planted)  

---

## ⚙️ System Architecture & Components  

| Phase | Component | Description |
|-------|------------|-------------|
| **1** | Problem Understanding | Define business needs & user personas |
| **2** | Org Setup & Configuration | Users, Roles, Profiles, OWD, Permission Sets |
| **3** | Data Model | Custom Objects: `SustainabilityProject__c`, `CarbonCredit__c`, `Partner__c`, `ProjectPartner__c` |
| **4** | Process Automation | Validation Rules, Flows, Approvals, Workflow Emails |
| **5** | Apex Development | Triggers, Batch, Queueable, Scheduler, Future Callouts |
| **6** | UI (LWC) | `projectDashboard` Lightning Web Component |
| **7** | Integrations | Platform Events, CDC, Salesforce Connect, Remote Site Settings |
| **8** | Data & Deployment | Data Import Wizard, Data Loader, SFDX CLI Deployment |
| **9** | Reporting & Security | Reports, Dashboards, FLS, IP Ranges, Audit Trail |

---

## 💻 Salesforce Implementation Details  

### ⚡ Objects & Relationships
- `SustainabilityProject__c` – core project entity  
- `CarbonCredit__c` – linked to project via lookup  
- `Partner__c` – manages external collaborations  
- `ProjectPartner__c` – junction object for many-to-many relationships  

### ⚡ Automations
- **Validation Rules:** Enforce data accuracy  
- **Approval Processes:** Project → Approved  
- **Flows:** Auto-create Tasks & Notifications  
- **Workflows:** Email Alerts on Project Approval  

### ⚡ Apex Features
- `CarbonCreditManager.cls` → auto-creates credits  
- `SustainabilityProjectTriggerHandler.cls` → trigger logic separation  
- `ExpireCreditsBatch.cls` → batch expiry automation  
- `NotifyQueueable.cls` → async notifications  
- `NightlyCreditScheduler.cls` → daily batch scheduler  
- `CarbonPriceService.cls` → external API callout  

### ⚡ Integrations
- **Platform Events:** `Project_Update__e` for real-time updates  
- **Change Data Capture (CDC):** Projects & Credits  
- **Salesforce Connect:** External carbon price OData feed  
- **Remote Site Settings:** Secure API communication  

### ⚡ Reporting & Analytics
- Reports: Carbon Credits (Planned, Sold, Retired)  
- Dashboards: Sustainability Metrics, Partner Performance  

---

## 🧑‍🔬 Setup & Deployment Guide  

### Prerequisites
- Salesforce Developer Edition (or Sandbox)  
- Salesforce CLI (SFDX)  
- VS Code with Salesforce Extensions  

### Commands

```bash
# Authenticate to Dev Hub
sfdx auth:web:login -d -a DevHub

# Create Scratch Org
sfdx force:org:create -f config/project-scratch-def.json -a GreenFutureScratch -s -d 7

# Push Source
sfdx force:source:push -u GreenFutureScratch

# Assign Permission Sets
sfdx force:user:permset:assign -n CarbonCreditAdmin

# Import Sample Data (if data folder exists)
sfdx force:data:tree:import -f data/sample-plan.json

# Run Apex Tests
sfdx force:apex:test:run --resultformat human --wait 10

# Open Org
sfdx force:org:open

