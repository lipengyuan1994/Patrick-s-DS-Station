# Clustering

We're going to be talking about two clustering algorithms: K Means and Heirarchical. These algorithms are used to cluster similar data together. This is a form of *unsupervised learning*, meaning that we don't have a label or value to predict.

0. [Clustering Problem](#clustering-problem)
1. [K-means](#k-means)
2. [Hierarchical Clustering](#hierarchical-clustering)

## Clustering Problem

Divide data into **distinct subgroups** such that observations within each group are similar.

![](images/clusters.png)

## K-means
In the k-means algorithm, we create k clusters of our data. This is how the algorithm works:

```
Choose k random points to be the centroid of the k clusters.
Repeat until clusters stop changing:
    For every data point in the dataset, determine which centroid it is closest
        to and assign it to that cluster.
    Update the centroids to be the new center of all the points in that cluster
        (just take the arithmetic mean)
```

#### Calculating distance
We use Euclidean distance to calculate the closest centroid for each point:

![euclidean distance](images/euclidean_distance.png)

We can also think of it as a measure of the amount of variance within a cluster, so our goal is to minimize this variance.

#### Initializing the centroids
Every time you run K-means on the same dataset, you will not necessarily get the same clusters in the end. The clusters depend on the initial centroids!

In practice, we use an algorithm called K-means++ which is smarter about choosing the centroids. Here is the algorithm for choosing the centroids:

```
Choose one centroid at random.
Repeat until all centroids have been chosen:
    For each datapoint, compute the distance from x to all the centroids that
        have been chosen so far. Find the minimum distance, call it D(x).
    Choose the next centroid at random, using a weighted probability
        distribution where a point is chosen with probability proportional to
        D(x)^2.
```

This replaces the first step of the standard k-means algorithm.

#### The k-means Algorithm

![The k-means algorithm.](images/kmeans.png)

#### The Curse of Dimensionality

Random variation in extra dimensions can many hide significant differences between clusters.

The more dimensions there are, the worse the problem.

More than 10 dimensions: consider PCA first.


### How Many Clusters?

![](images/unsplitcluster.png)

#### Choosing K

![](images/6clusters.png)

Can we use within-cluster sum of squares (WCSS) to choose k? More clusters *implies* lower WCSS

Several measures for the "best" K - no easy answer

 * The Elbow Method
 * Silhouette Score
 * GAP Statistic

#### Choosing K -- The Elbow Method

![](images/elbow.png)

#### Choosing K -- Silhouette Score

![](images/silhouettescores.png)


#### Choosing K -- GAP Statistic

![](images/gap_statistics.png)


## Hierarchical Clustering

A big drawback of k-means is that we have to choose k. How do we really know how many clusters our data should have? A different approach is hierarchical clustering.

![](images/letters-ungrouped.png)

Hierarchical clustering is a type of clustering algorithm where we build nested clusters. We represent this hierarchy as a tree or a dendrogram.

![](images/letters-grouped.png)

![](images/letters-dendrogram.png)

### Hierarchical Clustering Algorithm

```
Assign each point to its own cluster
Repeat:

	Compute distances between clusters
	Merge closest clusters

 	...until all are merged
 ```

How do we define dissimilarity between clusters?

#### Hierarchical Clustering -- Linkage

How do we define dissimilarity between clusters?

* **Complete:** Maximum pairwise dissimilarity between points in clusters -- good
* **Average:** Average of pairwise dissimilarity between points in clusters -- also good
* **Single:** Minimum pairwise dissimilarity between points in clusters -- not as good; can lead to long narrow clusters
* **Centroid:** Dissimilarity between centroids -- used in genomics; risk of inversions


We end up with something like this:
![dendrogram](images/sortingDendrogram.png)

From a dendrogram, we can get different clusters by choosing a different break point.

Hierarchical clustering is more computationally expensive that k-means. Dendrograms also aren't useful if you have too much data to visualize.


