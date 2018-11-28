"""
Problem - Monte Carlo Simulation

I would be ashamed not knowing how to run Monte Carlo simulation here!

Give the function f(x) = sin(pi * x), let’s find the area under the curve between x = 0 and x = 1.  That’s quite easy using Calculus but let’s solve it numerically.  

Write a function `sine_area` that uses Monte Carlo simulation to find the area under the curve.  The function should take a single argument for the number of simulations.  Submit your answer by running `sine_area(10000)`.  (For those who love math, prove that your answer is correct by calculating the definite integral manually.)
"""
function sine_area(N)
    count=0.0
    for (t,s) in zip(rand(N),rand(N))
      if (s<=sin(t* pi))
        count+=1.0
      end
    end 
                count/N
end
