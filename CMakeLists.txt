cmake_minimum_required(VERSION 3.5)
project(gpgpu_gameoflife)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lOpenCL")

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
configure_file(src/kernels/programs.cl kernels/programs.cl COPYONLY)

# source: http://igorbarbosa.com/articles/how-to-use-opengl-freeglut-and-cmake/
#########################################################
# FIND GLUT
#########################################################
find_package(GLUT REQUIRED)
include_directories(${GLUT_INCLUDE_DIRS})
link_directories(${GLUT_LIBRARY_DIRS})
add_definitions(${GLUT_DEFINITIONS})
if(NOT GLUT_FOUND)
    message(ERROR " GLUT not found!")
endif(NOT GLUT_FOUND)
#########################################################
# FIND OPENGL
#########################################################
find_package(OpenGL REQUIRED)
include_directories(${OpenGL_INCLUDE_DIRS})
link_directories(${OpenGL_LIBRARY_DIRS})
add_definitions(${OpenGL_DEFINITIONS})
if(NOT OPENGL_FOUND)
    message(ERROR " OPENGL not found!")
endif(NOT OPENGL_FOUND)


set(SOURCE_FILES
        src/GameOfLife.cpp
        src/kernels/programs.cl
        )
add_executable(gpgpu_gameoflife ${SOURCE_FILES})

target_link_libraries(gpgpu_gameoflife ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})