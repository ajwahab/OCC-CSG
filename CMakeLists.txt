CMAKE_MINIMUM_REQUIRED(VERSION 3.16)

project(occ-csg-prj)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

include(cmake/CreateExecutable.cmake)
include(cmake/CreateLibrary.cmake)

# Find opencascade libraries

find_package(OpenCASCADE COMPONENTS FoundationClasses REQUIRED)
find_package(OpenCASCADE COMPONENTS ModelingAlgorithms REQUIRED)
find_package(OpenCASCADE COMPONENTS ModelingData REQUIRED)
find_package(OpenCASCADE COMPONENTS DataExchange REQUIRED)
find_package(OpenCASCADE COMPONENTS Visualization REQUIRED)
include_directories(${OpenCASCADE_INCLUDE_DIR})
message("OCC-Include-Dir: ${OpenCASCADE_INCLUDE_DIR}")
link_directories(${OpenCASCADE_LIBRARY_DIR})
message("OCC-Lib-Dir: ${OpenCASCADE_LIBRARY_DIR}")
message("OCC-Libs: ${OpenCASCADE_LIBRARIES}")


include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Find openmp libraries

#find_package(OpenMP)
#if (OPENMP_FOUND)
#    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
#    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
#    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
#endif()

# Find freetype libraries on Linux (don't know why the one provided by the static occt dep doesn't work on Linux)
if(UNIX AND NOT APPLE)
    find_package(Freetype MODULE REQUIRED)
    set(FreeType ${FREETYPE_LIBRARIES})
    message("FreeType: ${FREETYPE_LIBRARIES}")

    find_path(FONTCONFIG_INCLUDE_DIRS "fontconfig/fontconfig.h")
    find_package(Fontconfig MODULE REQUIRED)

    set(FontConfig ${Fontconfig_LIBRARIES})
    message("FontConfig: ${Fontconfig_LIBRARIES}")
elseif(APPLE)
    find_package(Freetype MODULE REQUIRED)
    link_directories("/usr/local/lib")
endif()

set(CMAKE_CXX_STANDARD 20) # C++11...
set(CMAKE_CXX_STANDARD_REQUIRED ON) #...is required...
set(CMAKE_CXX_EXTENSIONS OFF) #...without compiler extensions like gnu++11

add_subdirectory(src)
