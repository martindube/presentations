---
marp: true
theme: hf2022
size: 16:9
header: ""
footer: ""
paginate: true
class: default_slide
_paginate: false          # Ne pas paginer la page 1.
_class: separation_page1  # Style de la page 1.
math: katex
---

La page d'accueil est dans `prez_finale.md`

---

# Testing Environment

Wether Automated or Manual, the testing environment **must be** in production.
<!-- 
- Must replicate exacatly what is being used in production
  - plutot +the testing environnement idealy must be in production environnement with nodes/probes egual to waht is being used+ 
  - Bref parler de "testing environnement" et ne pas séparer entre "Automated" et "Manual"
  TODO: A bonifier et brainstorm (mdube & danlaf)
-->
<div class="twocols">

## Automated

- Analytic Testing Tools
  - Great to quick start testing and automation
  - Many open source options
  - Can be hard to maintain ...

<!--  

Notes danlaf:
  - This section needs more research vs BAS
  - Example of these tools
    - **Automated:**
      - Atomic Red Team (Red Canary)
      - RTA by Endgame
    - **Manual more like testing tools:**
      - Metasploits
      - Cobalt Strike

-->

- Breach and Attack Simulation (BAS)
  - Feeds from up-to-date intel and TTPs 
  - Great to automatically test if the controls or detection are working... or still working
  - Can be used to automate repeatable purple team tests

<!--  

Notes danlaf:
  - Keep the test up to date versus "known" IOCs and TTPs
  - Can definitely be used to assist in purple teaming
  - Ability to safely test against malware
  - can remove in part the challenge and limitation of a report/snapshot only "point in time"
  
-->

## Manual

- Dedicate machines!
- Should be easy to redeploy
- ?

</div>

---