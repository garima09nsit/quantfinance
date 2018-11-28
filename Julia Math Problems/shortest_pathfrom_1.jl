"""
JMG Super Hacker - Money Tree
If you start with \$1 and, with each move, you can either double your money or add another \\$1, what is the smallest number of moves you have to make to get to a target amount? 

Write a function grow(target::Int) that returns

Minimum number of steps to reach the target
A respective string that shows how to reach the target
An illustrated path that shows the actual money growth to the target
For example, to get to a target of \$10:

julia> grow(10)
(steps = 4, instructions = "+*+*", path = [1, 2, 4, 5, 10])
Submit your solution to get to a target of $123,456.
"""
const results=Dict(1=>(steps=0,path=[1],instructions=""))
function super_hacker(target)
    target in keys(results) && return(results[target].steps)
    results[target] = iseven(target) ? (steps=(1+super_hacker(div(target,2))),path=[target;results[target/2].path],instructions=(results[target/2].instructions*"*")) : (steps=(1+super_hacker((target-1))),path=[target;results[target-1].path],instructions=(results[target-1].instructions*"+"))
    results[target].steps
end
 
function grow(target:: Int)
       super_hacker(target)
       results[target]
end

@btime grow(123456)
  28.905 ns (0 allocations: 0 bytes)
(steps = 21, path = [123456, 61728, 30864, 15432, 7716, 3858, 1929, 1928, 964, 482  …  120, 60, 30, 15, 14, 7, 6, 3, 2, 1], instructions = "*+*+*+****+***+******")
