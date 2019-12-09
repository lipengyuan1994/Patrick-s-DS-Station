Natural Language Processing in TensorFlow
Week 3
# Week 3 Quiz

# Sequence models



People are making progress
848 learners have recently completed this assignment
Submit your assignment
DUEDec 30, 2:59 AM EST
ATTEMPTS3 every 8 hours
Receive grade
TO PASS80% or higher
Grade
—


## 1.Question 1
Why does sequence make a large difference when determining semantics of language?


Because the order in which words appear dictate their meaning


**Because the order in which words appear dictate their impact on the meaning of the sentence**


Because the order of words doesn’t matter


It doesn’t

1 point

## 2.Question 2
How do Recurrent Neural Networks help you understand the impact of sequence on meaning?


They don’t


They look at the whole sentence at a time


**They carry meaning from one cell to the next**


They shuffle the words evenly

1 point

## 3.Question 3
How does an LSTM help understand meaning when words that qualify each other aren’t necessarily beside each other in a sentence?


They shuffle the words randomly


They load all words into a cell state


**Values from earlier words can be carried to later ones via a cell state**


They don’t

1 point

## 4.Question 4
What keras layer type allows LSTMs to look forward and backward in a sentence?


Unilateral


Bothdirection


**Bidirectional**


Bilateral

1 point

## 5.Question 5
What’s the output shape of a bidirectional LSTM layer with 64 units?


(128,1)


**(None, 128)**


(None, 64)


(128,None)

1 point

## _6.Question 6_
When stacking LSTMs, how do you instruct an LSTM to feed the next one in the sequence?


Do nothing, TensorFlow handles this automatically


Ensure that return_sequences is set to True on all units


**Ensure that return_sequences is set to True only on units that feed to another LSTM**


Ensure that they have the same number of units

1 point

## 7.Question 7
If a sentence has 120 tokens in it, and a Conv1D with 128 filters with a Kernal size of 5 is passed over it, what’s the output shape?


(None, 120, 128)


**(None, 116, 128)**


(None, 120, 124)


(None, 116, 124)

1 point

## 8.Question 8
What’s the best way to avoid overfitting in NLP datasets?


Use LSTMs


Use GRUs


Use Conv1D


**None of the above**

1 point