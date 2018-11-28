"""
Problem - Collatz

The Collatz problem is defined as follow, for n ?0, 1, 2, ...
 

Amazingly, for any positive integer a0, iterating the sequence will always return to 1.  For example, the sequence starting with 7 is {7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1}, which takes 16 steps.

Mandatory:
1.	Write a function `find_collatz(s::Int)` that returns the starting number a0 for which it takes exactly `s` steps to reach the value of 1.  Submit your answer with `find_collatz(500)`.
2.	Benchmark your solution.

"""
const colla =Dict()

function is_collatz(x); j=0
      if(get(colla,x,0) !=0)
              return colla[x]
      end;s=x
      while(s!=1)
              j+=1
              s = (s%2 ==0) ? s/2 : (3*s +1)
      end
      colla[x]=j;j
end
function find_collatz(s)
  if s ==0
       return 1
  else
       k=0
       i=1
       while (s != k)
       i+=1;k=is_collatz(i)
       end
       return i
  end
end
