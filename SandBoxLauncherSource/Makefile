### Begin DialogBlocks generated body
################################################################################
# Makefile generated by DialogBlocks
#
# Available configurations:
# release
################################################################################

CONFIG=release

# release
ifeq ($(CONFIG),release)
WXWIN=/home/zkat8it/Documents/wxWidgets-2.8.8
TOOLCHAINNAME=gtk2
WXVERSION:=$(shell echo `$(WXWIN)/GCCBuildReleaseGTK2/wx-config --version`)
CXX=g++
CC=gcc
RESCOMP=windres.exe
RCFILEOBJ=SandBoxLauncher_rc.o
RCFILESRC=SandBoxLauncher.rc
RESOURCEOBJECT=
OUTPUTPATH=GCCRelease
OBJECTPATH=GCCRelease
BUILDPATHS=$(OBJECTPATH)
PROGRAM=SandBoxLauncher
LIBS=`$(WXWIN)/GCCBuildReleaseGTK2/wx-config --inplace --exec-prefix="$(WXWIN)/GCCBuildReleaseGTK2" --libs`
LINKERFLAGS=
WARNINGFLAGS=-Wall
OPTFLAGS=-O
DEBUGFLAGS=
LIBPATH=
CPPINC=`$(WXWIN)/GCCBuildReleaseGTK2/wx-config --inplace --cxxflags`
GCCFLAGS=
LDFLAGS=$(LIBS) $(LIBPATH) $(LINKERFLAGS)
CPPFLAGS=$(CPPINC) $(GCCFLAGS) $(DEBUGFLAGS) $(OPTFLAGS) $(WARNINGFLAGS)
LIBDIRNAME=$(WXWIN)/GCCBuildReleaseGTK2/lib
RESPATH=--include-dir "$(WXWIN)/include" --include-dir "$(WXWIN)/contrib/include" --include-dir "$(WXWIN)/GCCBuildReleaseGTK2/lib/wx/include/gtk2-ansi-release-static-2.8"
MACPACKAGEINFO=
endif

OBJECTS=$(OBJECTPATH)/sandboxlauncher.o $(OBJECTPATH)/sandboxlauncherapp.o $(RESOURCEOBJECT)

all:	$(BUILDPATHS) $(MACPACKAGEINFO) $(OUTPUTPATH)/$(PROGRAM)

$(OBJECTPATH):
	mkdir -p $(OBJECTPATH)

clean:
	rm -f $(OBJECTPATH)/*.o
	rm -f $(OBJECTPATH)/*.res
	rm -fr .deps .pch
	rm -fr $(PROGRAM).app
	rm -f $(OUTPUTPATH)/$(PROGRAM)

help:
	@echo "Usage: make -f Makefile CONFIG=[release] [all|clean|help]"

$(OUTPUTPATH)/$(PROGRAM):	$(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDFLAGS)


# Windows only
$(OBJECTPATH)/$(RCFILEOBJ):	$(RCFILESRC)
	$(RESCOMP) --use-temp-file -i$< -o$@ $(RESPATH) --include-dir . --define NOPCH

# Mac only
$(OUTPUTPATH)/$(PROGRAM).app/Contents/PkgInfo: $(OUTPUTPATH)/$(PROGRAM) $(INFOPLISTSOURCE) $(ICNSSOURCE)
	mkdir -p $(OUTPUTPATH)/$(PROGRAM).app/Contents
	mkdir -p $(OUTPUTPATH)/$(PROGRAM).app/Contents/MacOS
	mkdir -p $(OUTPUTPATH)/$(PROGRAM).app/Contents/Resources
	sed -e "s/IDENTIFIER/$(PROGRAM)/" \
	-e "s/EXECUTABLE/$(PROGRAM)/" \
	-e "s/VERSION/$(WXVERSION)/" \
	$(INFOPLISTSOURCE) >$(OUTPUTPATH)/$(PROGRAM).app/Contents/Info.plist
	echo -n "APPL????" >$(OUTPUTPATH)/$(PROGRAM).app/Contents/PkgInfo
	ln -f $(OUTPUTPATH)/$(PROGRAM) $(OUTPUTPATH)/$(PROGRAM).app/Contents/MacOS/$(PROGRAM)
	cp -f $(ICNSSOURCE) $(ICNSDEST)

$(OBJECTPATH)/sandboxlauncher.o:	sandboxlauncher.cpp sandboxlauncher.h
	$(CXX) -c -o $@ $(CPPFLAGS) sandboxlauncher.cpp

$(OBJECTPATH)/sandboxlauncherapp.o:	sandboxlauncherapp.cpp sandboxlauncherapp.h sandboxlauncher.h
	$(CXX) -c -o $@ $(CPPFLAGS) sandboxlauncherapp.cpp

.PHONY:	all clean
### End DialogBlocks generated body
