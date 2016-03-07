FROM ubuntu:12.04

MAINTAINER Chris Burr

RUN apt-get update && apt-get -y install git dpkg-dev make g++ gcc binutils \
    libx11-dev libxpm-dev libxft-dev libxext-dev gfortran libssl-dev \
    libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev cfitsio-dev graphviz-dev \
    libavahi-compat-libdnssd-dev libldap2-dev python-dev libxml2-dev \
    libkrb5-dev libgsl0-dev libqt4-dev wget

# cmake is too old in the Ubuntu repositories so install a newer version
RUN wget --no-check-certificate https://cmake.org/files/v3.4/cmake-3.4.3.tar.gz && \
    tar -xf cmake-3.4.3.tar.gz && \
    cd cmake-3.4.3 && \
    ./bootstrap && \
    make && \
    make install && \
    cd .. && \
    rm -r cmake-3.4.3 cmake-3.4.3.tar.gz


# Build xrootd
RUN wget http://xrootd.org/download/v4.3.0/xrootd-4.3.0.tar.gz && \
    tar -xf xrootd-4.3.0.tar.gz && \
    mkdir build && \
    cd build && \
    cmake ../xrootd-4.3.0 -DENABLE_PERL=FALSE && \
    make && \
    make install && \
    cd .. && \
    rm -r xrootd-4.3.0 xrootd-4.3.0.tar.gz build

# Build ROOT
RUN wget --no-check-certificate https://root.cern.ch/download/root_v6.04.14.source.tar.gz && \
    tar -xf root_v6.04.14.source.tar.gz && \
    mkdir build && \
    cmake ../root-6.04.14 && \
    cmake --build . && \
    cmake --build . --target install && \
    cd .. && \
    rm -r root-6.04.14 build root_v6.04.14.source.tar.gz