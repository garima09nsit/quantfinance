"""
Problem

1/1 + 1/4 + 1/9 + 1/16 + … = pi / 6

This is an interesting one because the sum converges to a number that relates to pi.  There are several ways to prove that although I like this one the most https://www.youtube.com/watch?v=d-o3eB9sfls).

Write a function `mypi` that takes a single argument `n`, where `n^2` represents the denominator for each term in the series.  The function should return the value of pi.

There are a couple of ways to implement this function - most conventionally a for-loop if you are used to iterative programming style.  Once you have the correct solution, try to implement it with functional programming techniques… perhaps you can do it with a single line of code!

Submit your code to tkwong@westernasset.com with results from `mypi(1000)`.
"""
mypi(x)  =  sqrt(sum(map(t -> (1/t^2), 1:x)) * 6)