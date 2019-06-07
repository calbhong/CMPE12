------------------------
Lab 4: Roman Numeral Conversion
CMPE 012 Spring 2019

Hong, Calvin
cbhong
------------------------
Can you validly represent the decimal value 1098 with Roman numerals usingonly I, V, X, and C?
	No; It's necessary to use M & L in this situation as M & L cannot be represented through 10C->1000 nor 5X->50.  
What was your approach for recognizing an invalid program argument?
	The way that I saw it was to compare the character of input at the index to one of the 5 ASCII values. If it matched one of the 5, then it would look at the following character and determine whether to add or subtract depending ie. if the current value is I and the following is V, then instead of 1+5->6, it becomes 1+3-> instead. 
What did you learn in this lab?
	I learned how grueling it is to have a lot of things planned within one week coupled with my own poor time management due to a lot of external factors. Though the lab did teach me the real barebones aspects of certain data types and how machines iterate through memory which I found really interesting. (I also learned that I really enjoy being a dealer at the exhibitor hall for conventions, pretty fun)
Did you encounter any issues? Were there parts of this lab you found enjoyable?
	I think my largest issue was approaching the problem in general. At firs tI felt that I didn't really know how to star toff granted that the way I work is that I can't really do much on my own without a tiny bit of hand holding. Given that I was bed-ridden for the last two weeks with on and off times of energy, labs weren't quite an option. In general, I think I figured out most of the lab on my own however with the occasional conversaiton with a friend of mine in regards to pesudocode, especially concerning the validation + num->int conversion. 
How would you redesign this lab to make it better?
	I would consider giving more convinient test cases as well as spciefiying some edge cases(ie. no input to throw an error). I can't say much sicne I haven't been able to attend too many physical labs in regards to this assignment, but I will say that instructions *could* be a little more clear. 
What resources did you use to complete this lab?
	Lots and lots of youtube videos + StackOverflow threads in regards to character comparison, iterating over arrays in MIPS, and the occasional "how do I do this" to a friend of mine.
Did you work with anyone on the labs? Describe the level of collaboration.
	A couple days before the lab was due my roommate did ask a couple times for help with the int->binary conversion, whereas I asked what was his appraoch to num->int conversion. I had also asked a close friend from a different school who had already take na similar course for his input on how my pseudocode was as well as anything that I could've fixed to expedite the process. Absolutely no actual assembly code was provided and everything was written in the abstract.