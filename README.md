# Ecological Cycle Optimizer (ECO)


> A novel nature-inspired metaheuristic algorithm for non-convex global optimization.

<p>
  <a href="https://arxiv.org/abs/2508.20458"><img src="assets/paper-badge.svg" height="36" alt="Paper" align="absmiddle"></a>
  <a href="https://jxxsteven7.github.io/ECO-Optimizer/"><img src="assets/website-badge.svg" height="36" alt="Website" align="absmiddle"></a>
  <a href="https://www.mathworks.com/matlabcentral/fileexchange/180852-ecological-cycle-optimizer-eco"><img src="assets/matlab-badge.svg" height="36" alt="Matlab" align="absmiddle"></a>
</p>

<!-- <p align="center">
  <a href="https://arxiv.org/abs/2508.20458">Paper</a> &nbsp;|&nbsp;
  <a href="https://jxxsteven7.github.io/ECO-Optimizer/">Project page</a> &nbsp;|&nbsp;
  <a href="https://www.mathworks.com/matlabcentral/fileexchange/180852-ecological-cycle-optimizer-eco">MATLAB File Exchange</a>
</p> -->

<a href="https://ma-boyu.github.io/"><strong>Boyu Ma</strong></a><sup>1,2,&#42;</sup>, <a href="https://github.com/jxxsteven7"><strong>Jiaxiao Shi</strong></a><sup>1,2,&#42;</sup>, <a href="https://scholar.google.com/citations?user=hVKAr7YAAAAJ&amp;hl=zh-CN"><strong>Yiming Ji</strong></a><sup>1</sup>, and <a href="https://www.researchgate.net/scientific-contributions/Zhengpu-Wang-2228862425"><strong>Zhengpu Wang</strong></a><sup>1</sup>

<sup>1</sup> State Key Laboratory of Robotics and Systems, Harbin Institute of Technology, China<br>
<sup>2</sup> School of Mechanical and Aerospace Engineering, Nanyang Technological University, Singapore<br>
<sup>&#42;</sup> Equal contribution.

![Ecological relationships used by ECO](assets/eco_ecosystem.jpg)

<a id="contents"></a>
## 📚 Contents

