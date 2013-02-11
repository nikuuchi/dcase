include(CheckTypeSize)
include(CheckIncludeFiles)

cmake_minimum_required(VERSION 2.4)
project(kjsonq)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/kjson)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

SET(CFLAGS "-Wsign-compare -Wmissing-field-initializers -Wdisabled-optimization")
SET(CFLAGS "${CFLAGS} -Wall -Wcomment -Wformat -Wunused-macros")
SET(CMAKE_C_FLAGS         "-Wall -Wno-variadic-macros ${CFLAGS}")
SET(CMAKE_C_FLAGS_RELEASE "-O3 -g")
SET(CMAKE_C_FLAGS_DEBUG   "-O0 -g3")
string(TOUPPER ${CMAKE_BUILD_TYPE} uppercase_CMAKE_BUILD_TYPE)

if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
    add_definitions(-DNDEBUG)
endif()

set(CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	${CMAKE_CURRENT_SOURCE_DIR})

find_package(LibEvent REQUIRED)
#add_executable(jsonq ./jsonq/server.c jsonq/io.c)
#target_link_libraries(jsonq ${EVENT_LIBRARIES})
#add_executable(jsonq-client ./jsonq/jsonq-client.c jsonq/io.c)

add_executable(jsonq ./jsonq/jsonq.c jsonq/io.c)

enable_testing()
add_test(example_data0 jsonq
        ./example/data0/data000.json
        ./example/data0/commit000.json
        ./example/data0/commit001.json
        )
