"""
Introduction
Anagrams
An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once. For example, the word “dog” can be rearranged into "god". Or for example, the word “binary” can be rearranged into "brainy".

Your Task
Write a function that returns true if the provided two words are anagrams, or returns false otherwise.  Don’t overthink this.  Perhaps it can be written in a single line of code? 

For example:
is_anagram(“iceman”, “cinema”) => true
is_anagram(“dog”, “cat”) => false

Here’s the extra credit.  You gain an additional golden star if you complete this 2nd part.

A list of dictionary words can be downloaded here https://github.com/tk3369/words/raw/master/words.txt 
Write a function `download_words` that downloads the file, lowercase everything, and returns the words as an array.
Then, write a function `find_anagrams` that finds all related anagrams for a word e.g.

julia> find_anagrams("iceman", words)
3-element Array{String,1}:
 "anemic"
 "cinema"
 "iceman"
"""
function is_anagram(a,b)
              sort(split(replace(lowercase(a)," "=>""),"")) == sort(split(replace(lowercase(b)," "=>""),""))
end

function download_words()
       map(lowercase, readlines(download("https://github.com/tk3369/words/raw/master/words.txt")))
end

find_anagram(a,words) = filter(r -> is_anagram(r,a), words)
