# American-put-Binomial-tree

code.R contains the full code

You should represent the tree using a matrix.Since the tree is re-combining
and homogenous, the paths udu; duu; uud are exchangable;they end at the same point. This means the different nodes of a 4-period (t = 0; 1; 2; 3; 4) tree can be represented as a the upper triangle of a 5 * 5 matrix as follows

![Binomial Tree](https://github.com/leekh08/American-Put-Binomial-Tree/blob/main/binomial%20tree.PNG)

So, the exchangable states udu; duu; uud are represented by the second row and fourth column of the matrix ([2,4]), while the state dddd is represented by the fifth row and fifth column of the matrix ([5,5])

The programme should print the no arbitrage, time zero American put price.
