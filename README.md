
# Laplace2D Solver Framework

**A Modular MATLAB Framework for the Numerical Solution of the Two-Dimensional Laplace Equation**

## Overview

Laplace2D Solver Framework is a modular and extensible MATLAB-based software project dedicated to the numerical solution of two-dimensional Laplace boundary value problems in rectangular computational domains.

The framework provides a structured computational environment covering the main stages of the numerical solution process: problem definition, computational grid generation, finite difference discretization, sparse linear system assembly, numerical solution, error analysis, convergence studies, and visualization.

Rather than focusing on a single numerical algorithm, the framework integrates multiple direct and iterative methods within a unified architecture, facilitating systematic numerical experimentation, algorithmic comparison, and future extensions.

## Mathematical Formulation

The governing equation is the two-dimensional Laplace equation:

$$
\nabla^2 u =
\frac{\partial^2 u}{\partial x^2}
+
\frac{\partial^2 u}{\partial y^2}
=0,
\qquad (x,y)\in\Omega.
$$

where $\Omega$ is a rectangular computational domain.

The problem is supplemented by appropriate boundary conditions prescribed along the boundary $\partial\Omega$.

The initial implementation focuses on rectangular domains, uniform structured grids, and the five-point finite difference discretization.

### Finite Difference Discretization

For an interior grid point $(i,j)$, the five-point finite difference approximation is:

$$
\frac{u_{i+1,j}-2u_{i,j}+u_{i-1,j}}{h_x^2}
+
\frac{u_{i,j+1}-2u_{i,j}+u_{i,j-1}}{h_y^2}
=0.
$$

For a uniform grid with $h_x=h_y=h$, this reduces to:

$$
u_{i+1,j}+u_{i-1,j}
+u_{i,j+1}+u_{i,j-1}
-4u_{i,j}=0.
$$

The discretization produces a sparse linear system:

$$
A\mathbf{u}=\mathbf{b},
$$

where $A$ is the coefficient matrix, $\mathbf{u}$ contains the unknown interior nodal values, and $\mathbf{b}$ incorporates contributions from the prescribed boundary conditions.

## Main Objectives

The framework is designed around the following objectives:

- **Problem Definition:** Flexible configuration of computational domains, grid parameters, and boundary conditions.
- **Grid Generation:** Construction and management of structured computational grids.
- **Numerical Discretization:** Implementation of finite difference schemes for approximating the governing partial differential equation.
- **Sparse Linear System Assembly:** Construction of the resulting algebraic systems, exploiting their sparse structure.
- **Numerical Solvers:** Implementation and integration of multiple direct and iterative methods through a common solver interface.
- **Numerical Analysis:** Investigation of numerical errors, residuals, convergence properties, and computational performance.
- **Visualization:** Graphical representation of numerical solutions, analytical solutions, and convergence behavior.
- **Extensibility:** Modular design that facilitates the integration of additional numerical methods and computational capabilities.

## Software Architecture

The framework follows a modular architecture, separating problem configuration, discretization, numerical solution, analysis, and visualization into independent components.

```text
Laplace2D-Solver-Framework/
│
├── configuration/
│   ├── create_problem.m
│   └── set_boundary_conditions.m
│
├── discretization/
│   ├── create_grid.m
│   ├── number_interior_nodes.m
│   ├── assemble_system.m
│   └── reconstruct_solution.m
│
├── solvers/
│   ├── direct/
│   │   ├── solve_backslash.m
│   │   ├── solve_gaussian.m
│   │   └── solve_lu.m
│   │
│   ├── iterative/
│   │   ├── solve_jacobi.m
│   │   ├── solve_gauss_seidel.m
│   │   └── solve_sor.m
│   │
│   └── solve_system.m
│
├── analysis/
│   ├── compute_exact_solution.m
│   ├── compute_error.m
│   └── convergence_study.m
│
├── visualization/
│   └── plot_results.m
│
├── interface/
│
├── tests/
│
├── main.m
├── .gitignore
└── README.md
```

Each module is responsible for a specific computational task, promoting code organization, maintainability, reusability, and future development.

### Architectural Components

- **Configuration:** Defines the computational problem, domain, grid parameters, and boundary conditions.
- **Discretization:** Generates the computational grid, numbers interior nodes, assembles the sparse linear system, and reconstructs the numerical solution.
- **Solvers:** Contains independent implementations of direct and iterative algorithms. A central dispatcher provides a unified mechanism for selecting and executing the desired solver.
- **Analysis:** Provides analytical solution evaluation, numerical error estimation, and grid refinement studies.
- **Visualization:** Generates graphical representations of numerical and analytical solutions and convergence results.
- **Interface:** Reserved for a future user-facing interface.
- **Tests:** Reserved for systematic verification and validation of individual computational components.

