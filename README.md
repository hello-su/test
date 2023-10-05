# 2021.0193
# [An Approximation Algorithm for k-Depot Split Delivery Vehicle Routing Problem](https://doi.org/10.1287/ijoc.2021.0193)
This archive is distributed in association with the [INFORMS Journal on Computing](https://pubsonline.informs.org/journal/ijoc) under the MIT License.

## Abstract
 For an unbalanced cooperative game, its grand coalition can be stabilized by some instruments, such assubsidization and penalization, that impose new cost terms to certain coalitions. In this paper, we studyan alternative instrument, referred to as cost adjustment, that does not need to impose any new coalitionspecific cost terms. Specifically, our approach is to adjust existing cost coefficients of the game under which(i) the game becomes balanced so that the grand coalition becomes stable, (ii) a desired way of cooperation isoptimal for the grand coalition to adopt, and (iii) the total cost to be shared by the grand coalition is withina prescribed range. Focusing on a broad class of cooperative games, known as integer minimization games,we formulate the problem on how to optimize the cost adjustment as a constrained inverse optimizationproblem. We prove N P-hardness and derive easy-to-check feasibility conditions for the problem. Based ontwo linear programming reformulations, we develop two solution algorithms. One is a cutting-plane algorithm, which runs in polynomial time when the corresponding separation problem is polynomial time solvable. Theother needs to explicitly derive all the inequalities of a linear program, which runs in polynomial time whenthe linear program contains only a polynomial number of inequalities. We apply our models and solutionalgorithms to two typical unbalanced games, including a weighted matching game and an uncapacitatedfacility location game, showing that their optimal cost adjustments can be obtained in polynomial time.

## Key words
 cooperative game; grand coalition stability; cost adjustment; inverse optimization; integerminimization game; weighted matching game; uncapacitated facility location game.

## Instances and results
We have considered two classes of test instances, called Class P and Class SD, which can be found in the two folders "P set" and "SD set" of the subdirectory"data" of APPX/GREEDY/MIP, respectively. The specific illustration of instances can be found in the file "Data Format Description.txt"  in each folder for the two classes of instances. The source files for the method APPX  is in "APPX/src". The source files for the benchmark methods, i.e., methods MIP3600/MIP28800 and method GREEDY, are provided in "MIP/src" and "GREEDY/src", respectively. The methods APPX and GREEDY are coded with C++, and the MIP is coded with Python. Guidances for implementation can be found in the files "APPX/README.pdf", "MIP/README.pdf" and "GREEDY/README.pdf", respectively. Meanwhile, the results output by these three methods are available in folders“APPX/results”, “MIP/results” and “GREEDY/results” . Each folder also contains a script to verify the correctness of the results. Note that, to run the source code for the MIP in the folder "MIP/src", a license for Gurobi should be downloaded by following the instruction in "MIP/README.pdf" in the subdirectory "MIP". Finally, the source codes of the method APPX have used a standard algorithm from the Chinese Software Development Network (CSDN) to find a minimum perfect matching in a general graph. Due to the copyright issue, one may need to download the codes in CSDN, following the instruction shown in the file "APPX/README.pdf".

## Paper Entry
Xiaofan Lai, Liang Xu, Zhou Xu, Yang Du. ["An Approximation Algorithm for k-Depot Split Delivery Vehicle Routing Problem"](https://doi.org/10.1287/ijoc.2021.0193). INFORMS Journal On Computing, 2023.

## Cite
To cite this code, please cite the paper using its DOI and the code itself, using the following DOI.\
DOI:10.1287/ijoc.2021.0193.cd

Below is the BibTex for citing this version of the code.
~~~
@article{kdepotcode,
  title={An Approximation Algorithm for k-Depot Split Delivery Vehicle Routing Problem},
  author={Xiaofan Lai and Liang Xu and Zhou Xu and Yang Du},
  publisher={{INFORMS Journal on Computing}},
  year={2023},
  doi={10.1287/ijoc.2021.0193.cd},
  note={available for download at https://github.com/INFORMSJoC/2021.0193}
}
~~~
