# FEA_problems
 A bunch of MATLAB codes solving simple linear finite element problems.

<!--

-->







<!-- WHAT -->
## What


A code solving in-plane-loading problem of a specific rectangular geometry plate.

## Why

A simple academic code that may help to get back to when solving similar problems.

### How

The geometry in question is defined like :
<!-- Geom -->
<br />
<p align="center">
  <a href="https://github.com/azzeddinetiba/FEA_problems">
    <img src="Results/geometry.PNG" alt="Geom" width="200" height="200">
  </a>
</p>

* Then choose your material properties, thickness and your geometry following the rule above in _problem_1/main.m_:
```sh
A=1;
B=4;
C=1;
D=2;
E=1;
f = 0.5 * 100 ;
Young=2e11;
nu=0.3;
h=0.2e-2;
```
Or your material thermal conductivity, thickness and heat conduction coefficient in _problem_2/Main2D.m_
* Then run _first_problem.m_ or _second_problem.m_ :

```sh
% Inputs
%------------------------
A=1;
B=4;
C=1;
D=2;
E=1;
elem=0;
k=1;
f=0;
h=0.2e-2;
Ngauss=4;
gamma=0;
heat_conduction = 237;
Area = h*10e-2;
alpha = heat_conduction * Area;
%------------------------------
```


* You get something like :
<!-- Result -->
<br />
<p align="center">
  <a href="https://github.com/azzeddinetiba/FEA_problems">
    <img src="Results/Results_pb1/RF.PNG" alt="RF" width="200" height="200">
  </a>
</p>

<!-- Result -->
<br />
<p align="center">
  <a href="https://github.com/azzeddinetiba/FEA_problems">
    <img src="Results/Results_pb1/DEPL.PNG" alt="DEPL" width="200" height="200">
  </a>
</p>

<!-- Result -->
<br />
<p align="center">
  <a href="https://github.com/azzeddinetiba/FEA_problems">
    <img src="Results/Results_pb2/Flux.PNG" alt="Flux" width="200" height="200">
  </a>
</p>

<!-- Result -->
<br />
<p align="center">
  <a href="https://github.com/azzeddinetiba/FEA_problems">
    <img src="Results/Results_pb2/TEMP.PNG" alt="TEMP" width="200" height="200">
  </a>
</p>

### Again, What
 
* The first problem is solving and displaying :
    * Topology matrix display
    * Maximum deflection
    * Reaction force at nodes
    * Stress tensor at nodes _and_ Gauss points
    * Von Mises stress and principal stress at integration points

* The second problem is solving and displaying :
    * Temperature field
    * Heat flux


<!-- CONTACT -->
## Contact

TIBA Azzeddine - [Portfolio](https://portfolium.com/AzzeddineTiba/portfolio) - azzeddine.tiba@gmail.com

