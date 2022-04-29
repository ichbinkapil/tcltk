LIBNAME=tcltk

OBJS=	tcltk.o
TCLLIBS = -ltk8.0 -ltcl8.0

$(LIBNAME).so: $(OBJS)
	$(LD) $(SHLIBLDFLAGS) -o $(LIBNAME).so $(OBJS) $(TCLLIBS)


clean:
	@rm -f *.o *.so

