\name{tcltk}
\title{A minimal R/Tcl-Tk Interface}
\usage{
tkeval(what)
tkloop()
tkexit()
tkset(tkvar,value)
tkget(tkvar)
tkreset()
}
\alias{tkeval}
\alias{tkloop}
\alias{tkexit}
\alias{tkset}
\alias{tkget}
\alias{tkreset}
\alias{tcltk}
\arguments{
    \item{what}{A R string which must be evaluated as a tcl/tk
	command (a script in the tcl jargon).}
    \item{tkvar}{Name of a tcl/tk variable.}
    \item{value}{A R expression.}
}
\description{
    tkeval(what) evaluates 'what' as a tcl/tk script. 
    The tcl interpreter has an additional command 'R some R commands'
    which let to execute R commands, e.g, 'R a<-rnorm(100)'.
    This can be used to define button's callbacks,...
    
    tkloop() enters in a tk event loop until either (i) 'exit' is
    executed by the tcl interpreter or (ii) tkexit() is
    executed by the R interpreter, tipically, in a callback invoked
    using 'R ...'.

    tkset(tkvar,value) and tkget(tkvar) can be used to set and get the
    value of a tcl/tk variable. They are rather limited (no conversions
    is done between R lists and tcl arrays (hash tables) or between R
    vectors and tcl lists). 

    tkreset() finalizes the tcl/tk interpreter. If you use, tkeval(...)
    after tkreset(), your tcl/tk commands will be  execute in a new
    tcl/tk interpreter.
}
\value{
    tkeval(what) returns the tcl value of 'what' (as a string).

    tkget(tkvar) returns the value of variable 'tkvar' in the
    tcl/tk interpreter.
}
\examples{
library(tcltk)
tkeval("wm withdraw .")
tkeval("tk_messageBox -icon question -message {R is beatiful. Isn't it?}")
tkeval("update") 
# Example built 'visually' in less then 5 minutes using Visual Tcl
# (http://www.neuron.com/stewart/vtcl). 
tkeval(paste("source",system.file("exec/density.tcl")))
tkloop()
}
\keyword{programming}
\keyword{interface}
\keyword{dynamic}











