/////////////////////////////
// Tips and tricks for Stata
/////////////////////////////

clear
cls

// 0.0.copy your do-file to a do-file folder so that you have a backup and can easily access all your do-files in same place
capture noisily copy "YOUR DIRECTORY_A\Stata_Workflow_practice.do" "YOUR DIRECTORY_B\Stata_Workflow_practice_1.do",replace

////////////////////////////////////////////
// 1.0 Switch between windows and run code
////////////////////////////////////////////

//Run one line
* Ctrl + Enter
sysuse auto

// run multiple  between braces
* Alt + Enter
{
list
h br
br
scatter mpg weight, name(kalevi, replace)
}


// Move between windows
*Stata main   		win + CAPS
*Do-file 			win + shift
*Stata -> Do-file	win + <
*Editor  			win + Q
*Graph   			win + A
*Viewer 			win + Z
*Toggle all 		alt + 1


////////////////////////////////////////////////
// 2.0 Type faster
// Try out the following commands below - Shortcut chart will be useful
////////////////////////////////////////////////


// `'
* Ctrl + ´


// ///
* Ctrl + 7


// {}
* Ctrl + 0


// readSHARE *, w(7) mod()
* Ctrl + ,


* readSHARE setup instructions:
* view browse https://gist.github.com/samuelsaari/1ff20b8b7d70e01706f07f25f96914dc

////////////////////////////////////////////////
// 3.0 Looping strategies
////////////////////////////////////////////////

//////////////////////
// 3.1 Simple looping


foreach x in 1 2 3 {
di "`x'"
}

sysuse auto
foreach x of varlist m* {
tab `x'
}

/*
*useful in inspecting survey data
readSHARE *, w(7) mod(ep)
foreach x of varlist ep671* {
tab `x'
}
*/

//////////////////////
// 3.2 Nested or "Polyamoric" looping
{
foreach y in "Ridge" "Eric" "Rick"  {
foreach x in "Brooke" "Taylor" "Stephanie" {
di "`y' and `x'"
}
}
}

////////////////////////////////
// 3.3 Parallel or "Monogamic" looping - A
{
for Y in any "Romeo" "Simba" "Alladin" ///
	\  X in any "Julia" "Nala" "Esmarla", noheader: di "Y and X"
}

*legacy documentation
*view browse "https://www.stata.com/statalist/archive/2014-04/msg00243.html"


// Parallel or "Monogamic" looping - B
{
local 1 "Uusimaa"
local 5 "Kanta-Häme"
local 21 "Ahvenanmaa - Åland"
foreach i of num 1 5 21{
display "`i'"
display "``i''"
display ""
}
}

// Looping with index
* probaly released in the next version



//////////////////////////////////////////////
// X Other goodies
//////////////////////////////////////////////


// X.1 First observation as variable label
*view browse "https://www.stata.com/statalist/archive/2011-09/msg01109.html"

desc, detail
{
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
}
}
desc, detail


// Finally, run the whole dofile by pressing
* Ctrl + D



















exit
//////////////////////////////////////////
// Z. Code Graveyard
//////////////////////////////////////////

//////////////////////////////////////////////
// "Looping" in R
/////////////////////////////////////////////
//Uncomment theses if already installed
*net install github, from("https://haghish.github.io/github/")
*github install haghish/rcall, stable
rcall clear
rcall

rm(list=ls())
a <- c("Romeo", "Simba", "Alladin")
b <- c("Julia", "Nala", "Esmarla")

c <- c("Ridge", "Eric", "Rick")
d <- c("Brooke", "Taylor", "Stephanie" )


(monogamy_s <- paste(a,b))
(polyamory_s <- sapply(c,function(x) paste(x,d)))


(g <- matrix(c(1,2,3),3,1))
(h <- matrix(c(4,5,6),1,3))

(monogamy_n <- h*t(g))
(polyamory_n <- g%*%h)


monogamy_s
polyamory_s
monogamy_n
polyamory_n

end

return list


