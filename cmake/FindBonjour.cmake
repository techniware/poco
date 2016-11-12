# Locate Bonjour include paths and libraries

# This module defines
# BONJOUR_INCLUDE_DIR, where to find ptlib.h, etc.
# BONJOUR_LIBRARY, the libraries to link against to use pwlib.
# BONJOUR_FOUND, If false, don't try to use pwlib.

message(STATUS "******************************************************************* Looking for Bonjour SDK for ${HOST_ARCH} ")
	
FIND_PATH(BONJOUR_INCLUDE_DIR dns_sd.h
	"$ENV{ProgramW6432}/Bonjour SDK/Include"
)

set(HOST_ARCH "i686")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(HOST_ARCH "x86_64")  
endif()

if ( ${HOST_ARCH} MATCHES "x86_64" ) 
	message(STATUS "******************************************************************* Looking for Bonjour SDK #${HOST_ARCH}# in $ENV{ProgramW6432}")

	FIND_LIBRARY(BONJOUR_LIBRARY
		NAMES 
		    system_dnssd
			dnssd
	  PATHS
		    /usr/lib/system
			"$ENV{ProgramW6432}/Bonjour SDK/Lib/x64"
	)
	
else()
	message(STATUS "******************************************************************* Looking for Bonjour SDK in $ENV{PROGRAMFILES}")

	FIND_LIBRARY(BONJOUR_LIBRARY
	NAMES 
		    system_dnssd
			dnssd
	PATHS
		    /usr/lib/system
			"$ENV{ProgramW6432}/Bonjour SDK/Lib/Win32"
	)
endif()

# if the include a the library are found then we have it
IF(BONJOUR_INCLUDE_DIR)
  IF(BONJOUR_LIBRARY)
    SET( BONJOUR_FOUND "YES" )
  ENDIF(BONJOUR_LIBRARY)
ENDIF(BONJOUR_INCLUDE_DIR)

message(STATUS "******************************************************************* Bonjour LIB: $ENV{BONJOUR_LIBRARY}")

MARK_AS_ADVANCED(
  BONJOUR_INCLUDE_DIR
  BONJOUR_LIBRARY
) 
