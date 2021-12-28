CMAKE_MINIMUM_REQUIRED(VERSION 3.16)

project(occ-csg)

set(CMAKE_CXX_STANDARD 20) # C++11...
set(CMAKE_CXX_STANDARD_REQUIRED ON) #...is required...
set(CMAKE_CXX_EXTENSIONS OFF) #...without compiler extensions like gnu++11
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

find_package(OpenCASCADE REQUIRED COMPONENTS FoundationClasses)
find_package(OpenCASCADE REQUIRED COMPONENTS ModelingAlgorithms)
find_package(OpenCASCADE REQUIRED COMPONENTS ModelingData)
find_package(OpenCASCADE REQUIRED COMPONENTS DataExchange)
find_package(OpenCASCADE REQUIRED COMPONENTS Visualization)
include_directories(${OpenCASCADE_INCLUDE_DIR})
link_directories(${OpenCASCADE_LIBRARY_DIR})
#TKPrim     # primitives, such as sphere, cone etc.
#TKBool     # boolean operators
#TKSTEP     # step file support
#TKV3d      # font support
#TKFillet   # rounded edges (fillets)
#TKGeomAlgo #
#TKMath     # math support
#TKernel    # base

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(src)

find_package(Freetype MODULE REQUIRED)

find_package(Fontconfig MODULE REQUIRED)

message("OS_SPECIFIC: ${OS_SPECIFIC}")

set(TARGET_NAME ${PROJECT_NAME})

set(TARGET_LIB "${TARGET_NAME}")
add_library(${TARGET_LIB} ${SRC_FILES} ${INC_FILES})
target_link_libraries(${TARGET_LIB}
    ${OpenCASCADE_LIBRARIES}
    ${FREETYPE_LIBRARIES}
    ${Fontconfig_LIBRARIES}
    ${OS_SPECIFIC})

set(TARGET_EXE "${PROJECT_NAME}-exe")
add_executable(${TARGET_EXE} ${SRC_FILES})
target_link_libraries(${TARGET_EXE} ${TARGET_LIB})
set_target_properties(${TARGET_EXE}
        PROPERTIES OUTPUT_NAME ${TARGET_NAME})

install(TARGETS ${TARGET_EXE} RUNTIME)
# install(TARGETS ${TARGET_LIB} LIBRARY)
