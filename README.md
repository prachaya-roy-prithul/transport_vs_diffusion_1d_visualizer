# 1D Neutron Transport vs Diffusion Visualizer

This project is a small computational experiment to understand the 1D neutron transport equation and how it compares with the diffusion approximation.

The goal is not to build a high-fidelity transport code. Instead, the focus is to visualize how different terms of the transport equation behave and to observe where diffusion theory works reasonably well and where it begins to deviate.

The solver is written in MATLAB and was tested using MATLAB Online.


## Project idea

In reactor physics courses, the neutron transport equation is often introduced mainly through mathematical derivations. It can sometimes be difficult to connect those expressions to the underlying physical processes.

This project tries to make the equation more interpretable by:

- solving the steady-state 1D neutron transport equation
- visualizing the contributions of the main physical terms
- comparing the solution with the neutron diffusion approximation

The intention is to look at the equation not only as mathematics, but also as a balance of physical processes such as streaming, collisions, and scattering.


## Physics model

The code solves the steady-state monoenergetic neutron transport equation in 1D slab geometry

μ dψ(x,μ)/dx + Σt(x) ψ(x,μ) = (Σs(x)/2) φ(x) + Q(x)

where

- ψ(x,μ) is the angular neutron flux  
- φ(x) is the scalar neutron flux  
- Σt is the total macroscopic cross section  
- Σs is the scattering macroscopic cross section  
- Q(x) is an isotropic external source  

The scalar flux is obtained from the angular flux through

φ(x) = ∫ ψ(x,μ) dμ

For comparison, the project also solves the 1D neutron diffusion equation

− d/dx ( D dφ/dx ) + Σa φ = Q

with the diffusion coefficient approximated as

D ≈ 1 / (3 Σt)

The diffusion solution is used only as a qualitative comparison with the transport solution.


## Numerical method

The transport equation is solved using the discrete ordinates (Sₙ) method.

Main numerical steps:

- angular discretization using Gauss–Legendre quadrature  
- spatial discretization on a 1D slab mesh  
- source iteration to update the scattering source  
- angular sweeps using a first-order upwind scheme  

The diffusion equation is solved separately using a simple finite-difference formulation.

The diffusion boundary treatment is simplified and should be interpreted as an approximate comparison rather than a rigorous transport boundary condition.


## What the code visualizes

The project produces several plots that help interpret the transport solution.

Scalar flux comparison  
Transport scalar flux compared with the diffusion approximation.

Angular flux  
Angular neutron flux plotted for several discrete directions.

Transport equation terms  
For a selected angular direction, the following terms are plotted:

- streaming  
- removal (collision loss)  
- scattering source  
- external source  

This helps illustrate the balance of the transport equation in space.

Iteration convergence  
Relative change of the scalar flux during source iteration.

Transport–diffusion error  
Difference between the transport solution and the diffusion approximation.

Residual map  
A spatial–angular visualization of the discrete transport equation residual.


## Test cases

Three simple cases are included.

Case 1 — Highly scattering homogeneous slab  
A medium with a high scattering ratio. In this case the diffusion approximation tends to agree relatively well with the transport solution.

Case 2 — Moderately scattering homogeneous slab  
The scattering ratio is reduced, which typically increases the difference between transport and diffusion results.

Case 3 — Two-region heterogeneous slab  
The slab contains two materials with different cross sections. This case highlights how material interfaces influence neutron transport and how diffusion may smooth some of these effects.


## Example observations

Some general trends observed in the simulations include:

- Source iteration converges more slowly in highly scattering media.  
- Diffusion tends to underestimate the scalar flux peak near localized sources.  
- Relative diffusion errors increase near vacuum boundaries where the flux becomes small.  
- In heterogeneous systems, transport captures sharper behavior near material interfaces.


## Limitations

This project intentionally uses several simplifying assumptions:

- 1D slab geometry only  
- monoenergetic neutrons  
- isotropic scattering  
- fixed external source (no fission)  
- simplified diffusion boundary treatment  
- no acceleration methods for source iteration  

Because of these assumptions, the code should be viewed mainly as a learning tool rather than a detailed reactor physics simulation.


## Motivation

The motivation for this project was to better understand how the neutron transport equation behaves in practice. Visualizing the individual terms helped make the equation easier to interpret and provided a clearer comparison with the diffusion approximation.


## Possible extensions

Some natural extensions of this project could include:

- multi-group energy transport  
- anisotropic scattering models  
- improved diffusion boundary conditions  
- two-dimensional geometries  
- acceleration methods for source iteration

These were not included in order to keep the implementation relatively simple and easier to interpret.