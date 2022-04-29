# Copyright 1999 Guido Masarotto

tkeval <- function(what) .C("tk_eval",what)[[1]]

tkloop <- function() invisible(.C("tk_eventloop"))

tkreset <- function() invisible(.C("tk_reset"))

tkexit  <- function() invisible(tkeval("exit"))

tkset <- function(name,expr) {
  name <- substitute(name)
  expr <- paste(expr,collapse=" ")
  if (length(expr)>1) stop("tkset: illegal expression")
  invisible(tkeval(paste("set ",name," {",expr,"}",sep="")))
}

tkget <- function(name) tkeval(paste("list $",substitute(name),sep=""))


.tk.front.end <-function (x) {
  loc.frame <- sys.frame(sys.parent(1))
  on.exit(tkeval("exit"))
  eval(parse(text=x),loc.frame)
  on.exit()
}

.First.lib <- function(lib, pkg) {
   library.dynam("tcltk", pkg, lib)
   .C("tk_frontend",.tk.front.end)
}
















