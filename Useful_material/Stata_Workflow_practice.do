/////////////////////////////
// Tips and tricks for Stata
/////////////////////////////

clear
cls


// 0.0.copy your do-file to a do-file folder so that you have a backup and can easily access all your do-files in same place

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
*Toggle all 		alt + 1 (& Win + 1 if Stata first window in the task bar)


////////////////////////////////////////////////
// 2.0 Type faster
// Try out the following commands below - Shortcut chart will be useful
////////////////////////////////////////////////


// `'
* Ctrl + ´


// ///
* Ctrl + 7


// readSHARE *, w(7) mod()
* Ctrl + .


* readSHARE setup instructions:
* view browse https://gist.github.com/samuelsaari/1ff20b8b7d70e01706f07f25f96914dc

////////////////////////////////////////////////
// 3.0 Looping strategies
////////////////////////////////////////////////

//////////////////////
// 3.1 Simple looping


{
foreach x in 1 2 3 {
di "`x'"
}
}


{
clear
sysuse bpwide
keep in 1/8
foreach x of varlist bp* {
tab `x'
}
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

// Parallel or "Monogamic" looping - C

{
local number "1 5 21"
local place `""Uusimaa" "Kanta-Häme" "Ahvenanmaa - Åland""'
forvalues i=1/3 {

            local n: word `i' of `number'

            local p: word `i' of `place'

            display `"`n' `p'"'

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

// X.2.
// Easy way to use, merge and append share data.
* just run the programme (or put it in your profile.do) and you can use it with ease as demonstrated below
* remember update 'mydirectory' and make sure that waves and releases match



////////////////////////////////////
cap nois program drop wrapper
program wrapper
    
    version 18
    
    syntax anything [ using/ ] [ if ] [ in ] [ , * ]
    
	local mydirectory ="C:/MY_DIRECTORY" // update with your path
    if ("`using'" == "") {
        
        /*
            <module> and <wave> are part of <anything>
            
            More specifically, we assume that <anything> is
            
                <command> "<module> <wave>"
                
            as in, e.g.,
            
                use "<module> <wave>"
            
            (double quotes optional)
        */
        
        gettoken command anything : anything
        gettoken module  anything : anything
        gettoken wave    anything : anything
        
        if (`"`anything'"' != "") error 198
        
        local anything `command'
        
        local using `module' `wave'
        
    }
    else local the_word_using "using"
    
    gettoken module wave_void : using
    gettoken wave        void : wave_void
    
    if ("`void'" != "") error 198
    
	capture local wave =string(`wave')
	*confirm integer number `wave'
    di "test1"
    local release = cond("`wave'"=="9", "rel0", "rel8-0-0") // update release in here
	
    
    local using "`mydirectory'/sharew`wave'_`release'_ALL_datasets_stata"
    local using "`using'/sharew`wave'_`release'_`module'.dta"
	
	display "Module: `module' | Wave: `wave'"
    display "File path: `using'"
    di "`using'"
    `anything' `the_word_using' "`using'" `if' `in' , `options'
    
end

wrapper use "dn 6", clear
wrapper merge 1:1 mergeid using "gv_health 8", keepusing(maxgrip) 
wrapper merge 1:1 mergeid using "ca 9ca", keepusing(cah006) nogenerate
wrapper merge 1:1 mergeid using "br 9", keepusing(br001_) nogenerate
wrapper append using "dn 7"



















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


