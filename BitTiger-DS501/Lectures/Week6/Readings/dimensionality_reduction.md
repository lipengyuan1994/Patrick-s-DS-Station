# Dimensionality Reduction

Dimensionality Reduction is exactly what it sounds like. These are techniques for reducing the dimensions.


1. [Basics of Dimensionality Reduction](#basics-of-dimensionality-reduction)
2. [Principal Components Analysis (PCA)](#principal-components-analysis-pca)
3. [Singular Value Decomposition (SVD)](#singular-value-decomposition-svd)
4. [Relationship between PCA and SVD](#relationship-between-pca-and-svd)
5. [SVD for topic analysis](#svd-for-topic-analysis)


## Basics of Dimensionality Reduction

### Why do we want to reduce the dimensions?

1. Remove multicolinearity
2. Deal with the *curse of dimensionality*
3. Remove redundant features
4. Interpretation & visualization
5. Make computations of algorithms easier
6. Discover hidden topics

### Standardize your dataset
We will always start by standardizing the dataset. This means:

1. Center the data for each feature at the mean (so we have mean 0)
2. Divide by the standard deviation (so we have std 1)

### Covariance Matrix
Recall that the covariance matrix is given by:

![Covariance](images/covariance.png)

Note that this is only true because the data is centered around the mean.

#### Example
This is our feature matrix:

![Feature Matrix](images/feature_matrix.png)

This is the feature matrix after we standardize it:

![Normalized Feature Matrix](images/normalized_feature_matrix.png)

This is the covariance matrix:

![Example Covariance Matrix](images/example_covariance_matrix.png)

This tells us that the *covariance* between feature 1 and feature 2 is 0.801. This intuitively makes sense, since we can tell the two features are correlated.

The variance of each feature is 1 (this is because we standardized our data first).

The computations are done below with Python.


```python
import numpy as np
from sklearn.preprocessing import StandardScaler

data = np.array([[10., 3.],
                 [10., 4.],
                 [40., 7.],
                 [60., 6.],
                 [70., 9.],
                 [100., 7.],
                 [100., 8.]])

M = StandardScaler().fit_transform(data)
print "M:"
print M
print
print "covariance matrix:"
print 1 / 7. * M.T.dot(M)

plt.scatter(M[:,0], M[:,1])
plt.show()
```

Output:

    Populating the interactive namespace from numpy and matplotlib
    M:
    [[-1.30639453 -1.65988202]
     [-1.30639453 -1.15470054]
     [-0.44907312  0.36084392]
     [ 0.12247449 -0.14433757]
     [ 0.40824829  1.37120689]
     [ 1.2655697   0.36084392]
     [ 1.2655697   0.8660254 ]]

    covariance matrix:
    [[ 1.          0.80138769]
     [ 0.80138769  1.        ]]


![Scatterplot](images/scatter.png)


## Principal Components Analysis (PCA)

Usually we will get a covariance matrix with a lot of large values. Our ideal would be one where all the non-diagonal values are 0. This means that there is *no relationship between the features*. We can do a transformation of this data to make this happen!

The ideal convariance matrix would look something like this:

![Ideal Covariance Matrix](images/example_ideal_covariance_matrix.png)

The idea is to find a new set of axes (a *basis*) that better fit the data.

We choose the first principal component to be in the direction of the most variance. Here's a look at what we're doing:

![Correlated 2D](images/correlated_2d.png)

The green line here is the direction with the most variance. This is our first axis.

Note that we choose the second dimension (the pink line) to be orthogonal (perpendicular) to the first. There is no covariance between the two features after we rotate the data:

![Uncorrelated 2D](images/uncorrelated_2d.png)

### PCA Mathematically

Our goal is to find a transformation matrix *V* which when applied to *M* gives us our ideal convariance matrix:

![Ideal Covariance Matrix](images/ideal_covariance_matrix.png)

*V* is the new basis so it should look like this:

![Basis](images/basis.png)

Note that the set of *u<sub>i* makes up an *orthonormal* basis.

*orthonormal* means:

1. Vectors are normal (perpendicular) with each other. This means their dot products are 0.
2. Vectors have norm 1. This means the dot product with itself is 1.

So the following is true:

![Covariance Matrix](images/VTV.png)

![Covariance Matrix](images/VTV_identity.png)

So *V* times its transpose is the identity matrix!

Back to the original equation of our ideal world:

![Covariance Matrix](images/covariance_matrix.png)

![Covariance Matrix](images/solve_covariance_matrix.png)

Taking just one of these vectors out, we get:

![Eigenvalues](images/eigenvalues.png)

So we are looking for the ***eigenvalues*** (*λ<sub>i</sub>*) and ***eigenvectors*** (*u<sub>i</sub>*).

### Summary of PCA

To get the transformation, we need to find the eigenvalues and eigenvectors of:

![Covariance Matrix](images/MTM.png)

The eigenvectors are the new basis. The eigenvalues are the variance in each of these dimensions.

If we would like to reduce the number of dimensions, we can just get rid of the smallest of the lambdas. To determine how many to keep, we often look at the *scree plot*, a plot of the variances (eigenvalues, also called *loadings*) in increasing order.

#### Example (MNIST)

The MNIST dataset has digits stored as 28 × 28 pixel images. This means there are 784 features. We can use PCA to reduce the dimensions. This is the scree plot:

![Scree Plot](images/screeplot.png)

You are generally looking for the elbow in the graph. Here it's around 25 that you stop gaining value from adding more features. You might even be able to get by with just 1 feature!

We can get a visual understanding of how much information is kept with each principal component by looking at the visual representation of the first eigenvector. We also here look at the first 10, 50 and 250 eigenvectors.

![MNist 3](images/mnist_three.png)

We also often talk about keeping 80-90% of the variance.


## Singular Value Decomposition (SVD)

It's not always easy to directly compute the eigenvalues and eigenvectors. We can use a technique called SVD for more efficient computation. SVD is also useful for discovering hidden topics or ***latent features***.

Every matrix has a *unique* decomposition in the following form:

![SVD](images/SVD.png)

where
* *U* is column orthogonal: *U<sup>T</sup>U = I*
* *V* is column orthogonal: *V<sup>T</sup>V = I*
* *Σ* is a diagonal matrix of positive values, where the diagonal is ordered in decreasing order

We can reduce the dimensions by sending the smaller of the diagonals to 0.

## Relationship between PCA and SVD

In PCA, we have the following:

![PCA](images/pca_lambda.png)

In SVD we have:

![SVD](images/SVD.png)

No we can get the following:

![SVD to PCA](images/svd_to_pca.png)

Note that this is the same equation as with PCA, we just have:

![SVD to PCA](images/svd_to_pca2.png)

Note:

- The columns of *U* are the eigenvectors of *MM<sup>T</sub>* 
- The columns of *V* are the eigenvectors of *M<sup>T</sup>M* 
- *Σ* is a diagonal matrix and its diagonal values are the
  square roots of the eigenvalues of both *MM<sup>T</sub>* and *M<sup>T</sup>M*.

## SVD for topic analysis

We can use SVD to determine what we call ***latent features***. This will be best demonstrated with an example.

#### Example

Let's look at users ratings of different movies. The ratings are from 1-5. A rating of 0 means the user hasn't watched the movie.

|           | Matrix | Alien | Serenity | Casablanca | Amelie |
| --------- | ------ | ----- | -------- | ---------- | ------ |
| **Alice** |      1 |     1 |        1 |          0 |      0 |
|   **Bob** |      3 |     3 |        3 |          0 |      0 |
| **Cindy** |      4 |     4 |        4 |          0 |      0 |
|   **Dan** |      5 |     5 |        5 |          0 |      0 |
| **Emily** |      0 |     2 |        0 |          4 |      4 |
| **Frank** |      0 |     0 |        0 |          5 |      5 |
|  **Greg** |      0 |     1 |        0 |          2 |      2 |

Note that the first three movies (Matrix, Alien, Serenity) are Sci-fi movies and the last two (Casablanca, Amelie) are Romance. We will be able to mathematically pull out these topics!

Let's do the computation with Python.

```python
from numpy.linalg import svd

M = np.array([[1, 1, 1, 0, 0],
              [3, 3, 3, 0, 0],
              [4, 4, 4, 0, 0],
              [5, 5, 5, 0, 0],
              [0, 2, 0, 4, 4],
              [0, 0, 0, 5, 5],
              [0, 1, 0, 2, 2]])

u, e, v = svd(M)
print M
print "="
print np.around(u, 2)
print np.around(e, 2)
print np.around(v, 2)
```

Output:

    [[1 1 1 0 0]
     [3 3 3 0 0]
     [4 4 4 0 0]
     [5 5 5 0 0]
     [0 2 0 4 4]
     [0 0 0 5 5]
     [0 1 0 2 2]]
    =
    [[-0.14 -0.02 -0.01  0.56 -0.38 -0.7  -0.19]
     [-0.41 -0.07 -0.03  0.21  0.76 -0.26  0.38]
     [-0.55 -0.09 -0.04 -0.72 -0.18 -0.34 -0.09]
     [-0.69 -0.12 -0.05  0.34 -0.23  0.57 -0.12]
     [-0.15  0.59  0.65  0.    0.2   0.   -0.4 ]
     [-0.07  0.73 -0.68  0.    0.    0.    0.  ]
     [-0.08  0.3   0.33  0.   -0.4   0.    0.8 ]]
    [ 12.48   9.51   1.35   0.     0.  ]
    [[-0.56 -0.59 -0.56 -0.09 -0.09]
     [-0.13  0.03 -0.13  0.7   0.7 ]
     [-0.41  0.8  -0.41 -0.09 -0.09]
     [-0.71  0.    0.71  0.    0.  ]
     [ 0.   -0.    0.   -0.71  0.71]]

Here's the results we get:

![SVD Example](images/svd_example.png)

Note that the last two singular values are 0, so we can drop them. Note that these values are 0 because the rank of our original matrix is 3.

![SVD Example](images/svd_example2.png)

You can see the two topics fall out:

1. Science Fiction
    * First singular value (12.4)
    * First column of the *U* matrix (note that the first four users have large values here)
    * First row of the *V* matrix (note that the first three movies have large values here)
2. Romance
    * Second singular value (9.5)
    * Second column of the *U* matrix (note that the last three users have large values here)
    * Second row of the *V* matrix (note that the last two movies have large values here)

*U* is the ***user-to-topic*** matrix and *V* is the ***movie-to-topic*** matrix.

The third singular value is relatively small, so we can exclude it with little loss of data. Let's try doing that and reconstruct our matrix!

![SVD Example](images/svd_example3.png)