- [Ecological Cycle Optimizer (ECO)](#ecological-cycle-optimizer-eco)
  - [📚 Contents](#-contents)
  - [🌍 Overview](#-overview)
  - [🚀 Quick Start](#-quick-start)
  - [🔁 Coding Details](#-coding-details)
    - [Parameter settings](#parameter-settings)
    - [Experimental settings](#experimental-settings)
    - [ECO on customized optimization problems](#eco-on-customized-optimization-problems)
    - [Outputs](#outputs)
  - [📊 Experimental Scope in the Paper](#-experimental-scope-in-the-paper)
  - [📖 Citation and Contact](#-citation-and-contact)

<a id="overview"></a>
## 🌍 Overview

ECO models an optimization population as an ecological system. Its design is inspired by energy flow and material cycling among producers, consumers, decomposers, and nutrients. The algorithm combines complementary update mechanisms to maintain a dynamic balance between global exploration and local exploitation.

Each iteration includes the following ecological roles:

1. **Producers** absorb nutrients and provide guided candidate information.
2. **Consumers** consist of herbivores, carnivores, and omnivores with different predation-based update behaviours.
3. **Decomposers** recycle population information through optimal, local-random, and global-random decomposition.
4. **Selection** retains improved individuals and preserves the best solution found so far.

The codebase provides two MATLAB implementations:

- **`ECO for FEs`**: uses a maximum number of function evaluations (`MaxFEs`) as the termination criterion. Use this version for CEC-style comparisons with an evaluation-budget criterion.
- **`ECO for iterations`**: uses a maximum number of iterations (`Max_it`) as the termination criterion. Use this version for iteration-based experiments or direct applications.




<a id="quick-start"></a>
## 🚀 Quick Start

Clone the repository:

```bash
git clone https://github.com/jxxsteven7/ECO-Optimizer.git
cd ECO-Optimizer
```

Then open MATLAB, change to one of the following folders, and run `main.m`:

```bash
# Function-evaluation version
cd ./ECO for FEs      

# Iteration-based version
cd./ECO for iterations  
```

The scripts automatically create a local `results/` directory and process the
[23 classic benchmark functions](https://ieeexplore.ieee.org/document/771163)
(`F1`-`F23`).




<a id="coding-details"></a>
## 🔁 Coding Details


### Parameter settings

The recommended default configuration, determined by parameter sensitivity
analysis on [23 classic benchmark functions](https://ieeexplore.ieee.org/document/771163), is:

```matlab
% Population probabilities
P_producer = 0.2;
P_herbivore = 0.3;
P_carnivore = 0.3;
P_omnivore = 0.2;

% Decomposition probabilities
P_opt = 0.6;
P_loc = 0.6;
```

### Experimental settings

For the Function-evaluation version, use the CEC-style budget:

```matlab
Pop_size = 30;
Run_times = 10;
MaxFEs = 10000 * dim;
```

The script selects the function dimension and a compatible iteration count internally, then calls:

```matlab
[Best_pos, Best_fit, ECO_curve] = ...
    ECO(Pop_size, Max_it, MaxFEs, Low, Up, dim, fobj);
```

For the Iteration-based version, use the following budget:

```matlab
Pop_size = 30;
Max_it = 500;
Run_times = 10;
```

The corresponding call is:

```matlab
[Best_pos, Best_fit, ECO_curve] = ...
    ECO(Pop_size, Max_it, Low, Up, dim, fobj);
```

### ECO on customized optimization problems

1. Define an objective function with the signature `fobj(x)`, where `x` is a row vector.
2. Specify the lower bound `Low`, upper bound `Up`, and dimension `dim`.
3. Call the version of `ECO.m` that matches the desired termination criterion.

For example:

```matlab
fobj = @(x) sum(x.^2);
Low = -100;
Up = 100;
dim = 30;
```

To add benchmark functions to the supplied scripts, update `Get_BenchFunctions.m` and add the corresponding identifier to `Function_list` in `main.m`.

### Outputs

For every function, both scripts write the following CSV files to their own `results/` folder:

- `Convergence_curve_classic_F*.csv`: one best-so-far convergence curve per independent run.
- `Best_pos_classic_F*.csv`: the best decision vector from each run.
- `Best_fit_classic_F*.csv`: the final best fitness value from each run.

The MATLAB command window also reports the minimum, mean, and standard deviation of the final fitness values.





<a id="experimental-scope-in-the-paper"></a>
## 📊 Experimental Scope in the Paper

The paper evaluates ECO in three stages:

1. **Parameter sensitivity analysis** on [23 classic functions](https://ieeexplore.ieee.org/document/771163) to select the default population proportions and decomposition probabilities.
2. **Performance potential** against a 30-algorithm metaheuristic pool on [CEC-2014](https://github.com/P-N-Suganthan/CEC2014) and [CEC-2017](https://github.com/P-N-Suganthan/CEC2017-BoundContrained), followed by detailed evaluation on [CEC-2020](https://github.com/P-N-Suganthan/2020-Bound-Constrained-Opt-Benchmark).
3. **Engineering validation** on five constrained design problems from [CEC-2020-RW](https://github.com/P-N-Suganthan/2020-RW-Constrained-Optimisation).

For methodological details, experimental settings, and complete results, please see the [paper](https://arxiv.org/abs/2508.20458) and the [project page](https://jxxsteven7.github.io/ECO-Optimizer/).

<a id="citation-and-contact"></a>
## 📖 Citation and Contact

If you use ECO or this implementation in your research, please cite:

```bibtex
@article{2026eco,
  title   = {Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for non-convex global optimization},
  author  = {Boyu Ma, Jiaxiao Shi, Yiming Ji and Zhengpu Wang},
  journal = {arXiv preprint arXiv:2508.20458},
  year    = {2026}
}
```

For questions about the algorithm, implementation, or research collaboration, contact:

- Boyu Ma: [boyu.ma@ntu.edu.sg](mailto:boyu.ma@ntu.edu.sg)
- Jiaxiao Shi: [jiaxiao.shi@ntu.edu.sg](mailto:jiaxiao.shi@ntu.edu.sg)
