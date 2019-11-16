Prerequisites
-------------

In order to be successful in this course, you will need to know how to program in Python. The expectation is that you have completed the first three courses in this Applied Data Science with Python series, specifically Course 1 on [Introduction to Data Science in Python](https://www.coursera.org/learn/python-data-analysis) and Course 3 on [Applied Machine Learning in Python](https://www.coursera.org/learn/python-machine-learning), so that you are familiar with the numpy and pandas Python libraries for data manipulation, and scikit-learn toolkit for machine learning algorithms.

Week by week
------------

In this course, you will build your skill sets in text mining through lectures on core topics, code walk-throughs on tasks related to weekly assignments, reading material, quizzes, and programming assignments.

In **Module One**, you will be introduced to basic text mining tasks, and will be able to interpret text in terms of its building blocks – i.e. words and sentences, and reading in text files, processing text, and addressing common issues with unstructured text. You will also learn how to write regular expressions to find and extract words and concepts that follow specific textual patterns. You will be introduced to UTF-8 encoding and how multi-byte characters are handled in Python. This week’s assignment will focus on identifying dates using regular expressions and normalize them.

In **Module Two**, you will delve into NLTK, a very popular toolkit for processing text in Python. Through NLTK, you will be introduced to common natural language processing tasks and how to extract semantic meaning from text. For this week’s assignment, you’ll get a hands-on experience with NLTK to process and derive meaningful features and statistics from text. 

In **Module Three**, you will engage with two of the most standard text classification approaches, viz. naïve Bayes and support vector machine classification. Building on some of the topics you might have encountered in Course 3 of this specialization, you will learn about deriving features from text and using NLTK and scikit-learn toolkits for supervised text classification. You will also be introduced to another natural language challenge of analyzing sentiment from text reviews. For this week’s assignment, you will train a classifier to detect spam messages from non-spam (“ham”) messages. Through this assignment, you will also get a hands-on experience with cross-validation and training and testing phases of supervised classification tasks.

In **Module Four**, you will be introduced to more advanced text mining approaches of topic modeling and semantic text similarity. You will also explore advanced information extraction topics, such as named entity recognition, building on concepts you have seen through Module One and Module Three of this course. The final assignment lets you explore semantic similarity of text snippets and building topic models using the gensim package. You will also experience the practical challenge of making sense of topic models in real life. 

------------------

> Reading for Regular Expressions

Regular expressions documentation in Python 3
Tips and tricks of the trade for cleaning text in Python
https://stanford.edu/~rjweiss/public_html/IRiSS2013/text2/notebooks/cleaningtext.html
https://www.analyticsvidhya.com/blog/2014/11/text-data-cleaning-steps-python/
http://ieva.rocks/2016/08/07/cleaning-text-for-nlp/
https://chrisalbon.com/python/cleaning_text.html

---------------
> Reading for LDA

The primary reference for the Latent Dirichlet Allocation (LDA) is the following. The first five pages (Pg nos. 993-997) describes the model and the plate notation.David M. Blei, Andrew Y. Ng, Michael I. Jordan; Latent Dirichlet Allocation. Journal of Machine Learning Research (JMLR); 3(Jan):993-1022, 2003.http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf

Also see the following Wikipedia pages on:

Latent Dirichlet Allocation: https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation
Description of the plate notation: https://en.wikipedia.org/wiki/Plate_notation
WordNet based similarity measures in NLTK: http://www.nltk.org/howto/wordnet.html

