"""
Prime numbers were once considered boring (except for mathematicians) until public cryptography became popular in 1960's. Nowadays, people compete to find the largest prime number! The Sieve of Sundaram is a simple algorithm to find prime numbers up to a specific integer.
Write a function find_primes_sundaram(upto::Int) that returns an array of prime numbers up to the specified value. Submit your code with the number of prime numbers less than 100,000.
"""
function sieve_prime(n)
        n<=1 && return 0
        sieve_list=Dict(i => 0 for i in 1:n)
        for i in 1:n/2;j=i
            while((i+j+(2*i*j))<=n/2)
                                               sieve_list[i+j+(2*i*j)]=1
                                       j+=1
                                                                   end
            end
         sieve_number=filter(p->iszero(p.second),sieve_list)
         primes = 2*collect(keys(sieve_number)) .+1; [2;filter(p->p<=n, primes)]
end
