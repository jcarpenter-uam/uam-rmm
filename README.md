# UAM-RMM Tool

An all-in-one, internal Remote Monitoring and Management (RMM) solution.

---

## Table of Contents

- [About The Project](#about-the-project)
- [Core Components](#core-components)
- [Setup](#setup)

---

## About The Project

This project combines several powerful open-source tools to create a comprehensive **Remote Monitoring and Management (RMM)** solution designed for internal company use. It provides functionality for remote access, security monitoring, asset management, and automated script execution, all unified under one system.

---

## Core Components

The UAM-RMM tool integrates the following open-source platforms to provide its core functionality:

Note: This technology stack is under active evaluation and may be subject to change based on ongoing testing and project requirements.

| Tool | Purpose |
| :--- | :--- |
| **RustDesk** | Provides secure and easy-to-use **Remote Desktop** access. |
| **Wazuh** | A robust **Security Information and Event Management (SIEM)** platform for threat detection and compliance. |
| **GLPI** | An IT asset management system for **Inventory and Software Management**. |
| **Grafana** | Single **Dashboard** for centralized management. |
| **Prometheus** | A powerful tool for collecting and querying **System Metrics** and alerting. |
| **Ansible** | An automation engine for **Remote Script Execution**, configuration management, and application deployment. |
| **Nebula** | A scalable overlay networking tool that creates a secure **Mesh VPN Network**. |

---

## Setup

1.  **Run Installer Script**

    This script is a wrapper for any setup scripts within the [setup-scripts](https://github.com/jcarpenter-uam/uam-rmm/tree/master/setup-scripts) directory. Feel free to check them out if need be.

    ```
    sudo ./installer.sh
    ```

2.  **Run Docker Compose Stack**

    ```
    docker compose up -d
    ```

---
