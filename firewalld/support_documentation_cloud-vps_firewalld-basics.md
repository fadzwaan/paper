---
canonical: https://www.ramnode.com/support/documentation/cloud-vps/firewalld-basics
meta-description: Learn how to manage your firewall with firewalld on RHEL-based distributions like AlmaLinux, Rocky Linux, and CentOS. Essential commands for securing your server.
meta-og:description: Learn how to manage your firewall with firewalld on RHEL-based distributions like AlmaLinux, Rocky Linux, and CentOS. Essential commands for securing your server.
meta-og:title: Firewalld Basics - Cloud VPS Security | RamNode Documentation
meta-viewport: width=device-width, initial-scale=1.0
title: Firewalld Basics - Cloud VPS Security | RamNode Documentation
---


[![RamNode logo](/assets/logo-CYoHfYRX.png)](/)

Products![SVG Image](data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiBhcmlhLWhpZGRlbj0idHJ1ZSIgdmlld0JveD0iMCAwIDEwIDYiIGNsYXNzPSJyZWxhdGl2ZSB0b3AtWzFweF0gbWwtMSBoLTMgdy0zIHRyYW5zaXRpb24gZHVyYXRpb24tMjAwIGdyb3VwLWRhdGEtW3N0YXRlPW9wZW5dOnJvdGF0ZS0xODAiPjxwYXRoIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Im0xIDEgNCA0IDQtNCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiAvPjwvc3ZnPg==)

Deployment Guides![SVG Image](data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAgNiIgYXJpYS1oaWRkZW49InRydWUiIGZpbGw9Im5vbmUiIGNsYXNzPSJyZWxhdGl2ZSB0b3AtWzFweF0gbWwtMSBoLTMgdy0zIHRyYW5zaXRpb24gZHVyYXRpb24tMjAwIGdyb3VwLWRhdGEtW3N0YXRlPW9wZW5dOnJvdGF0ZS0xODAiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMiIgZD0ibTEgMSA0IDQgNC00IiAvPjwvc3ZnPg==)

Capabilities![SVG Image](data:image/svg+xml;base64,PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgdmlld0JveD0iMCAwIDEwIDYiIGZpbGw9Im5vbmUiIGNsYXNzPSJyZWxhdGl2ZSB0b3AtWzFweF0gbWwtMSBoLTMgdy0zIHRyYW5zaXRpb24gZHVyYXRpb24tMjAwIGdyb3VwLWRhdGEtW3N0YXRlPW9wZW5dOnJvdGF0ZS0xODAiPjxwYXRoIHN0cm9rZS13aWR0aD0iMiIgZD0ibTEgMSA0IDQgNC00IiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZT0iY3VycmVudENvbG9yIiAvPjwvc3ZnPg==)

[Pricing](/pricing)Company![SVG Image](data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAgNiIgYXJpYS1oaWRkZW49InRydWUiIGZpbGw9Im5vbmUiIGNsYXNzPSJyZWxhdGl2ZSB0b3AtWzFweF0gbWwtMSBoLTMgdy0zIHRyYW5zaXRpb24gZHVyYXRpb24tMjAwIGdyb3VwLWRhdGEtW3N0YXRlPW9wZW5dOnJvdGF0ZS0xODAiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGQ9Im0xIDEgNCA0IDQtNCIgc3Ryb2tlLXdpZHRoPSIyIiAvPjwvc3ZnPg==)

Support![SVG Image](data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAgNiIgZmlsbD0ibm9uZSIgYXJpYS1oaWRkZW49InRydWUiIGNsYXNzPSJyZWxhdGl2ZSB0b3AtWzFweF0gbWwtMSBoLTMgdy0zIHRyYW5zaXRpb24gZHVyYXRpb24tMjAwIGdyb3VwLWRhdGEtW3N0YXRlPW9wZW5dOnJvdGF0ZS0xODAiPjxwYXRoIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgZD0ibTEgMSA0IDQgNC00IiAvPjwvc3ZnPg==)