## Implemented Numerical Methods

The current implementation includes six numerical approaches, organized into two categories.

### Direct Methods

- **MATLAB Backslash Operator:** Solution using MATLAB's built-in linear system solver.
- **Gaussian Elimination:** Custom implementation of Gaussian elimination with partial pivoting.
- **LU Decomposition:** Custom implementation based on LU factorization.

### Iterative Methods

- **Jacobi Method:** Iterative solution based on the diagonal splitting of the coefficient matrix.
- **Gauss–Seidel Method:** Successive iterative updates using the most recently computed unknown values.
- **Successive Over-Relaxation (SOR):** Extension of Gauss–Seidel incorporating a relaxation parameter $\omega$ to potentially accelerate convergence.

The iterative solvers employ a prescribed convergence tolerance and maximum iteration limit. The SOR implementation currently uses a manually specified relaxation parameter.

## Numerical Analysis and Verification

An important aspect of the framework is the verification and investigation of numerical solutions against analytical results whenever available.

The current analysis capabilities include:

- Analytical solution evaluation.
- Absolute error computation.
- Maximum absolute error estimation.
- Grid refinement studies.
- Numerical convergence investigation.
- Comparison of numerical results across different grid resolutions.

### Analytical Verification

The initial test problem is configured with Dirichlet boundary conditions for which an analytical solution is available:

$$
u(x,y)=
\frac{\sinh(\pi y)}{\sinh(\pi)}
\sin(\pi x),
\qquad (x,y)\in[0,1]^2.
$$

This solution provides a reference for evaluating the accuracy of the numerical approximation.

### Grid Refinement Study

The framework supports the investigation of numerical error as the computational grid is refined.

The maximum absolute error is evaluated using:

$$
E_{\max}=
\max_{i,j}
\left|u_{i,j}^{\mathrm{numerical}}
-u_{i,j}^{\mathrm{exact}}\right|.
$$

This enables the investigation of discretization accuracy and the convergence behavior of the numerical approximation.

## Visualization

The visualization module currently supports:

- Three-dimensional surface representations of analytical and numerical solutions.
- Comparative visualization of solution fields.
- Grid refinement and convergence plots.

Additional visualization capabilities, including contour plots and spatial error distributions, are envisioned for future development.

## Current Development Status

**The project is under active development.**

The initial computational framework has been implemented and tested for a rectangular Laplace boundary value problem with Dirichlet boundary conditions.

### Implemented Capabilities

- Configuration of rectangular computational domains.
- Definition of Dirichlet boundary conditions.
- Generation of uniform structured computational grids.
- Interior-node numbering.
- Sparse matrix assembly using the five-point finite difference scheme.
- Reconstruction of the numerical solution from the computed interior unknowns.
- Six direct and iterative linear system solvers.
- Centralized solver selection through a common dispatcher.
- Analytical solution evaluation for verification.
- Maximum absolute error computation.
- Grid refinement and convergence studies.
- Three-dimensional visualization of analytical and numerical solutions.

### Planned Development

The following capabilities are intended for subsequent development stages.

**Boundary Conditions and Discretization**
- Neumann boundary conditions.
- Mixed boundary conditions.
- Higher-order finite difference schemes.
- Alternative discretization formulations.

**Numerical Solvers**
- Additional direct and iterative algorithms.
- Further optimization of existing solver implementations.
- More flexible parameter selection for iterative methods.

**Numerical Analysis**
- Residual computation and analysis.
- Systematic solver comparison.
- Iteration count and computational runtime measurements.
- Convergence rate estimation.
- Error and performance analysis across different grid resolutions.
- Investigation of iterative solver parameters.

**Visualization and User Interface**
- Contour plots and spatial error distributions.
- Enhanced comparative visualizations.
- Graphical user interface (GUI) for problem configuration, solver selection, simulation execution, and results inspection.

## Technologies

- **Programming Language:** MATLAB
- **Numerical Methods:** Finite Difference Methods
- **Linear Algebra:** Sparse Matrix Computations
- **Computational Techniques:** Direct and Iterative Linear System Solvers
- **Version Control:** Git and GitHub

## Project Goals

The long-term objective is to develop a comprehensive, modular, and extensible numerical software framework for solving and investigating two-dimensional Laplace boundary value problems.

Beyond obtaining numerical solutions, the framework aims to provide an organized computational environment for implementing, verifying, evaluating, and comparing numerical algorithms.

Its modular architecture is intended to support future extensions in numerical discretization, computational linear algebra, convergence analysis, and scientific visualization.

---

**Project:** Laplace2D Solver Framework  
**Language:** MATLAB  
**Development Status:** Under Active Development
