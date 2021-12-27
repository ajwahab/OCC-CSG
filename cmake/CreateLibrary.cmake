macro(CreateLibrary)
	
	file(GLOB HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/inc/*.hpp")
	file(GLOB SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

	add_library(${PROJECT_NAME} ${SOURCES} ${HEADERS})
	target_link_libraries(${PROJECT_NAME} ${ARGN})

endmacro(CreateLibrary)
