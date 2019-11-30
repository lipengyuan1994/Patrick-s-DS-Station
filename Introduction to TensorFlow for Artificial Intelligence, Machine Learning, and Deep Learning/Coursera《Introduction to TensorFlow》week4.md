## Using Real-world Images

Coursera《Introduction to TensorFlow for Artificial Intelligence, Machine Learning, and Deep Learning》week4 quiz:

## Coursera[link to this course](https://www.coursera.org/learn/introduction-tensorflow/)

## Q1

1. Using Image Generator, how do you label images?

  ***A. It’s based on the directory the image is contained in***
 B. You have to manually do it
 C. It’s based on the file name
 D. TensorFlow figures it out from the contents

  **答案：A**

## Q2

1. What method on the Image Generator is used to normalize the image?

  A. Rescale\_image
 B. normalize
 C. normalize\_image
***D. rescale***

  **答案：D**

## Q3

1. How did we specify the training size for the images?

  A. The training\_size parameter on the validation generator
***B. target\_size parameter on the training generator***
 C. The target\_size parameter on the validation generator
 D. The training\_size parameter on the training generator

  **答案：B**

## Q4

1. When we specify the input\_shape to be (300, 300, 3), what does that mean?

  A. Every Image will be 300x300 pixels, and there should be 3 Convolutional Layers
***B. Every Image will be 300x300 pixels, with 3 bytes to define color***
 C. There will be 300 horses and 300 humans, loaded in batches of 3
 D. There will be 300 images, each size 300, loaded in batches of 3

  **答案：B**

## Q5

1. If your training data is close to 1.000 accuracy, but your validation data isn’t, what’s the risk here?

  A. No risk, that’s a great result
 B. You’re overfitting on your validation data
***C. You’re overfitting on your training data***
 D. You’re underfitting on your validation data
**答案：C**

## Q6

1. Convolutional Neural Networks are better for classifying images like horses and humans because:

  A. In these images, the features may be in different parts of the frame 
 B. There’s a wide variety of horses
 C. There’s a wide variety of humans
***D. All of the above***

  **答案：D**

## Q7

1. After reducing the size of the images, the training results were different. Why?

  ***A. We removed some convolutions to handle the smaller images***
 B. There was more condensed information in the images
 C. The training was faster
 D. There was less information in the images

  **答案：A**