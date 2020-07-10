# Copyright 2011,2012 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Setup library
########################################################################
include(GrPlatform) #define LIB_SUFFIX

list(APPEND bt4le_sources
    packet_sink_impl.cc
    preamble_prefixer_impl.cc
    whitening_impl.cc
)

set(bt4le_sources "${bt4le_sources}" PARENT_SCOPE)
if(NOT bt4le_sources)
	MESSAGE(STATUS "No C++ sources... skipping lib/")
	return()
endif(NOT bt4le_sources)

add_library(gnuradio-bt4le SHARED ${bt4le_sources})
target_link_libraries(gnuradio-bt4le ${Boost_LIBRARIES} ${GNURADIO_RUNTIME_LIBRARIES})
target_include_directories(gnuradio-bt4le
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
    PUBLIC $<BUILD_INTERFACE:${Boost_INCLUDE_DIR}>
    PUBLIC $<INSTALL_INTERFACE:include>
  )
set_target_properties(gnuradio-bt4le PROPERTIES DEFINE_SYMBOL "gnuradio_bt4le_EXPORTS")

if(APPLE)
    set_target_properties(gnuradio-lora PROPERTIES
        INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/lib"
    )
endif(APPLE)

########################################################################
# Install built library files
########################################################################
include(GrMiscUtils)
GR_LIBRARY_FOO(gnuradio-bt4le RUNTIME_COMPONENT "bt4le_runtime" DEVEL_COMPONENT "bt4le_devel")

########################################################################
# Build and register unit test
########################################################################
include(GrTest)

include_directories(${CPPUNIT_INCLUDE_DIRS})

list(APPEND test_bt4le_sources
    ${CMAKE_CURRENT_SOURCE_DIR}/test_bt4le.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/qa_bt4le.cc
)

# Anything we need to link to for the unit tests go here
list(APPEND GR_TEST_TARGET_DEPS gnuradio-scapy_radio)

if(NOT test_foo_sources)
    MESSAGE(STATUS "No C++ unit tests... skipping")
    return()
endif(NOT test_foo_sources)

foreach(qa_file ${test_bt4l_sources})
    GR_ADD_CPP_TEST("bt4le_${qa_file}"
        ${CMAKE_CURRENT_SOURCE_DIR}/${qa_file}
    )
endforeach(qa_file)