[Sign Up](https://cloudorder.ramnode.com)[Login](https://clientarea.ramnode.com/login)

[![RamNode logo](/assets/logo-CYoHfYRX.png)](/)

[Sign Up](https://cloudorder.ramnode.com)[Login](https://clientarea.ramnode.com/login)

![SVG Image](data:image/svg+xml;base64,PHN2ZyBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZT0iY3VycmVudENvbG9yIiB3aWR0aD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDI0IDI0IiBoZWlnaHQ9IjI0IiBmaWxsPSJub25lIiBzdHJva2Utd2lkdGg9IjIiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLW1lbnUgaC00IHctNCBtci0yIj48bGluZSB4Mj0iMjAiIHkyPSIxMiIgeDE9IjQiIHkxPSIxMiIgLz48bGluZSB4Mj0iMjAiIHgxPSI0IiB5MT0iNiIgeTI9IjYiIC8+PGxpbmUgeDI9IjIwIiB5MT0iMTgiIHgxPSI0IiB5Mj0iMTgiIC8+PC9zdmc+)MenuToggle menu

[← Back to Cloud VPS Documentation](/support/documentation/cloud-vps)

# Firewalld Basics

Manage your firewall with firewalld on RHEL-based distributions. This guide covers essential firewalld operations using zones and services for securing your server.

![SVG Image](data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjQgMjQiIHN0cm9rZT0iY3VycmVudENvbG9yIiB3aWR0aD0iMjQiIGZpbGw9Im5vbmUiIGhlaWdodD0iMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNoaWVsZCBoLTMgdy0zIG1yLTEiPjxwYXRoIGQ9Ik0yMCAxM2MwIDUtMy41IDcuNS03LjY2IDguOTVhMSAxIDAgMCAxLS42Ny0uMDFDNy41IDIwLjUgNCAxOCA0IDEzVjZhMSAxIDAgMCAxIDEtMWMyIDAgNC41LTEuMiA2LjI0LTIuNzJhMS4xNyAxLjE3IDAgMCAxIDEuNTIgMEMxNC41MSAzLjgxIDE3IDUgMTkgNWExIDEgMCAwIDEgMSAxeiIgLz48L3N2Zz4=)Security

![SVG Image](data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiBzdHJva2Utd2lkdGg9IjIiIHZpZXdCb3g9IjAgMCAyNCAyNCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiB3aWR0aD0iMjQiIHN0cm9rZT0iY3VycmVudENvbG9yIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGZpbGw9Im5vbmUiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXRlcm1pbmFsIGgtMyB3LTMgbXItMSI+PHBvbHlsaW5lIHBvaW50cz0iNCAxNyAxMCAxMSA0IDUiIC8+PGxpbmUgeDE9IjEyIiB5MT0iMTkiIHgyPSIyMCIgeTI9IjE5IiAvPjwvc3ZnPg==)RHEL / AlmaLinux / Rocky

⏱️ 10 minutes

### 📋 Guide Contents

✕

[Overview](#overview)[Understanding Zones](#zones)[Checking Status](#status)[Viewing Configuration](#viewing-config)[Opening Ports](#opening-ports)[Adding Services](#adding-services)[Removing Rules](#removing-rules)[Working with Zones](#working-zones)[IP Address Rules](#ip-rules)[Port Forwarding](#port-forwarding)[Runtime vs Permanent](#runtime-permanent)[Quick Reference](#quick-reference)

![SVG Image](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGZpbGw9Im5vbmUiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBoZWlnaHQ9IjI0IiBzdHJva2UtbGluZWpvaW49InJvdW5kIiB2aWV3Qm94PSIwIDAgMjQgMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNxdWFyZS1jaGVjay1iaWcgaC00IHctNCI+PHBhdGggZD0iTTIxIDEwLjVWMTlhMiAyIDAgMCAxLTIgMkg1YTIgMiAwIDAgMS0yLTJWNWEyIDIgMCAwIDEgMi0yaDEyLjUiIC8+PHBhdGggZD0ibTkgMTEgMyAzTDIyIDQiIC8+PC9zdmc+)

![SVG Image](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIHN0cm9rZT0iY3VycmVudENvbG9yIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgaGVpZ2h0PSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBmaWxsPSJub25lIiB2aWV3Qm94PSIwIDAgMjQgMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNoaWVsZCBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0iTTIwIDEzYzAgNS0zLjUgNy41LTcuNjYgOC45NWExIDEgMCAwIDEtLjY3LS4wMUM3LjUgMjAuNSA0IDE4IDQgMTNWNmExIDEgMCAwIDEgMS0xYzIgMCA0LjUtMS4yIDYuMjQtMi43MmExLjE3IDEuMTcgMCAwIDEgMS41MiAwQzE0LjUxIDMuODEgMTcgNSAxOSA1YTEgMSAwIDAgMSAxIDF6IiAvPjwvc3ZnPg==)

### Overview

firewalld is the default firewall management tool on RHEL-based distributions (AlmaLinux, Rocky Linux, CentOS Stream) and Fedora. It provides a dynamic, zone-based approach to managing firewall rules without requiring service restarts.

💡 **Tip:** firewalld comes pre-installed on most RHEL-based systems.

2

![SVG Image](data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgdmlld0JveD0iMCAwIDI0IDI0IiBzdHJva2Utd2lkdGg9IjIiIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWxheWVycyBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0ibTEyLjgzIDIuMThhMiAyIDAgMCAwLTEuNjYgMEwyLjYgNi4wOGExIDEgMCAwIDAgMCAxLjgzbDguNTggMy45MWEyIDIgMCAwIDAgMS42NiAwbDguNTgtMy45YTEgMSAwIDAgMCAwLTEuODNaIiAvPjxwYXRoIGQ9Im0yMiAxNy42NS05LjE3IDQuMTZhMiAyIDAgMCAxLTEuNjYgMEwyIDE3LjY1IiAvPjxwYXRoIGQ9Im0yMiAxMi42NS05LjE3IDQuMTZhMiAyIDAgMCAxLTEuNjYgMEwyIDEyLjY1IiAvPjwvc3ZnPg==)

### Understanding Zones

firewalld uses zones to define trust levels for network connections. Each zone has predefined rules that determine what traffic is allowed.

#### public

The default zone for untrusted networks. Only explicitly allowed services pass through.

#### trusted

All traffic is accepted.

#### drop

All incoming traffic is dropped silently with no response.

#### block

Similar to drop, but rejects traffic with an ICMP response.

3

![SVG Image](data:image/svg+xml;base64,PHN2ZyBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS13aWR0aD0iMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHN0cm9rZT0iY3VycmVudENvbG9yIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJub25lIiB2aWV3Qm94PSIwIDAgMjQgMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWZpbGUtdGV4dCBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0iTTE1IDJINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoMTJhMiAyIDAgMCAwIDItMlY3WiIgLz48cGF0aCBkPSJNMTQgMnY0YTIgMiAwIDAgMCAyIDJoNCIgLz48cGF0aCBkPSJNMTAgOUg4IiAvPjxwYXRoIGQ9Ik0xNiAxM0g4IiAvPjxwYXRoIGQ9Ik0xNiAxN0g4IiAvPjwvc3ZnPg==)

### Checking firewalld Status

Before making changes, verify firewalld is running:

    sudo systemctl status firewalld

To start and enable firewalld on boot:

    sudo systemctl start firewalld
    sudo systemctl enable firewalld

✅ **Success:** Your firewall is now active and will start automatically on boot.

4

![SVG Image](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNldHRpbmdzIGgtNSB3LTUgdGV4dC1wcmltYXJ5Ij48cGF0aCBkPSJNMTIuMjIgMmgtLjQ0YTIgMiAwIDAgMC0yIDJ2LjE4YTIgMiAwIDAgMS0xIDEuNzNsLS40My4yNWEyIDIgMCAwIDEtMiAwbC0uMTUtLjA4YTIgMiAwIDAgMC0yLjczLjczbC0uMjIuMzhhMiAyIDAgMCAwIC43MyAyLjczbC4xNS4xYTIgMiAwIDAgMSAxIDEuNzJ2LjUxYTIgMiAwIDAgMS0xIDEuNzRsLS4xNS4wOWEyIDIgMCAwIDAtLjczIDIuNzNsLjIyLjM4YTIgMiAwIDAgMCAyLjczLjczbC4xNS0uMDhhMiAyIDAgMCAxIDIgMGwuNDMuMjVhMiAyIDAgMCAxIDEgMS43M1YyMGEyIDIgMCAwIDAgMiAyaC40NGEyIDIgMCAwIDAgMi0ydi0uMThhMiAyIDAgMCAxIDEtMS43M2wuNDMtLjI1YTIgMiAwIDAgMSAyIDBsLjE1LjA4YTIgMiAwIDAgMCAyLjczLS43M2wuMjItLjM5YTIgMiAwIDAgMC0uNzMtMi43M2wtLjE1LS4wOGEyIDIgMCAwIDEtMS0xLjc0di0uNWEyIDIgMCAwIDEgMS0xLjc0bC4xNS0uMDlhMiAyIDAgMCAwIC43My0yLjczbC0uMjItLjM4YTIgMiAwIDAgMC0yLjczLS43M2wtLjE1LjA4YTIgMiAwIDAgMS0yIDBsLS40My0uMjVhMiAyIDAgMCAxLTEtMS43M1Y0YTIgMiAwIDAgMC0yLTJ6IiAvPjxjaXJjbGUgY3k9IjEyIiByPSIzIiBjeD0iMTIiIC8+PC9zdmc+)

### Viewing Current Configuration

Check the active zone and its rules:

    sudo firewall-cmd --get-active-zones
    sudo firewall-cmd --list-all

To see rules for a specific zone:

    sudo firewall-cmd --zone=public --list-all

5

![SVG Image](data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgdmlld0JveD0iMCAwIDI0IDI0IiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS13aWR0aD0iMiIgd2lkdGg9IjI0IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGhlaWdodD0iMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWtleSBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0ibTE1LjUgNy41IDIuMyAyLjNhMSAxIDAgMCAwIDEuNCAwbDIuMS0yLjFhMSAxIDAgMCAwIDAtMS40TDE5IDQiIC8+PHBhdGggZD0ibTIxIDItOS42IDkuNiIgLz48Y2lyY2xlIGN5PSIxNS41IiBjeD0iNy41IiByPSI1LjUiIC8+PC9zdmc+)

### Opening Ports

To allow traffic on a specific port temporarily (until reload or reboot):

    sudo firewall-cmd --add-port=8080/tcp

To make the change permanent:

    sudo firewall-cmd --permanent --add-port=8080/tcp
    sudo firewall-cmd --reload

![SVG Image](data:image/svg+xml;base64,PHN2ZyBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgd2lkdGg9IjI0IiBzdHJva2Utd2lkdGg9IjIiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXRyaWFuZ2xlLWFsZXJ0IGgtNSB3LTUgdGV4dC1hbWJlci01MDAgZmxleC1zaHJpbmstMCBtdC0wLjUiPjxwYXRoIGQ9Im0yMS43MyAxOC04LTE0YTIgMiAwIDAgMC0zLjQ4IDBsLTggMTRBMiAyIDAgMCAwIDQgMjFoMTZhMiAyIDAgMCAwIDEuNzMtMyIgLz48cGF0aCBkPSJNMTIgOXY0IiAvPjxwYXRoIGQ9Ik0xMiAxN2guMDEiIC8+PC9zdmc+)

Important

After any `--permanent` changes, always run `firewall-cmd --reload` to apply them.

6

![SVG Image](data:image/svg+xml;base64,PHN2ZyBzdHJva2U9ImN1cnJlbnRDb2xvciIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJub25lIiBzdHJva2UtbGluZWNhcD0icm91bmQiIGhlaWdodD0iMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNlcnZlciBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHJlY3QgeT0iMiIgcng9IjIiIGhlaWdodD0iOCIgeD0iMiIgd2lkdGg9IjIwIiByeT0iMiIgLz48cmVjdCB3aWR0aD0iMjAiIHJ5PSIyIiByeD0iMiIgaGVpZ2h0PSI4IiB4PSIyIiB5PSIxNCIgLz48bGluZSB5Mj0iNiIgeTE9IjYiIHgyPSI2LjAxIiB4MT0iNiIgLz48bGluZSB4Mj0iNi4wMSIgeTI9IjE4IiB4MT0iNiIgeTE9IjE4IiAvPjwvc3ZnPg==)

### Adding Services

firewalld includes predefined services (http, https, ssh, etc.) that simplify rule management:

    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --reload

To see all available predefined services:

    firewall-cmd --get-services

💡 **Tip:** Using service names instead of port numbers makes your configuration more readable and easier to maintain.

7

![SVG Image](data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjI0IiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJub25lIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjI0IiB2aWV3Qm94PSIwIDAgMjQgMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNldHRpbmdzIGgtNSB3LTUgdGV4dC1wcmltYXJ5Ij48cGF0aCBkPSJNMTIuMjIgMmgtLjQ0YTIgMiAwIDAgMC0yIDJ2LjE4YTIgMiAwIDAgMS0xIDEuNzNsLS40My4yNWEyIDIgMCAwIDEtMiAwbC0uMTUtLjA4YTIgMiAwIDAgMC0yLjczLjczbC0uMjIuMzhhMiAyIDAgMCAwIC43MyAyLjczbC4xNS4xYTIgMiAwIDAgMSAxIDEuNzJ2LjUxYTIgMiAwIDAgMS0xIDEuNzRsLS4xNS4wOWEyIDIgMCAwIDAtLjczIDIuNzNsLjIyLjM4YTIgMiAwIDAgMCAyLjczLjczbC4xNS0uMDhhMiAyIDAgMCAxIDIgMGwuNDMuMjVhMiAyIDAgMCAxIDEgMS43M1YyMGEyIDIgMCAwIDAgMiAyaC40NGEyIDIgMCAwIDAgMi0ydi0uMThhMiAyIDAgMCAxIDEtMS43M2wuNDMtLjI1YTIgMiAwIDAgMSAyIDBsLjE1LjA4YTIgMiAwIDAgMCAyLjczLS43M2wuMjItLjM5YTIgMiAwIDAgMC0uNzMtMi43M2wtLjE1LS4wOGEyIDIgMCAwIDEtMS0xLjc0di0uNWEyIDIgMCAwIDEgMS0xLjc0bC4xNS0uMDlhMiAyIDAgMCAwIC43My0yLjczbC0uMjItLjM4YTIgMiAwIDAgMC0yLjczLS43M2wtLjE1LjA4YTIgMiAwIDAgMS0yIDBsLS40My0uMjVhMiAyIDAgMCAxLTEtMS43M1Y0YTIgMiAwIDAgMC0yLTJ6IiAvPjxjaXJjbGUgY3k9IjEyIiByPSIzIiBjeD0iMTIiIC8+PC9zdmc+)

### Removing Rules

Remove a port or service using the corresponding `--remove` flag:

    sudo firewall-cmd --permanent --remove-port=8080/tcp
    sudo firewall-cmd --permanent --remove-service=http
    sudo firewall-cmd --reload

8

![SVG Image](data:image/svg+xml;base64,PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2Utd2lkdGg9IjIiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWxheWVycyBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0ibTEyLjgzIDIuMThhMiAyIDAgMCAwLTEuNjYgMEwyLjYgNi4wOGExIDEgMCAwIDAgMCAxLjgzbDguNTggMy45MWEyIDIgMCAwIDAgMS42NiAwbDguNTgtMy45YTEgMSAwIDAgMCAwLTEuODNaIiAvPjxwYXRoIGQ9Im0yMiAxNy42NS05LjE3IDQuMTZhMiAyIDAgMCAxLTEuNjYgMEwyIDE3LjY1IiAvPjxwYXRoIGQ9Im0yMiAxMi42NS05LjE3IDQuMTZhMiAyIDAgMCAxLTEuNjYgMEwyIDEyLjY1IiAvPjwvc3ZnPg==)

### Working with Zones

Assign an interface to a specific zone:

    sudo firewall-cmd --permanent --zone=trusted --change-interface=eth1
    sudo firewall-cmd --reload

Change the default zone for new interfaces:

    sudo firewall-cmd --set-default-zone=public

9

![SVG Image](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGZpbGw9Im5vbmUiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHdpZHRoPSIyNCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHN0cm9rZT0iY3VycmVudENvbG9yIiBoZWlnaHQ9IjI0IiBzdHJva2Utd2lkdGg9IjIiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWtleSBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0ibTE1LjUgNy41IDIuMyAyLjNhMSAxIDAgMCAwIDEuNCAwbDIuMS0yLjFhMSAxIDAgMCAwIDAtMS40TDE5IDQiIC8+PHBhdGggZD0ibTIxIDItOS42IDkuNiIgLz48Y2lyY2xlIGN5PSIxNS41IiByPSI1LjUiIGN4PSI3LjUiIC8+PC9zdmc+)

### Allowing Specific IP Addresses

To allow all traffic from a trusted IP address:

    sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.100" accept'
    sudo firewall-cmd --reload

To allow a specific IP to access a particular port:

    sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.100" port port="3306" protocol="tcp" accept'
    sudo firewall-cmd --reload

✅ **Recommended:** Restrict database access to specific IP addresses rather than opening ports to everyone.

10

![SVG Image](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJub25lIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGhlaWdodD0iMjQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNldHRpbmdzIGgtNSB3LTUgdGV4dC1wcmltYXJ5Ij48cGF0aCBkPSJNMTIuMjIgMmgtLjQ0YTIgMiAwIDAgMC0yIDJ2LjE4YTIgMiAwIDAgMS0xIDEuNzNsLS40My4yNWEyIDIgMCAwIDEtMiAwbC0uMTUtLjA4YTIgMiAwIDAgMC0yLjczLjczbC0uMjIuMzhhMiAyIDAgMCAwIC43MyAyLjczbC4xNS4xYTIgMiAwIDAgMSAxIDEuNzJ2LjUxYTIgMiAwIDAgMS0xIDEuNzRsLS4xNS4wOWEyIDIgMCAwIDAtLjczIDIuNzNsLjIyLjM4YTIgMiAwIDAgMCAyLjczLjczbC4xNS0uMDhhMiAyIDAgMCAxIDIgMGwuNDMuMjVhMiAyIDAgMCAxIDEgMS43M1YyMGEyIDIgMCAwIDAgMiAyaC40NGEyIDIgMCAwIDAgMi0ydi0uMThhMiAyIDAgMCAxIDEtMS43M2wuNDMtLjI1YTIgMiAwIDAgMSAyIDBsLjE1LjA4YTIgMiAwIDAgMCAyLjczLS43M2wuMjItLjM5YTIgMiAwIDAgMC0uNzMtMi43M2wtLjE1LS4wOGEyIDIgMCAwIDEtMS0xLjc0di0uNWEyIDIgMCAwIDEgMS0xLjc0bC4xNS0uMDlhMiAyIDAgMCAwIC43My0yLjczbC0uMjItLjM4YTIgMiAwIDAgMC0yLjczLS43M2wtLjE1LjA4YTIgMiAwIDAgMS0yIDBsLS40My0uMjVhMiAyIDAgMCAxLTEtMS43M1Y0YTIgMiAwIDAgMC0yLTJ6IiAvPjxjaXJjbGUgcj0iMyIgY3g9IjEyIiBjeT0iMTIiIC8+PC9zdmc+)

### Port Forwarding

Forward external port 8080 to internal port 80:

    sudo firewall-cmd --permanent --add-forward-port=port=8080:proto=tcp:toport=80
    sudo firewall-cmd --reload

11

![SVG Image](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHN0cm9rZT0iY3VycmVudENvbG9yIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiB3aWR0aD0iMjQiIHN0cm9rZS13aWR0aD0iMiIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2UtbGluZWNhcD0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXNoaWVsZCBoLTUgdy01IHRleHQtcHJpbWFyeSI+PHBhdGggZD0iTTIwIDEzYzAgNS0zLjUgNy41LTcuNjYgOC45NWExIDEgMCAwIDEtLjY3LS4wMUM3LjUgMjAuNSA0IDE4IDQgMTNWNmExIDEgMCAwIDEgMS0xYzIgMCA0LjUtMS4yIDYuMjQtMi43MmExLjE3IDEuMTcgMCAwIDEgMS41MiAwQzE0LjUxIDMuODEgMTcgNSAxOSA1YTEgMSAwIDAgMSAxIDF6IiAvPjwvc3ZnPg==)

### Runtime vs Permanent Rules

firewalld distinguishes between runtime rules (active immediately but lost on reload) and permanent rules (persist across reloads but require `--reload` to activate).

A common workflow is to test rules at runtime first, then add them permanently once verified:

    # Test the rule
    sudo firewall-cmd --add-port=9000/tcp

    # If it works as expected, make it permanent
    sudo firewall-cmd --runtime-to-permanent

💡 **Tip:** The `--runtime-to-permanent` command copies all current runtime rules to the permanent configuration.

12

![SVG Image](data:image/svg+xml;base64,PHN2ZyBzdHJva2UtbGluZWNhcD0icm91bmQiIGhlaWdodD0iMjQiIGZpbGw9Im5vbmUiIHN0cm9rZS13aWR0aD0iMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXRlcm1pbmFsIGgtNSB3LTUgdGV4dC1wcmltYXJ5Ij48cG9seWxpbmUgcG9pbnRzPSI0IDE3IDEwIDExIDQgNSIgLz48bGluZSB4MT0iMTIiIHgyPSIyMCIgeTI9IjE5IiB5MT0iMTkiIC8+PC9zdmc+)

### Quick Reference

Check status`firewall-cmd --state`

List all rules`firewall-cmd --list-all`

Add port permanently`firewall-cmd --permanent --add-port=PORT/tcp`

Add service permanently`firewall-cmd --permanent --add-service=SERVICE`

Reload configuration`firewall-cmd --reload`

List available services`firewall-cmd --get-services`

[← Back to Cloud VPS Documentation](/support/documentation/cloud-vps)[View Cloud VPS Plans →](/pricing)

### Products

- [Cloud Hosting](/products/cloud-hosting)
- [cPanel Hosting](/products/cpanel-hosting)


### Company

- [About](/about)
- [Contact Us](https://clientarea.ramnode.com/submitticket.php?step=2&deptid=3)
- [Datacenter Locations](/support/documentation/cloud-vps/data-centers)
- [InMotion Hosting Dedicated Servers](https://www.inmotionhosting.com/dedicated-servers)
- [InMotion Hosting Bare Metal](https://www.inmotionhosting.com/bare-metal-servers)


### Support

- [Deployment Guides](/deployment-guides)
- [Network Status](https://status.ramnode.com/)
- [Cloud Panel](https://cloud.ramnode.com/)
- [Client Area](https://clientarea.ramnode.com/clientarea.php)
- [Professional Services](/professional-services)


### Legal

- [Terms of Service](https://clientarea.ramnode.com/tos.php)
- [Acceptable Use Policy](https://clientarea.ramnode.com/aup.php)
- [Privacy Policy](https://www.inmotionhosting.com/legal/privacy-policy/)
- [Cookie Policy](https://www.inmotionhosting.com/legal/cookie-policy/)
- [Data Processing Agreement](https://www.inmotionhosting.com/legal/dpa/)

© 2026 RamNode. All rights reserved. RamNode® is a registered trademark of [InMotion Hosting, Inc.](https://www.inmotionhosting.com)
