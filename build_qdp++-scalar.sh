#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

if [ ! -f ${SRCDIR}/qdpxx/configure ];
then
  pushd ${SRCDIR}/qdpxx
  ./autogen.sh
  popd

fi

pushd ${BUILDDIR}

if [ -d ./build_qdp++-scalar ]; 
then 
  rm -rf ./build_qdp++-scalar
fi

mkdir  ./build_qdp++-scalar
cd ./build_qdp++-scalar


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-scalar \
        --enable-parallel-arch=scalar \
	--disable-generics \
	--enable-db-lite \
	--enable-precision=single \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	${PK_OMP_ENABLE} \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install

popd
