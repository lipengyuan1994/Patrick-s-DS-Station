# Environment Setup for Data Science in Python

BitTiger DS501

---

The course will heavily use Python.  It is not necessary to be an expert in Python coming into the course (that is what we will teach you!) but it is helpful to be familiar with its syntax.

Not everyone knows Python. We provide resources here to get you situated with Python environment and to bring you up to speed with Python quickly.

## Install Python 3 and its modules
### Option 1: Install Anaconda (Recommended)

We will be using [Anaconda](https://store.continuum.io/cshop/anaconda/) with Python version 3.6. Install this and you will have Python along with several useful packages and programs:

* NumPy
* SciPy
* Pandas
* Sklearn
* MatPlotLib
* IPython

You can see the [full list of packages](http://docs.continuum.io/anaconda/pkg-docs.html).

You should install Anaconda now. Read the [docs](https://docs.continuum.io/anaconda/install) if you don't know how to install.

### Option 2: Use virtualenv (Only for those with some experience)

If you are familiar with command line interface (CLI) and [virtualenv](https://virtualenv.pypa.io/en/stable/), and you are so inclined to manage your Python modules yourself, you can use virtualenv, for example, to create and activate a virtualenv on Linux/MacOS you do

```
$ virtualenv venv
$ source venv/bin/activate
```

and you use pip to install any packages:

```
$ pip install numpy
$ pip install scipy
$ pip install pandas
$ pip install sklearn
$ pip install matplotlib
$ pip install ipython[all]
```

## Jupyter Notebook (f.k.a. IPython Notebook)

[Jupyter Notebook](http://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/) will be our main tool for interactive programming process, including: developing, documenting, and executing code, as well as communicating the results.

You can either start Jupyter Notebook from Anaconda GUI or from CLI. For example, on Linux and MacOS:
```
$ jupyter notebook
```

Jupyter Notebook will be launched on your browser.


## Text Editor (optional)

You are welcome to use any editor you'd like. Below are two general purpose text editors, commonly used by data scientists and software engineers.

### Sublime 

You can download [Sublime Text](http://www.sublimetext.com/2) for free.

### Atom 

You can download [Atom](https://atom.io/) for free.


---
<br>

## Learn Python

### Resources

If you feel new to python, you might benefit from looking at one of these resources:

* [Think Python](http://greenteapress.com/wp/think-python/)
* [Dive Into Python](http://www.diveintopython.net/)
* [Learn Python the Hard Way](http://learnpythonthehardway.org/)

Python also has great documentation.

The [Python tutorial](https://docs.python.org/3/tutorial/) and [Python library](https://docs.python.org/3/library/) are great resources if you need to look up how something is done in Python.

### What you need to know

##### Eventually you should be comfortable with everything below.

* Basic data structures and associated methods
    * int, float
    * string
    * list
    * dict
    * set
    * range
* Control structures
    * if, elif, else
    * while
    * for
    * break, continue, pass
* Enumerations
    * for loops
    * list comprehensions
    * enumerate
    * zip
* Functions
    * Declaration
    * Calling
    * Keyword arguments
* Object orientation
    * Classes
    * Methods
    * Properties (instance variables)
    * self
* Modules
    * import
    * aliasing (`import pandas as pd`)
    * global import (`from pandas import *`)
* IO
    * Read a file
    * Write to a file
