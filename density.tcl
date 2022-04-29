#!/usr/bin/wish
#############################################################################
# Visual Tcl v1.10 Project
#

#################################
# GLOBAL VARIABLES
#
global bw; 
global dist; 
global kernel; 
global size; 
global widget; 

#################################
# USER DEFINED PROCEDURES
#
proc init {argc argv} {

}

init $argc $argv


proc echange {} {
global bw kernel size dist intM
switch $kernel {
    1 {set k "gaussian"}
    2 {set k "rectangular"}
    3 {set k "triangular"}
    4 {set k "cosine"}
}
R plot(density(y,bw=($bw/5)*sd(y),kernel="$k"))
R points(y,rep(0,$size))
}

proc vchange {w} {
echange
}

proc ychange {} {
global size dist 
R  if ($dist==1) y<-rnorm($size) else y<-rexp($size)
echange
}

proc main {argc argv} {
global size dist kernel bw intM
set size 50
set dist 1
set kernel 1
set bw 5
ychange
}


proc Window {args} {
global vTcl
    set cmd [lindex $args 0]
    set name [lindex $args 1]
    set newname [lindex $args 2]
    set rest [lrange $args 3 end]
    if {$name == "" || $cmd == ""} {return}
    if {$newname == ""} {
        set newname $name
    }
    set exists [winfo exists $newname]
    switch $cmd {
        show {
            if {$exists == "1" && $name != "."} {wm deiconify $name; return}
            if {[info procs vTclWindow(pre)$name] != ""} {
                eval "vTclWindow(pre)$name $newname $rest"
            }
            if {[info procs vTclWindow$name] != ""} {
                eval "vTclWindow$name $newname $rest"
            }
            if {[info procs vTclWindow(post)$name] != ""} {
                eval "vTclWindow(post)$name $newname $rest"
            }
        }
        hide    { if $exists {wm withdraw $newname; return} }
        iconify { if $exists {wm iconify $newname; return} }
        destroy { if $exists {destroy $newname; return} }
    }
}

#################################
# VTCL GENERATED GUI PROCEDURES
#

proc vTclWindow. {base} {
    if {$base == ""} {
        set base .
    }
    ###################
    # CREATING WIDGETS
    ###################
    wm focusmodel $base passive
    wm geometry $base 1x1+0+0
    wm maxsize $base 785 770
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 1 1
    wm withdraw $base
    wm title $base "vt.tcl"
    ###################
    # SETTING GEOMETRY
    ###################
}

proc vTclWindow.top17 {base} {
    if {$base == ""} {
        set base .top17
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    ###################
    # CREATING WIDGETS
    ###################
    toplevel $base -class Toplevel \
        -menu .top17.m24 
    wm focusmodel $base passive
    wm geometry $base 331x304+93+191
    wm maxsize $base 785 770
    wm minsize $base 1 1
    wm overrideredirect $base 0
    wm resizable $base 0 0
    wm deiconify $base
    wm title $base "Density"
    button $base.but24 \
	    -command {Window destroy .top17;exit}  -padx 9 -pady 3 -text Quit
    label $base.lab31 \
        -borderwidth 1 -font {Helvetica -14 bold} -foreground #ee0000 \
        -text {sample size} 
    frame $base.fra20 \
        -borderwidth 2 -height 75 -relief groove -width 125 
    radiobutton $base.fra20.rad22 \
        -command ychange -text Normal -value 1 -variable dist 
    radiobutton $base.fra20.rad23 \
        -command ychange -text Exponential -value 2 -variable dist 
    label $base.lab21 \
        -borderwidth 1 -font {Helvetica -14 bold} -foreground #ec0000 \
        -text distribution 
    frame $base.fra18 \
        -borderwidth 2 -height 75 -relief groove -width 125 
    radiobutton $base.fra18.rad19 \
        -command ychange -text 50 -value 50 -variable size 
    radiobutton $base.fra18.rad20 \
        -command ychange -text 200 -value 200 -variable size 
    radiobutton $base.fra18.rad21 \
        -command {ychange } -text 100 -value 100 -variable size 
    radiobutton $base.fra18.rad22 \
        -command ychange -text 300 -value 300 -variable size 
    menu $base.m24 \
        -cursor {} 
    label $base.lab26 \
        -borderwidth 1 -font {Helvetica -14 bold} -foreground #e80000 \
        -text kernel 
    frame $base.fra27 \
        -borderwidth 2 -height 75 -relief groove -width 125 
    radiobutton $base.fra27.rad28 \
        -command echange -text Gaussian -value 1 -variable kernel 
    radiobutton $base.fra27.rad29 \
        -command echange -text Rectangular -value 2 -variable kernel 
    radiobutton $base.fra27.rad30 \
        -command echange -text Triangular -value 3 -variable kernel 
    radiobutton $base.fra27.rad31 \
        -command echange -text Cosine -value 4 -variable kernel 
    scale $base.sca34 \
        -activebackground #d9d9d9 -command vchange -from 1.0 -orient horiz \
        -showvalue 0 -to 9.0 -variable bw 
    label $base.lab35 \
        -borderwidth 1 -font {Helvetica -14 bold} -foreground #f20000 \
        -text bandwidth 
    ###################
    # SETTING GEOMETRY
    ###################
    place $base.but24 \
        -x 145 -y 270 -anchor nw -bordermode ignore 
    place $base.lab31 \
        -x 180 -y 10 -width 136 -height 18 -anchor nw -bordermode ignore 
    place $base.fra20 \
        -x 10 -y 35 -width 155 -height 70 -anchor nw -bordermode ignore 
    place $base.fra20.rad22 \
        -x 5 -y 5 -anchor nw -bordermode ignore 
    place $base.fra20.rad23 \
        -x 5 -y 35 -anchor nw -bordermode ignore 
    place $base.lab21 \
        -x 15 -y 10 -width 151 -height 18 -anchor nw -bordermode ignore 
    place $base.fra18 \
        -x 200 -y 30 -width 110 -height 135 -anchor nw -bordermode ignore 
    place $base.fra18.rad19 \
        -x 15 -y 5 -anchor nw -bordermode ignore 
    place $base.fra18.rad20 \
        -x 15 -y 70 -anchor nw -bordermode ignore 
    place $base.fra18.rad21 \
        -x 15 -y 40 -anchor nw -bordermode ignore 
    place $base.fra18.rad22 \
        -x 15 -y 100 -anchor nw -bordermode ignore 
    place $base.lab26 \
        -x 15 -y 115 -width 146 -height 18 -anchor nw -bordermode ignore 
    place $base.fra27 \
        -x 10 -y 135 -width 155 -height 125 -anchor nw -bordermode ignore 
    place $base.fra27.rad28 \
        -x 5 -y 5 -anchor nw -bordermode ignore 
    place $base.fra27.rad29 \
        -x 5 -y 35 -anchor nw -bordermode ignore 
    place $base.fra27.rad30 \
        -x 5 -y 65 -anchor nw -bordermode ignore 
    place $base.fra27.rad31 \
        -x 5 -y 95 -anchor nw -bordermode ignore 
    place $base.sca34 \
        -x 185 -y 220 -width 131 -height 43 -anchor nw -bordermode ignore 
    place $base.lab35 \
        -x 190 -y 190 -width 116 -height 18 -anchor nw -bordermode ignore 
}

Window show .
Window show .top17

main $argc $argv


