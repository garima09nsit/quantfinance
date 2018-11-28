"""
Greatest Common Divisor

Recursion is a fundamental computational technique that can make code beautiful and clean.  Many mathematical functions can be expressed in a recursive manner naturally.

There are two mandatory parts in this challenge:
1. Write a recursive function `mygcd(x::Int, y::Int)` that finds the greatest common divisor of two positive integers.
2. Benchmark your function against Julia and/or Python's built-in `gcd` function using the example below.

Here's the logic – 
The GCD of two positive numbers p and q is the same as the GCD of q and the remainder of p divided by q, for every p > q.

Example:
```
mygcd(102, 68) = 34
```

Test your code against these:
```
mygcd(20, 25) = 5
mygcd(4789084, 957196) = 388
```
"""
function mygcd(x, y)
       if x==0
            return 0
       elseif y==0
            return 0
       end
       small, big =x<y ? (x,y) : (y,x)
       (big%small == 0) ? small : mygcd(small,rem(big,small))
end
