# 2022.0268
# [Stabilizing Grand Cooperation via Cost Adjustment: An Inverse Optimization Approach](https://doi.org/10.1287/ijoc.2022.0268)
This archive is distributed in association with the [INFORMS Journal on Computing](https://pubsonline.informs.org/journal/ijoc) under the MIT License.

## Abstract
For an unbalanced cooperative game, its grand coalition can be stabilized by some instruments, such assubsidization and penalization, that impose new cost terms to certain coalitions. In this paper, we studyan alternative instrument, referred to as cost adjustment, that does not need to impose any new coalition specific cost terms. Specifically, our approach is to adjust existing cost coefficients of the game under which(i) the game becomes balanced so that the grand coalition becomes stable, (ii) a desired way of cooperation isoptimal for the grand coalition to adopt, and (iii) the total cost to be shared by the grand coalition is withina prescribed range. Focusing on a broad class of cooperative games, known as integer minimization games,we formulate the problem on how to optimize the cost adjustment as a constrained inverse optimizationproblem. We prove N P-hardness and derive easy-to-check feasibility conditions for the problem. Based ontwo linear programming reformulations, we develop two solution algorithms. One is a cutting-plane algorithm, which runs in polynomial time when the corresponding separation problem is polynomial time solvable. Theother needs to explicitly derive all the inequalities of a linear program, which runs in polynomial time whenthe linear program contains only a polynomial number of inequalities. We apply our models and solutionalgorithms to two typical unbalanced games, including a weighted matching game and an uncapacitatedfacility location game, showing that their optimal cost adjustments can be obtained in polynomial time.

## Key words
cooperative game; grand coalition stability; cost adjustment; inverse optimization; integerminimization game; weighted matching game; uncapacitated facility location game.

## Instances and results

We consider two specific test instances of CIOP, called WMG and UFL, which can be found in the folders "WMG" and "UFL," respectively. The specific descriptions of the instances can be found in the file "Data Format Description.txt" in each folder for the two classes of instances. The methods are coded in Matlab. The source files can be found in the subfolders "WMG/src" and "UFL/src," respectively. Guidance for implementation can be found in the files "WMG/README.pdf" and "UFL/README.pdf," respectively. Meanwhile, the results of the two specific instances are available in the folders "WMG/results" and "UFL/results." Note that to run the source code for the UFL instances in the folder "UFL/src," a license for Gurobi should be downloaded.
  

## Paper Entry
Lindong Liu, Xiangtong Qi, Zhou Xu. ["Stabilizing Grand Cooperation via Cost Adjustment: An Inverse Optimization Approach"](https://doi.org/10.1287/ijoc.2022.0268). INFORMS Journal On Computing, 2023.

## Cite
To cite this code, please cite the paper using its DOI and the code itself, using the following DOI.\
DOI:10.1287/ijoc.2022.0268.cd

Below is the BibTex for citing this version of the code.
~~~
@article{kdepotcode,
  title={Stabilizing Grand Cooperation via Cost Adjustment: An Inverse Optimization Approach},
  author={Lindong Liu and Xiangtong Qi and Zhou Xu},
  publisher={{INFORMS Journal on Computing}},
  year={2023},
  doi={10.1287/ijoc.2022.0268.cd},
  note={available for download at https://github.com/INFORMSJoC/2022.0268}
}
~~~
