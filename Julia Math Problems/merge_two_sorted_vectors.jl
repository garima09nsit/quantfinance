"""
It’s year 2099, the world is coming to an end.  The aliens from the most distant galaxy GN-Z11 finally find a way to travel to our planet in a split second using “spooky action at a distance” technique.  As the aliens have more advanced weapons, the civilization on earth is doomed….. 

Fortunately, our world coalition leaders came to a meeting and negotiated a deal with the aliens.   The aliens are craving computer algorithms and if we are able to write a fast enough algorithm to solve the following problem then they have agreed to leave and never come back again!

So what do we do?  Let’s work together to save the world!
…..

Write a function merge(x::Vector{Int}, y::Vector{Int}) that combines two sorted arrays into a single sorted array.  An easy way to check if you have a fast enough program is when you are able to match or beat the built-in sort functions in Julia/Python/etc.

For performance benchmarking, please create your own input data of 1mm random positive integers as follows:

Julians:
x = sort(rand(1:1_000_000, 1_000_000))
y = sort(rand(1:1_000_000, 1_000_000))
"""
function merge2(x,y)
     x_len, y_len,j, k, result, i =length(x),length(y), 0, 0, zeros(Int,length(x)+length(y)), 0
     while((j<x_len) && (k<y_len))
           result[i+=1]=x[j+1]<y[k+1] ? x[j+=1] : y[k+=1]
     end
     result[i+1:end]=isempty(x[j+1:end]) ? y[k+1:end] : x[j+1:end]
     result
end
