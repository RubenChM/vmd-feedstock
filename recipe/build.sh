set -x

# Use the bin names expected in Make-arch
ln -sf $CC $BUILD_PREFIX/bin/gcc
ln -sf $CXX $BUILD_PREFIX/bin/g++

# Compiling plugins from source code
# http://www.ks.uiuc.edu/Research/vmd/plugins/doxygen/compiling.html
export TCLINC=-I$BUILD_PREFIX/include
export TCLLIB=-L$BUILD_PREFIX/lib

cd plugins
make LINUXAMD64 TCLINC="$TCLINC" TCLLIB="$TCLLIB"

export PLUGINDIR=$SRC_DIR/vmd-1.9.3/plugins
make distrib

# http://www.ks.uiuc.edu/Research/vmd/doxygen/compiling.html
cd $SRC_DIR/vmd-1.9.3/
mv LICENSE ..
# Add include paths for Tcl and Tk
export CPATH="$BUILD_PREFIX/include:$PREFIX/include:$CPATH"
export VMDINSTALLBINDIR=$PREFIX/bin
export VMDINSTALLLIBRARYDIR=$PREFIX/lib/vmd
./configure LINUXAMD64 TK TCL #NETCDF PTHREADS OPENGL OPENGLPBUFFER XINPUT COLVARS
./configure
cd src
make
make install
