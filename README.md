# Cost‑Effective Strategies for Infectious Diseases

### Multi‑Objective Optimization Framework (MOO Framework)

This repository accompanies the research paper **“Cost‑Effective Strategies for Infectious Diseases: A Multi‑Objective Framework”**. It contains all source code required to reproduce the core computational pipeline—**mathematical modelling (SEIQRD), hybrid parameter estimation, sensitivity analysis (PRCC), multi‑objective optimisation (NSGA‑II) and cost‑benefit analysis**. The dashboard are provided by two server.

---

## Repository Layout

| Folder                       | Contents                                                                                               |
| ---------------------------- | ------------------------------------------------------------------------------------------------------ |
| **`1.Data/`**                  | Raw epidemiological data (Our World in Data), processed input files, and reference parameter tables. |
| **`2.PRCC/`**                  | Scripts for Partial Rank Correlation Coefficient analysis and accompanying visualisations. The modeling should be included to run PRCC.        |
| **`3.Fitting/`**       | Hybrid *IMODE* + *MCMC (DRAM)* routines, example notebooks, and best‑fit parameter sets. The modeling should be included to run Fitting.                         |
| **`4.Multi-objectiveOptimization/`**          | Multi‑objective optimisation notebooks using *NSGA‑II* (MATLAB `multiobjga`) with helper utilities. The modeling should be included to run Multi-ObjectiveOptimization. |
| **`5.Cost-BenefitAnalysis/`** | Cost functions, heat‑map plotting scripts, and .mat outputs of cost‑optimal solutions.    |
| **`Results/`**    | If you run 'MAIN_framework.m', the results are automatically saved in this folder.              |
| **`MAIN_framework.m`**    | The main file to run all the including code.              |

---

## Quick Start

### 1 · Clone the repository

```bash
$ git clone https://github.com/ljm1729-scholar/MOO_framework.git
$ cd MOO_framework
```

### 2 · Install prerequisites

| Language            | Core dependencies                                                                     |
| ------------------- | ------------------------------------------------------------------------------------- |
| **MATLAB R2022a +** | Global Optimisation Toolbox (for `multiobjga`), Statistics & Machine Learning Toolbox |

Outputs (figures & .mat type dataset) are written to `results/`, mirroring those reported in the paper.

---

## Manuscript & Demo Dashboard

* **Pre‑print PDF** – see `Preprint link`
* **Interactive demo(Server 1)** – [https://jongmin-lee.shinyapps.io/demomookorea/](https://jongmin-lee.shinyapps.io/demomookorea/) (read‑only)
* **Interactive demo(Server 2)** – [http://moo.infdissim.com](http://moo.infdissim.com) (read‑only)

The dashboard lets users adjust economic parameters in real time, but all underlying datasets are generated with the scripts in this repository.

---

## Citing this Work

If you use the code or findings, please cite:

```
Lee J, Mendoza R, Mendoza VMP, Jung E. 2025. Cost‑Effective Strategies for Infectious Diseases: A Multi‑Objective Framework. pre‑print.
```
---

## Funding

This research was supported by the **Bio\&Medical Technology Development Program of the National Research Foundation (NRF)**, funded by the **Korean government (MSIT) (RS-2023-00227944)**. 
Additional support was provided by the **Korea National Research Foundation (NRF)** grant funded by the **Korean government (MEST) (NRF-2021R1A2C100448711)**.

---

## Contact

*Lead developer*: **Jongmin Lee** · [ljm1729@konkuk.ac.kr](mailto:ljm1729@konkuk.ac.kr)

*Corresponding author*: **Prof. Eunok Jung** · [junge@konkuk.ac.kr](mailto:junge@konkuk.ac.kr)

---

## License

Released under the **MIT License**. See `LICENSE` for details.
