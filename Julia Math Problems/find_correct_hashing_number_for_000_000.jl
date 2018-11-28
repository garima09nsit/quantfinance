"""
Problem – The Julian Coin

 

Bitcoin is going crazy these days and mining a new coin is becoming more and more difficult.  Why chase after the hot stuff?  We have something easier here!

Introducing the Julian Coin - it's easy to mine and it's based upon a common hashing algorithm called MD5.  Each coin can be discovered from a secret.  To start mining, concatenate the secret with a positive integer and run it through the MD5 hashing algorithm.  You get the coin by finding the smallest number that gives you a hash code both starting and ending with 3 zeros.  (You may use an existing MD5 library.)

For examples:

•	Secret `hello` requires `6144434` to get the coin
•	Secret `julia` requires `1436069` to get the coin

Let's prove it from the Unix terminal:

$ echo -n "hello6144434" | md5sum
0006a1061ece946b7e95c2af73773000 

$ echo -n "julia1436069" | md5sum
000d02cb0a523a25820ea72bb959d000

Can you mine the Julian Coin with secret western?  Write a function `mine_julian_coin(s::String)` that returns the number and the corresponding hash code for the western Julian coin eg.

julia> mine_julian_coin("hello")
        (key = 6144434, hash = "0006a1061ece946b7e95c2af73773000")
"""
function mine_julian_coin(str)
     for i in 1:typemax(Int)
              md5_d =bytes2hex(md5(str*string(i)));if startswith(md5_d,"000") && endswith(md5_d,"000")
              return(i)
     end;end;end
