"""
Due to elevated security concerns, we have decided to send all emails in an encrypted form! We will build a simple cipher to encode and decode messages with a passcode.
From an integer passcode, we can derive the shift variable n as follows:

𝑛 = (𝑝 mod 80) + 5
Here’s the task -
1) Create a function encode(s::String, passcode::Int) that encodes the string s by shifting n positions forward using the ASCII table in the range 0x21 (exclamation mark) and 0x7E (tilda). 
* If it the shifted position passes the last character in the range then it wraps around and starts from the beginning.
* If the character is originally out of range then do not do any translation and keep it the same.
2) Create a function decode(s::String, passcode::Int) that decodes the string s by shifting n positions backward.
For examples
encode("Hello", 9783) = "d#**-"
decode("d#**-", 9783) = "Hello"
Submit your code with the output of encode("WISER Rocks!") and decode the output to see if you get back the same thing.

"""
function encode(s,p)
       n=rem(p,80) +5
       str=map(Int,collect(s))
       j, min, max=[], 33, 126
      for i in str
       if(i<min)
       push!(j,i)
       elseif((i+n)<max)
      push!(j,i+n)
      else
      push!(j,(i+n)%max + min-1)
       end
       end
       mapreduce(Char,*,j)
       end

function decode(en,p)
              n=rem(p,80) +5
              str=map(Int,collect(en))
              j, min, max=[], 33, 126
              for i in str
                    if(i<min)
                    push!(j,i)
                   elseif((i-n)>=min)
                    push!(j,i-n)
                    else
                    push!(j,max -min+1+(i-n))
                    end
                    end
                    mapreduce(Char,*,j)
end
